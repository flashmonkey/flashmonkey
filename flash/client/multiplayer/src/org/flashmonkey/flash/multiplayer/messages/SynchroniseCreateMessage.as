package org.flashmonkey.flash.multiplayer.messages
{
	import org.flashmonkey.flash.api.IInput;
	import org.flashmonkey.flash.api.IState;
	import org.flashmonkey.flash.api.multiplayer.messages.ISynchroniseCreateMessage;
	import org.flashmonkey.flash.connection.messages.BaseMessage;
	import org.flashmonkey.flash.core.objects.BasicState;
	import org.flashmonkey.flash.utils.input.Input;
	
	import flash.utils.IDataInput;
	import flash.utils.IDataOutput;
	
	/**
	 * Represents a message from the server telling the client to create a new
	 * object that will be synchronised with its server-side counterpart.
	 */
	public class SynchroniseCreateMessage extends BaseMessage implements ISynchroniseCreateMessage
	{		
		/**
		 * @private
		 */
		private var _playerId:String;
		
		/**
		 * The id of the player who owns this object.
		 */
		public function get playerId():String 
		{
			return _playerId;
		}
		
		/**
		 * @private
		 */
		public function set playerId(value:String):void 
		{
			_playerId = value;
		}
		
		/**
		 * @private
		 */
		private var _objectId:String;
		
		/**
		 * The id of the object to be created.
		 */
		public function get objectId():String 
		{
			return _objectId;
		}
		
		/**
		 * @private
		 */
		public function set objectId(value:String):void 
		{
			_objectId = value;
		}
		
		/**
		 * @private
		 */
		private var _input:IInput = new Input();
		
		/**
		 * The initial input state for the new object.
		 */
		public function get input():IInput
		{
			return _input;
		}
		
		/**
		 * @private
		 */
		public function set input(value:IInput):void 
		{
			_input = input;
		}
		
		/**
		 * @private
		 */
		private var _state:IState = new BasicState();
		
		/**
		 * The initial state for this object.
		 */
		public function get state():IState
		{
			return _state;
		}
		
		/**
		 * @private
		 */
		public function set state(value:IState):void 
		{
			_state = value;
		}
		
		/**
		 * Creates a new SynchroniseCreateMessage.
		 */
		public function SynchroniseCreateMessage()
		{
			super();
		}
		
		/**
		 * @inheritDoc
		 */
		override public function writeExternal(output:IDataOutput):void
		{
			super.writeExternal(output);
			
			output.writeUTF(playerId);
			output.writeUTF(objectId);
			
			output.writeObject(this.input);
			output.writeObject(state);
		}
		
		/**
		 * @inheritDoc
		 */
		override public function readExternal(input:IDataInput):void
		{
			super.readExternal(input);
			
			playerId = input.readUTF();
			objectId = input.readUTF();
			
			this.input = input.readObject();
			state = input.readObject();
		}
	}
}