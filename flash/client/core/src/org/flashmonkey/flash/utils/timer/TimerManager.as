package org.flashmonkey.flash.utils.timer 
{
	import de.polygonal.ds.HashMap;

	public class TimerManager
    {
    	private var idArray:Array = [];
    	
    	public static const TIMER_PREFIX:String = "__timer";
    	
        /**
         * The TimerManager instance.
         */
        private static var _instance:TimerManager;

        /**
         * Hashtable containing timer id's.
         */
        private var _timers : HashMap;

		/**
         * Constructor, private to prevent instantiation.
         */
        public function TimerManager()
        {
            _timers = new HashMap();
		}

        /**
         * Return the singleton instance of the TimerManager class.
         */
        public static function get instance():TimerManager
        {
            return _instance = (_instance == null) ? new TimerManager() : _instance;
        }

        /**
         * Add a new timer, return the timer id.
         */
        private function registerTimer(timer:ITimer, name:String = null):ITimer
        {        	
        	if (name == null || name.length == 0)
        	{
        		name = TIMER_PREFIX + nextId();
        	}

            _timers.insert(name, timer);
            
            return timer;
        }

        /**
         * Start a simple timer.
         */
        public function startSimpleTimer(delay:int, name:String = null):ITimer
        {
            return startSimpleIntervalTimer(delay, 0, name);
        }

        /**
         * Start an accurate timer.
         */
        public function startAccurateTimer(delay:Number, name:String = null):ITimer
        {
            return startAccurateIntervalTimer(delay, 0, name);
        }

        /**
         * A simple timer that calls the supplied listener / method
         * at the specified interval until stopped.
         */
        public function startSimpleIntervalTimer(delay:Number, repeatCount:int = 0, name:String = null):ITimer
        {
        	var timer:ITimer = getTimerByName(name);
        	
            return timer == null ? registerTimer(new SimpleIntervalTimer(delay, repeatCount), name) : timer;
        }

        /**
         * An accurate interval timer.
         * Calls the supplied listener / method at the specified
         * interval until stopped.
         */
        public function startAccurateIntervalTimer(delay:Number, repeatCount:int = 0, name:String = null):ITimer
        {
        	var timer:ITimer = getTimerByName(name);
        	
            return timer == null ? registerTimer(new AccurateIntervalTimer(delay, repeatCount), name) : timer;
        }

        /**
         * Start a countdown timer which will continually update
         * the listener.
         */
        public function startCountdown(duration:int, rate:int, name:String = null):ITimer
        {
            var timer:CountdownTimer = new CountdownTimer(duration, rate);
            registerTimer(timer, name);
            return timer;
        }

        /**
         * Start a timed event that will call back the listener with the supplied object
         * after the specified period of time.
         */
        public function startTimedEvent(delay:int, repeatCount:int, event:Object, name:String = null):ITimer
        {
            var timer:TimedEvent = new TimedEvent(delay, repeatCount, event);
            return registerTimer(timer, name);
        }

        /**
         * Stop a indivtimer with a specific timer id.
         */
        public function stopTimerByName(name:String):void
        {
        	var timer:ITimer = _timers.find(name);
        	
        	if (timer)
        	{
        		timer.stop();
        	}	
        }
        
        public function getTimerByName(name:String):ITimer 
        {
        	if (name == null)
        	{
        		return null;
        	}
        	trace("Getting timer: " + name + " " + _timers.find(name));
        	return ITimer(_timers.find(name));
        }

        /**
         * Remove a timer from the timer id list.
         */
        public function removeTimerByName(name:String):void
        {
            _timers.remove(name);
        }

        /**
         * Stop all timers.
         */
        public function removeAllTimers():void
        {
           /* var timerKeys:Array = timers.getKeySet();
            
            for (var i:Number = 0;i < timerKeys.length; i++)
            {
                stopTimer(timerKeys[i]);
            }*/
	
            _timers.clear();
        }
        
        private function nextId():int
        {
        	if (idArray.length < 1)
        	{
        		return 0;
        	}
        	
        	for (var i:int = 0; i < idArray.length; i++)
        	{
        		if (idArray[i] == false)
        		{
        			return i;	
        		}
        	}
        	
        	var index:int = idArray.length;
        	idArray[index] = true;
        	
        	return index;
        }

        /**
         * toString.
         *//*
        public function toString():String
        {
            return "TimerManager: TimerIds " + timers.getKeySet();
        }*/
    }
}