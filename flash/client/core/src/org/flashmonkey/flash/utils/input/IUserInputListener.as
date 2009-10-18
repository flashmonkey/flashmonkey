package org.flashmonkey.flash.utils.input
{
	import org.flashmonkey.flash.utils.input.events.UserInputEvent;		

	/**
	 * @author Trevor
	 */
	public interface IUserInputListener 
	{
		function onInputUpdate(event : UserInputEvent) : void;
	}
}
