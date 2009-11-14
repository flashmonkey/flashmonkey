package org.flashmonkey.flash.connection.messages
{
	import flash.utils.IDataInput;
	import flash.utils.IDataOutput;
	
	import org.flashmonkey.flash.api.connection.messages.IMessage;
	
	public class BatchMessage extends BaseMessage
	{
		public override function get aliasName():String
		{
			return "org.flashmonkey.java.connection.messages.BatchMessage";
		}
		
		private var _messages:Array = [];
		
		public function get messages():Array
		{
			return _messages;
		}
		
		public function set messages(value:Array):void 
		{
			_messages = value;
		}
		
		public function BatchMessage()
		{
			super();
		}
		
		public function addMessage(message:IMessage):void 
		{
			_messages.push(message);
		}
		
		public override function read():*
		{
			for each (var message:IMessage in _messages)
			{
				message.read();
			}
		}
		
		public override function readExternal(input:IDataInput):void
		{
			super.readExternal(input);
			
			var numberOfMessages:int = input.readInt();
			trace("number of batched messages: " + numberOfMessages);
			for (var i:int = 0; i < numberOfMessages; i++)
			{
				var message:IMessage = IMessage(input.readObject());
				
				if (message != null)
				{
					_messages.push(message);
				}
			}
		}
		
		public override function writeExternal(output:IDataOutput):void
		{
			super.writeExternal(output);
			
			output.writeInt(_messages.length);
			
			for each (var message:IMessage in _messages)
			{
				output.writeObject(message);
			}
		}
	}
}