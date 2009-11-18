package org.flashmonkey.flash.examples.hellomousegestures
{
	import com.joeberkovitz.moccasin.service.IOperation;
	
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.display.Graphics;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.geom.Matrix;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	
	import mx.containers.Canvas;
	import mx.controls.Button;
	import mx.controls.HorizontalList;
	import mx.controls.Text;
	import mx.core.WindowedApplication;
	import mx.events.FlexEvent;
	import mx.managers.PopUpManager;
	
	import org.flashmonkey.flash.api.connection.messages.IMessage;
	import org.flashmonkey.flash.connection.client.BasicClient;
	import org.flashmonkey.flash.examples.hellomousegestures.components.NewGestureDialog;
	import org.flashmonkey.flash.examples.hellomousegestures.components.logic.GestureEntry;
	import org.flashmonkey.flash.examples.hellomousegestures.events.AcceptGestureEvent;
	import org.flashmonkey.flash.examples.hellomousegestures.messages.RecogniseGestureMessage;
	import org.flashmonkey.flash.gestures.GestureEvent;
	import org.flashmonkey.flash.gestures.GestureListener;
	import org.flashmonkey.flash.gestures.GestureMediator;

	public class Main extends WindowedApplication implements GestureListener
	{   
        public static const LEARNING:int = 0;
		public static const ACTIVE:int = 1;
		public static const UNREADY:int = 2;
		public static const TRAINING:int = 3;
		
		private var mode:int = ACTIVE;
		
		public var drawingCanvas:Canvas;
		
		private var newGestureDialog:NewGestureDialog
		
		public var gestureOutput:Text;
		
		public var newGestureButton:Button;
		
		private var lastGesture:Array;
		
		public var acceptGestureButton:Button;
		
		public var rejectGestureButton:Button;
				
		public var horizontalList:HorizontalList;
		
		private var gestureMediator:GestureMediator;
		
		private var _client:BasicClient;
		
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
		}
		
		private function onConnectionComplete(e:Event):void 
		{
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
			
			for (var i:int = 0; i < gestureListProvider.length; i++)
			{
				var entry:Object = gestureListProvider[i];
				
				if (entry.label == gesture)
				{
					horizontalList.selectedIndex = i;
					horizontalList.horizontalScrollPosition = i;
				}
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
					
				case LEARNING:
					lastGesture = e.vectors;
					drawGesture(e);
					acceptGestureButton.visible = rejectGestureButton.visible = true;
					break;
					
				default:
					break;
			}
		}
		
		protected function onNewGestureClick():void 
		{
			mode = LEARNING;
			
			showNewGestureDialog();
		}
		
		private function drawGesture(e:GestureEvent):void 
		{
			gestureMediator.draw(drawingCanvas.graphics);
		}
		
		private function showNewGestureDialog():void 
		{
			newGestureDialog = new NewGestureDialog();
			
			newGestureDialog.addEventListener(AcceptGestureEvent.GESTURE_ACCEPTED, onGestureAccepted);
			newGestureDialog.addEventListener(AcceptGestureEvent.GESTURE_REJECTED, onGestureRejected);
			
			PopUpManager.addPopUp(newGestureDialog, this, true);
			
			newGestureDialog.x = (stage.stageWidth - newGestureDialog.width) / 2;
			newGestureDialog.y = (stage.stageHeight - newGestureDialog.height) / 2;
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
		
		protected function onGestureAccepted(e:AcceptGestureEvent):void
		{
			var source:MovieClip = new MovieClip();

			gestureMediator.drawPath(source.graphics, e.path, 0x000000, 5, 1);
			
			var yRatio:Number = 100 / source.height;
			var xRatio:Number = 100 / source.width;
			
			var ratio:Number = Math.min(yRatio, xRatio);
			
			var target:Sprite = new Sprite();
			var bounds:Rectangle = source.getBounds(source);
			DrawOntoGraphics(source, target.graphics, new Point(-bounds.x, -bounds.y));
			target.scaleX = target.scaleY = ratio;
			var entry:GestureEntry = new GestureEntry();
			entry.label = e.name;
			entry.thumbnailImage = target;
			
			gestureListProvider.push(entry);
			
			horizontalList.dataProvider = gestureListProvider;
			
			reset();
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

		
		protected function onGestureRejected():void 
		{
			reset();
		}
		
		private function reset():void
		{			
			mode = ACTIVE;
		}
	}
}