package org.flashmonkey.flash.api.multiplayer.messages
{
	import org.flashmonkey.flash.api.IState;
		
	public interface IServerSyncMessage extends IPlayerSyncMessage
	{
		function get state():IState;	
		function set state(state:IState):void;
	}
}