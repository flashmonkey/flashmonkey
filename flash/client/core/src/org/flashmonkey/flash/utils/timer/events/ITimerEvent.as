package org.flashmonkey.flash.utils.timer.events
{
	import flash.events.TimerEvent;

	public class ITimerEvent extends TimerEvent
	{
		public static const TICK:String = "Tick";
		
		public var currentCount:int;
		
		public function ITimerEvent(type:String, currentCount:int, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
			
			this.currentCount = currentCount;
		}
		
	}
}