package org.flashmonkey.flash.utils.clock 
{
	import org.flashmonkey.flash.utils.clock.events.ClockEvent;	

	/**
	 * @author Trevor
	 */
	public interface IClockListener 
	{
		function onTick(event : ClockEvent) : void;
	}
}
