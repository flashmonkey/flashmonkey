package org.flashmonkey.flash.game.state
{
	import org.flashmonkey.flash.api.multiplayer.ISynchronisedAvatar;
	import org.flashmonkey.flash.core.game.state.IGameState;
	
	public interface IMultiplayerGameState extends IGameState
	{
		function addSynchronisedObject(avatar:ISynchronisedAvatar):void;
	}
}