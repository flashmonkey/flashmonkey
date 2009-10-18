package org.flashmonkey.flash.connection.messages
{
	import org.flashmonkey.flash.api.connection.messages.IPlayerMessage;
	
	import flash.utils.IDataInput;
	import flash.utils.IDataOutput;

	public class BasePlayerMessage extends BaseMessage implements IPlayerMessage
	{
		private var _playerId:String;
		
		public function get playerId():String
		{
			return _playerId;
		}
		
		public function set playerId(value:String):void
		{
			_playerId = value;
		}
		
		private var _message:String;
		
		public function BasePlayerMessage(message:String)
		{
			super();
		}		
		
		override public function read():*
		{
			return String(_message);
		}

		override public function writeExternal(output:IDataOutput):void 
		{
			super.writeExternal(output);
			
			output.writeUTF(_playerId);
			output.writeUTF(_message);
		}

		override public function readExternal(input:IDataInput):void 
		{
			super.readExternal(input);
			
			_playerId = input.readUTF();
			_message = input.readUTF();
		}
	}
}