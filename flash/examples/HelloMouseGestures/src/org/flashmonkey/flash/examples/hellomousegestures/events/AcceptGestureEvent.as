package org.flashmonkey.flash.examples.hellomousegestures.events
{
	import flash.events.Event;

	public class AcceptGestureEvent extends Event
	{
		public static const GESTURE_ACCEPTED:String = "GestureAccepted";
		public static const GESTURE_REJECTED:String = "GestureRejected";
		
		public var name:String;
		
		public var gesture:Array;
		
		public var path:Array;
		
		public function AcceptGestureEvent(type:String, name:String, gesture:Array, path:Array, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
			
			this.name = name;
			this.gesture = gesture;
			this.path = path;
		}
		
	}
}