package org.flashmonkey.flash.utils.timer
{
	import org.flashmonkey.flash.utils.timer.events.ITimerEvent;
	
	import flash.events.TimerEvent;
	import flash.utils.getTimer;		

	/**
	 * The RacingTimer ensures that all players compete on a level playing field. By ensuring that input is 
	 * handled at a fixed rate, independant of system performance (as much as possible). So player's with faster
	 * machines won't be at an advantage over those with older spec'd machines.
	 * It does this by creating a Timer and using a variable which accumulates the changes in time between each 'tick'
	 * of the Timer. We can specify the rate at with 'Physics' events are fired - and at which 'Render' events are fired.
	 * All objects register with this class for 'Render' events rather than relying on the Event.ENTER_FRAME event.
	 * 
	 * @author Trevor Burton [trevor@infrared5.com]
	 */
	public class AccurateIntervalTimer extends AbstractTimer
	{
		/**
		 * The rate at which this object will check to see if it
		 * needs to dispatch a TimerEvent.TIMER event.
		 */
		private var _repeatRate : Number = 10;

		/**
		 * The target rate for this timer.
		 */
		private var _timestep : Number = 50;

		/**
		 * Flags whether this timer is currently paused.
		 */
		private var _paused : Boolean = false;

		/**
		 * Holds a reference to the current lifetime of the simulation.
		 */
		private var _absoluteTime : Number;

		/**
		 * 'Accumulates' delta-t - when the accumulator's value is larger than TIMESTEP we
		 * get a physics update.
		 */
		private var _accumulator : Number = 0.0;

		private var _time : int = 0;

		private var _timer : int;

		public function AccurateIntervalTimer(delay:int, repeatCount:int = 0)
		{
			super( _repeatRate, repeatCount );
			
			_timestep = delay;
		}

		/**
		 * Starts the simulation running.
		 */
		override public function start() : void 
		{			
			_absoluteTime = getTimer( );
			
			super.start();
		}

		/**
		 * Pause/Resume the simulation.
		 */
		public function set paused(value:Boolean) : void 
		{
			_paused = value;
		}

		override protected function _timerTick(e:TimerEvent) : void 
		{						
			if ( !_paused )
			{
				// find the change in time since the last tick 
				// (don't rely on the timer to be accurate)
				var newTime : Number = getTimer( );
				var deltaTime : Number = newTime - _absoluteTime;
		
				_absoluteTime = newTime;	
				_accumulator += deltaTime;
				
				// update discrete time	
				while ( _accumulator >= _timestep )
				{		        	
					// advance the simulation
					dispatchEvent( new ITimerEvent(ITimerEvent.TICK, timer.currentCount) );
		
					// advance discrete time		
					_accumulator -= _timestep;
					_time++;
				}
			}
		}
	}
}