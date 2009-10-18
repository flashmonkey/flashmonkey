package org.flashmonkey.flash.api.connection.messages
{
	public interface IPlayerMessage extends IMessage
	{
		function get playerId():String;
		
		function set playerId(value:String):void;
	}
}