package org.flashmonkey.flash.game.state
{
	import org.flashmonkey.flash.core.game.state.IGameState;
	
	public interface IMultiplayerGameState extends IGameState
	{
		function addSynchronisedObject(o:Object):void;
	}
}