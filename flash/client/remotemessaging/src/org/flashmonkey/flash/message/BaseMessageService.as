package org.flashmonkey.flash.message
{
	import flash.net.NetConnection;
	
	import org.flashmonkey.flash.api.message.IMessage;
	import org.flashmonkey.flash.api.message.IMessageService;
	
	public class BaseMessageService implements IMessageService
	{
		protected var _connection:NetConnection;
		
		public function get connection():NetConnection
		{
			return _connection;
		}
		
		public function BaseMessageService()
		{
		}
		
		public function readMessage(message:IMessage):void
		{
			message.read(this);
		}
		
		public function writeMessage(message:IMessage):void
		{
			message.write(this);
		}
	}
}