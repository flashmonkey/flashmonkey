package org.flashmonkey.flash.multiplayer.messages
{
	import org.flashmonkey.flash.api.IInput;
	import org.flashmonkey.flash.api.multiplayer.messages.IPlayerSyncMessage;
	import org.flashmonkey.flash.connection.messages.BaseMessage;
	import org.flashmonkey.flash.utils.input.Input;
	
	import flash.utils.IDataInput;
	import flash.utils.IDataOutput;
	
	public class PlayerSyncMessage extends BaseMessage implements IPlayerSyncMessage
	{		
		private var _objectId:String = "";
		
		public function get objectId():String
		{
			return _objectId;
		}
		
		public function set objectId(value:String):void 
		{
			_objectId = value;
		}
		
		private var _time:int;
		
		public function get time():int 
		{
			return _time;
		}
		
		public function set time(value:int):void 
		{
			_time = value;
		}
		
		private var _input:IInput;
		
		public function get input():IInput
		{
			return _input;
		}
		
		public function set input(value:IInput):void 
		{
			_input = value;
		}
		
		public function PlayerSyncMessage(objectId:String = null, time:int = 0, input:IInput = null)
		{
			super();
			
			_objectId = objectId || "";
			_time = time;
			_input = input || new Input();
		}		
		
		/**
		 * Handles serialising this object for sending across to the server.
		 */
		override public function writeExternal(output:IDataOutput):void 
		{
			super.writeExternal(output);
			
			output.writeUTF(objectId);
			output.writeInt(time);
			output.writeObject(input);
		}
		
		/**
		 * Handles deserialising this object when received from the server.
		 */
		override public function readExternal(input:IDataInput):void 
		{
			super.readExternal(input);
			
			objectId = input.readUTF();
			time = input.readInt();
			this.input = input.readObject();
		}
	}
}