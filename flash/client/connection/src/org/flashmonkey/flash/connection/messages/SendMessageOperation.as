package org.flashmonkey.flash.connection.messages
{
	import com.joeberkovitz.moccasin.service.AbstractOperation;
	
	import flash.events.ErrorEvent;
	import flash.events.Event;
	
	import org.flashmonkey.flash.api.connection.INetConnection;
	import org.flashmonkey.flash.api.connection.messages.IMessage;

	public class SendMessageOperation extends AbstractOperation
	{
		private var _message:IMessage;
		
		public function get message():IMessage
		{
			return _message;
		}
		
		private var _connection:INetConnection;
		
		public function SendMessageOperation(message:IMessage, connection:INetConnection)
		{
			super();
			
			_message = message;
			_connection = connection;
		}
		
		override public function execute():void 
		{
			_message.addEventListener(Event.COMPLETE, handleComplete);
			_message.addEventListener(ErrorEvent.ERROR, handleError);
			
			_message.write(_connection);			
		}
		
		override public function get result():*
		{
			trace("AND RETURNING: " + _message.read());
			return _message.read();
		}
		
	}
}