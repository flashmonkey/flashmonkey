package org.flashmonkey.flash.multiplayer.messages
{
	import org.flashmonkey.flash.api.multiplayer.messages.IServerSyncMessage;
	import org.flashmonkey.flash.api.IState;
	import org.flashmonkey.flash.core.objects.BasicState;
	import flash.utils.IDataInput;
	import flash.utils.IDataOutput;
	
	public class ServerSyncMessage extends PlayerSyncMessage implements IServerSyncMessage
	{
		private var _state:IState = new BasicState();
		
		public function get state():IState
		{
			return _state;
		}
		
		public function set state(value:IState):void
		{
			_state = value;
		}
		
		public function ServerSyncMessage()
		{
			super();
		}
		
		/**
		 * Handles serialising this object for sending across to the server.
		 */
		override public function writeExternal(output:IDataOutput):void 
		{
			super.writeExternal(output);
			
			output.writeObject(state);
		}
		
		/**
		 * Handles deserialising this object when received from the server.
		 */
		override public function readExternal(input:IDataInput):void 
		{
			trace("REading external");
			super.readExternal(input);
			
			state = input.readObject();
		}
	}
}