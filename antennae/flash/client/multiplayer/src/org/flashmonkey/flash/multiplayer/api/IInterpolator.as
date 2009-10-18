package org.flashmonkey.flash.multiplayer.api
{
	import org.flashmonkey.flash.api.IState;					
	
	/**
	 * @author Trevor
	 */
	public interface IInterpolator 
	{
		function interpolate(from : IState, to : IState, tightness : Number) : void
	}
}
