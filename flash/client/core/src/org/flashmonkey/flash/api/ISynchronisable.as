package org.flashmonkey.flash.api
{	
	/**
	 * @author Trevor
	 */
	public interface ISynchronisable
	{
		function synchronise(time : int, input : IInput, state : IState) : void
	}
}
