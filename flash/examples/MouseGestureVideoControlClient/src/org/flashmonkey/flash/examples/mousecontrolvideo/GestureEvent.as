package com.gesturelib.flash
{
	import flash.events.Event;

	public class GestureEvent extends Event
	{
		public static const GESTURE_START:String = "GestureStart";
		public static const GESTURE_COMPLETE:String = "GestureComplete";
		
		public var rawPath:Array;
		
		public var smoothedPath:Array;
		
		public var vectors:Array;
		
		public function GestureEvent(type:String, rawPath:Array = null, smoothedPath:Array = null, vectors:Array = null, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
			
			this.rawPath = rawPath;
			this.smoothedPath = smoothedPath;
			this.vectors = vectors;
		}
		
	}
}