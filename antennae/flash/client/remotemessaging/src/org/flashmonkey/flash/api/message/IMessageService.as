package org.flashmonkey.flash.api.message
{
	import flash.net.NetConnection;
	
	public interface IMessageService
	{
		function get connection():NetConnection;
		
		function readMessage(message:IMessage):void;
		
		function writeMessage(message:IMessage):void;
	}
}