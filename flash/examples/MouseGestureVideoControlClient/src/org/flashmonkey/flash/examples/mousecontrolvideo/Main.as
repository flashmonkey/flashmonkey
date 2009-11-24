package org.flashmonkey.flash.examples.mousecontrolvideo
{
	import com.joeberkovitz.moccasin.service.IOperation;
	
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.display.Graphics;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.geom.Matrix;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.media.Video;
	import flash.net.NetConnection;
	import flash.net.NetStream;
	import flash.utils.getTimer;
	
	import mx.containers.Canvas;
	import mx.controls.Button;
	import mx.controls.HorizontalList;
	import mx.controls.Text;
	import mx.core.Application;
	import mx.events.FlexEvent;
	
	import org.flashmonkey.flash.api.connection.messages.IMessage;
	import org.flashmonkey.flash.connection.client.BasicClient;
	import org.flashmonkey.flash.examples.mousecontrolvideo.messages.RecogniseGestureMessage;
	import org.flashmonkey.flash.gestures.GestureEvent;
	import org.flashmonkey.flash.gestures.GestureListener;
	import org.flashmonkey.flash.gestures.GestureMediator;

	public class Main extends Application implements GestureListener
	{   
        public static const LEARNING:int = 0;
		public static const ACTIVE:int = 1;
		public static const UNREADY:int = 2;
		public static const TRAINING:int = 3;
		
		private var mode:int = ACTIVE;
		
		public var drawingCanvas:Canvas;
		
		public var gestureOutput:Text;
		
		public var newGestureButton:Button;
		
		private var lastGesture:Array;
		
		public var acceptGestureButton:Button;
		
		public var rejectGestureButton:Button;
				
		public var horizontalList:HorizontalList;
		
		private var gestureMediator:GestureMediator;
		
		private var _netStream:NetStream;
		
		private var _video:Video;
		
		private var _client:BasicClient;
		
		private var _streamName:String = "20051210-w50s";
		
		private var _currentTime:int;
		
		[Bindable]
		public var gestureListProvider:Array;

		public function Main()
		{
			super();
			
			addEventListener(FlexEvent.APPLICATION_COMPLETE, onApplicationComplete);
		}
		
		private function onApplicationComplete(e:FlexEvent):void 
		{
			removeEventListener(FlexEvent.APPLICATION_COMPLETE, onApplicationComplete);
			
			createConnection();
		}
		
		private function createConnection():void 
		{
			  _client = new BasicClient();
			  _client.handshake.addClassToRegister(RecogniseGestureMessage);
			  var connectionOperation:IOperation = _client.connect("rtmp://localhost/MouseGestureVideoControl", ["flashmonkey", "password"]);
			  connectionOperation.addEventListener(Event.COMPLETE, onConnectionComplete);
			  connectionOperation.execute();
			  
			  _video = new Video();
			 // rawChildren.addChild(_video);
		}
		
		private function onConnectionComplete(e:Event):void 
		{
			_netStream = new NetStream(NetConnection(_client.connection));
			_netStream.client = this;
			_video.attachNetStream(_netStream);
			_netStream.play(_streamName);
				
			gestureMediator = new GestureMediator(drawingCanvas);
			gestureMediator.addListener(this);
		}
		
		private function sendGesture(gesture:Array):void
		{
			var message:IMessage = new RecogniseGestureMessage(gesture);
			message.addEventListener(Event.COMPLETE, onGestureRecognitionComplete);
			message.write(_client.connection);
		}
		
		private function onGestureRecognitionComplete(e:Event):void 
		{
			receiveGesture(RecogniseGestureMessage(e.target).gestureName);
		}
		
		public function receiveGesture(gesture:String):void
		{			
			trace("receiving gesture: " + gesture);
			
			_currentTime = getTimer();
			
			switch (gesture)
			{
				case "right arrow":
					//fastForward();
					break;
					
				case "left arrow":
					//rewind();
					break;
					
				default:
					break;
			}
		}
		
		public function onGestureStart(e:GestureEvent):void
		{			
			drawingCanvas.graphics.clear();
		}
		
		public function onGestureComplete(e:GestureEvent):void
		{				
			switch (mode)
			{
				case ACTIVE:
					drawGesture(e);
					sendGesture(e.vectors);
					break;
					
				default:
					break;
			}
		}
		
		private function drawGesture(e:GestureEvent):void 
		{
			gestureMediator.draw(drawingCanvas.graphics);
		}
		
		private function drawPath(graphics:Graphics, path:Array, colour:int):void 
		{	
			graphics.lineStyle(5, colour);
			
			var firstPoint:Point = Point(path[0]);
			
			graphics.moveTo(firstPoint.x, firstPoint.y);
			
			for (var i:int = 1; i < path.length; i++)
			{
				var point:Point = Point(path[i]);
				
				graphics.lineTo(point.x, point.y);
			}
		}
		
		private static function DrawOntoGraphics(source:MovieClip, target:Graphics, position:Point = null):void 
		{
		    position = position == null ? new Point() : position;

	        var bounds : Rectangle = DisplayObject(source).getBounds(DisplayObject(source));
	        var bitmapData : BitmapData = new BitmapData(bounds.width, bounds.height, true, 0x00000000);
	
	        bitmapData.draw(source, new Matrix(1, 0, 0, 1, -bounds.x, -bounds.y), null, null, null, true);
	        target.beginBitmapFill(bitmapData, new Matrix(1, 0, 0, 1, bounds.x + position.x, bounds.y + position.y));
	        target.drawRect(bounds.x + position.x, bounds.y + position.y, bounds.width, bounds.height);
			target.endFill();
		}
		
		private function reset():void
		{			
			mode = ACTIVE;
		}
		
		public function onMetaData(o:Object):void 
		{
			trace(o);
		}
	}
}