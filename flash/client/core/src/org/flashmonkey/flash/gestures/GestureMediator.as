package org.flashmonkey.flash.gestures
{
	import flash.display.Graphics;
	import flash.display.Sprite;
	import flash.events.EventDispatcher;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	
	import org.flashmonkey.flash.gestures.util.math.Vector2;
	
	public class GestureMediator extends EventDispatcher
	{
		public static var RAW_PATH_COLOUR:int = 0xff0000;
		public static var RAW_PATH_THICKNESS:int = 5;
		public static var RAW_PATH_ALPHA:Number = 0.4;
		
		public static var SMOOTHED_PATH_COLOUR:int = 0x00ff00;
		public static var SMOOTHED_PATH_THICKNESS:int = 5;
		public static var SMOOTHED_PATH_ALPHA:Number = 0.4;
		
		/**
		 * The surface onto which the mouse gestures are being drawn.
		 */
		private var target:Sprite;
		
		/**
		 * The raw collection of Point objects generated by onMouseMove when the the user is drawing a gesture.
		 */
		private var rawPath:Array;
		
		/**
		 * The result of smoothing the path, dropping the total number of points below the allowed maximum,
		 * This is so the number of points matches the number of inputs to the neural net running on the server.
		 */
		private var _smoothedPath:Array;
		
		public function get smoothedPath():Array 
		{
			return _smoothedPath;
		}
		
		/**
		 * The normalised version of the smoothed path, the points are all normalised between -1 and 1.
		 */
		private var _vectors:Array;
		
		public function get vectors():Array 
		{
			return _vectors;
		}
		
		/**
		 * The number of points required.
		 */
		private var numberOfSmoothedPoints:int = 13;
		
		/**
		 * Constructor.
		 */
		public function GestureMediator(target:Sprite)
		{
			this.target = target;
			
			trace("TARGET: " + target);
			
			target.addEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
		}
		
		/**
		 * Utility method for adding a listener for all of the events dispatched by the GestureMediator.
		 * You can still add listeners for individual events.
		 */
		public function addListener(listener:GestureListener):void 
		{
			addEventListener(GestureEvent.GESTURE_COMPLETE, listener.onGestureComplete);
			addEventListener(GestureEvent.GESTURE_START, listener.onGestureStart);
		}
		
		/**
		 * When the mouse button is pressed, we clear all the path arrays and start listening for mouse moves.
		 */
		private function onMouseDown(e:MouseEvent):void 
		{
			trace("Mouse Down");
			
			target.removeEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
			
			rawPath = [];
			_smoothedPath = [];
			_vectors = [];
			
			target.addEventListener(MouseEvent.MOUSE_MOVE, onMouseMove);
			target.addEventListener(MouseEvent.MOUSE_UP, onMouseUp);
			
			// Inform listeners that we're starting to record a new gesture.
			dispatchEvent(new GestureEvent(GestureEvent.GESTURE_START));
		}
		
		/**
		 * When the mouse button is released, stop listening for mouse moves and try to format the path
		 * that's been created from the user's gesture.
		 */
		private function onMouseUp(e:MouseEvent):void 
		{
			target.removeEventListener(MouseEvent.MOUSE_MOVE, onMouseMove);
			target.addEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
			
			// If we have enough points...
			if (smooth())
			{
				// normalise the path.
				createVectors();
				
				// inform listeners that we've received a new valid gesture.
				dispatchEvent(new GestureEvent(GestureEvent.GESTURE_COMPLETE, rawPath, _smoothedPath, _vectors));
			}
		}
		
		/**
		 * While the mouse button is pressed - add a new Point into the raw path.
		 */
		private function onMouseMove(e:MouseEvent):void 
		{
			rawPath.push(new Point(target.mouseX, target.mouseY));
		}
		
		/**
		 * Normalise the smoothed path so all points lie within the range -1 < n < 1.
		 */
		public function createVectors():void
		{ 
			for (var i:int=1; i<_smoothedPath.length; i++)
			{    
				var x:Number = _smoothedPath[i].x - _smoothedPath[i-1].x;
				var y:Number = _smoothedPath[i].y - _smoothedPath[i-1].y;
				
				var v1:Vector2 = new Vector2(1, 0);
				var v2:Vector2 = new Vector2(x, y);
				
				v2.normalize();
				
				_vectors.push(v2.x);
				_vectors.push(v2.y);
			}
		}
		
		/**
		 * Preprocesses the mouse data into a fixed number of points.
		 */
		private function smooth():Boolean
		{
			//make sure it contains enough points for us to work with
			if (rawPath.length < numberOfSmoothedPoints)
			{
				//return
				return false;
			}

			//copy the raw mouse data
			_smoothedPath = rawPath.concat();

			//while there are excess points iterate through the points
			//finding the shortest spans, creating a new point in its place
			//and deleting the adjacent points.
			while (_smoothedPath.length > numberOfSmoothedPoints)
			{
				var shortestSoFar:Number = 99999999;
			
				var pointMarker:int = 0;
			
				//calculate the shortest span
				for (var i:int=2; i<_smoothedPath.length-1; i++)
				{
					//calculate the distance between these points
					var length:Number = 
					Math.sqrt( (_smoothedPath[i-1].x - _smoothedPath[i].x) *
					      	   (_smoothedPath[i-1].x - _smoothedPath[i].x) +
					
					     	   (_smoothedPath[i-1].y - _smoothedPath[i].y)*
					     	   (_smoothedPath[i-1].y - _smoothedPath[i].y));
				
					if (length < shortestSoFar)
					{
						shortestSoFar = length;
						pointMarker = i;
					}      
				}

				//now the shortest span has been found calculate a new point in the 
				//middle of the span and delete the two end points of the span
				var newPoint:Point = new Point();
				
				newPoint.x = (_smoothedPath[pointMarker-1].x + 
				              _smoothedPath[pointMarker].x)/2;
				
				newPoint.y = (_smoothedPath[pointMarker-1].y +
				              _smoothedPath[pointMarker].y)/2;
				
				_smoothedPath[pointMarker-1] = newPoint;
				
				//smoothedPath.erase(m_vecSmoothPath.begin() + PointMarker);
				_smoothedPath.splice(pointMarker, 1);
			}

  			return true;
		}
		
		public function draw(g:Graphics):void 
		{
			trace("Drawing " + rawPath + " " + _smoothedPath);
			
			drawRawPath(g);
			drawSmoothedPath(g);
		}
		
		public function drawRawPath(g:Graphics):void 
		{
			drawPath(g, rawPath, RAW_PATH_COLOUR, RAW_PATH_THICKNESS, RAW_PATH_ALPHA);
		}
		
		public function drawSmoothedPath(g:Graphics):void
		{
			drawPath(g, _smoothedPath, SMOOTHED_PATH_COLOUR, SMOOTHED_PATH_THICKNESS, SMOOTHED_PATH_ALPHA);
		}
		
		public function drawPath(graphics:Graphics, path:Array, colour:int, thickness:int, alpha:Number):void 
		{	
			graphics.lineStyle(thickness, colour, alpha);
			
			var firstPoint:Point = Point(path[0]);
			
			graphics.moveTo(firstPoint.x, firstPoint.y);
			
			for (var i:int = 1; i < path.length; i++)
			{
				var point:Point = Point(path[i]);
				
				graphics.lineTo(point.x, point.y);
			}
		}
	}
}