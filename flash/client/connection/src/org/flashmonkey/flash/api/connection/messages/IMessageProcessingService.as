package org.flashmonkey.flash.api.connection.messages
{
	import org.flashmonkey.flash.utils.IProcessor;
	
	import flash.events.IEventDispatcher;
	
	public interface IMessageProcessingService extends IEventDispatcher
	{
		function receiveMessage(message:IMessage):void;
		
		function addMessageProcessor(processor:IProcessor):void;
	}
}