package org.flashmonkey.flash.api.multiplayer.messages
{
	import org.flashmonkey.flash.api.IInput;
	
	public interface IPlayerSyncMessage
	{
		function get objectId():String;
		function set objectId(id:String):void;
		
		function get input():IInput;	
		function set input(input:IInput):void;
	
		function get time():int;	
		function set time(time:int):void;
	}
}