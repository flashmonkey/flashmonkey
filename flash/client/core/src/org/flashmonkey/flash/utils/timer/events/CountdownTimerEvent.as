package org.flashmonkey.flash.utils.timer.events
{
	public class CountdownTimerEvent extends ITimerEvent
	{
		public var timeRemaining:int;
		
		public function CountdownTimerEvent(type:String, currentCount:int, timeRemaining:int, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, currentCount, bubbles, cancelable);
			
			this.timeRemaining = timeRemaining;
		}
		
	}
}