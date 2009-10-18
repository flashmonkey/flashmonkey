package org.flashmonkey.flash.utils.timer
{
	import flash.events.IEventDispatcher;

	public interface ITimer extends IEventDispatcher
	{		
		/**
		 * Start the timer.
		 */
		function start():void;
		
		/**
		 * Stop the timer.
		 */
		function stop():void;
		
		/**
		 * Destroy 
		 */
		function destroy():void;
	}
}