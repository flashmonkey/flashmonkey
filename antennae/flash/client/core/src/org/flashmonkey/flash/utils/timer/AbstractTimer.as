package org.flashmonkey.flash.utils.timer 
{
	import flash.events.EventDispatcher;
	import flash.events.TimerEvent;
	import flash.utils.Timer;    
	public class AbstractTimer extends EventDispatcher implements ITimer
    {
    	private var _timer:Timer;
    	
    	protected function get timer():Timer 
    	{
    		return _timer;	
    	}
    	
        /**
         * Constructor, private to prevent direct instantiation.
         */
        public function AbstractTimer(delay:int, repeatCount:int = 0)
        {
        	_timer = new Timer(delay, repeatCount);
        	_timer.addEventListener(TimerEvent.TIMER, _timerTick);
        	_timer.addEventListener(TimerEvent.TIMER_COMPLETE, _timerComplete);
        }
        
        public function start():void 
        {
        	_timer.start();
        }
        
        public function stop():void 
        {
        	_timer.stop();
        }

        /**
         * Destroy any references to listeners and methods
         */
        public function destroy():void
        {		
        	stop();
        }
        
        protected function _timerTick(e:TimerEvent) : void 
        {
        	
        }
        
        protected function _timerComplete(e:TimerEvent):void 
        {
        	
        }
    }
}