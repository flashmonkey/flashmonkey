package org.flashmonkey.flash.utils.timer 
{
    public class TimedEvent extends AccurateIntervalTimer
    {
        /**
         * The event to be passed to the listener when the timer has expired.
         */
        private var event:Object;

        /**
         * Constructor.
         */
        public function TimedEvent(delay:int, repeatCount:int = 0, event:Object = null)
        {
            super(delay, repeatCount);
            this.event = event;
        }	

        /**
         * Overrides the AbstractTimer destroy method.
         */
        override public function destroy():void
        {
            event = null;
            super.destroy();
        }	
    }
}