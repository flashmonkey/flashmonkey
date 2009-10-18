package org.flashmonkey.flash.api.message
{
	public interface IMessage
	{
		function read(service:IMessageService):void;
		
		function write(service:IMessageService):void;
	}
}