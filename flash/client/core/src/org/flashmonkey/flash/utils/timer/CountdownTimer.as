package org.flashmonkey.flash.utils.timer 
{ 

	public class CountdownTimer extends AccurateIntervalTimer
	{
		/**
		 * Constructor.
		 */
		public function CountdownTimer(duration:int, rate:int)
		{
			super(0, 0);
		}
	
		/**
		 * Update the timer with the number of milliseconds remaining.
		 * Pass the re-syncronished countdown time to listener.
		 */
		public function synchroniseTimer(milliseconds:Number):void
		{
			//setEndTime(milliseconds);
			update();
		}
	
		/**
		 * Self update - allows clock resyncronisation.
		 * Inform listener of time remaining.
		 * Forward to parent class to check against endtime.
		 */
		public function update():void
		{
			//CountdownTimerListener(listener).updateTime(getTimeRemaining());
			//super.update();
		}
	}
}