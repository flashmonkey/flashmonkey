package org.flashmonkey.flash.multiplayer.messages
{
	import org.flashmonkey.flash.connection.messages.BaseMessage;
	
	import flash.utils.IDataInput;
	import flash.utils.IDataOutput;
	
	public class BatchedInputMessage extends BaseMessage
	{		
		private var _messages:Array = [];
		
		public function set messages(value:Array):void 
		{
			_messages = value;
		}
		
		public function BatchedInputMessage()
		{
			super();
		}
		
		override public function readExternal(input:IDataInput):void
		{
			super.readExternal(input);
			
			var length:int = input.readInt();
			
			for (var i:int = 0; i < length; i++)
			{
				_messages.push(input.readObject());
			}
		}
		
		override public function writeExternal(output:IDataOutput):void 
		{
			super.writeExternal(output);
		
			output.writeInt(_messages.length);
			
			for (var i:int = 0; i < _messages.length; i++)
			{
				output.writeObject(_messages[i]);
			}
		}
		
	}
}