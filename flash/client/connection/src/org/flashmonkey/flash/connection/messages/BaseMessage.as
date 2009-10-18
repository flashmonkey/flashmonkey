package org.flashmonkey.flash.connection.messages
{
	import org.flashmonkey.flash.api.connection.INetConnection;
	import org.flashmonkey.flash.api.connection.messages.IMessage;
	import org.flashmonkey.flash.utils.NetObject;
	
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	import flash.net.Responder;
	import flash.utils.IDataInput;
	import flash.utils.IDataOutput;
	
	import mx.rpc.events.FaultEvent;

	/**
	 * Base class for messages sent to a Red5 server using a NetConnection.
	 */
	public class BaseMessage extends NetObject implements IMessage
	{
		/**
		 * IEventDispatcher implementation used by this object.
		 * Not all NetObjects need to be event dispatchers, so any that
		 * are need to use this composition method.
		 */
		private var _eventDispatcher:IEventDispatcher = new EventDispatcher();
		
		/**
		 * Holds the object returned as a response from the server 
		 * the last time this message was successfully sent.
		 */
		private var _result:*;
		
		/**
		 * @private
		 */
		private var _senderId:String;
		
		/**
		 * The String id value of the client that originated this message.
		 */
		public function get senderId():String 
		{
			return _senderId;
		}
		
		/**
		 * @private
		 */
		public function set senderId(value:String):void 
		{
			_senderId = value;
		}		
		
		/**
		 * @private
		 */
		private var _command:String = "multiplayer.receiveMessage";
		
		/**
		 * The command invoked on the server when this message's write() method is called.
		 * 
		 * This defaults to <code>multiplayer.receiveMessage</code> which relies on the 
		 * standard paperworld setup of a service called 'multiplayer' being present in 
		 * the webapp the NetConnection is connected to.
		 */
		public function get command():String
		{
			return _command;
		}
		
		/**
		 * @private
		 */
		public function set command(value:String):void 
		{
			_command = value;
		}
		
		/**
		 * @private
		 */
		private var _responder:Responder = new Responder(onResult, onFault);
		
		/**
		 * The Responder instance used to handle responses 
		 * from the server when this message is sent.
		 */
		public function get responder():Responder 
		{
			return _responder;
		}
		
		/**
		 * @private
		 */
		public function set responder(value:Responder):void
		{
			_responder = value;
		}
		
		/**
		 * Constructor. Creates a new BaseMessage.
		 */
		public function BaseMessage()
		{
			super();
		}

		/**
		 * Write this message into the NetConnection.
		 */
		public function write(connection:INetConnection):void
		{
			connection.call(command, responder, this);
		}
		
		/**
		 * Read the response from the last time this message was sent to the server.
		 */
		public function read():*
		{
			return _result;
		}
		
		/**
		 * Called automatically when the message was successfully sent to the server.
		 */
		public function onResult(result:Object):void 
		{
			_result = result;
			
			dispatchEvent(new Event(Event.COMPLETE));
		}
		
		/**
		 * Called automatically when sending this message to the server failed.
		 */
		public function onFault(o:Object):void 
		{
			dispatchEvent(new FaultEvent(FaultEvent.FAULT));
		}
		
		/////////////////////////////////////
		// IExternalizable implementation. //
		/////////////////////////////////////
		
		/**
		 * Handles serialising this object for sending across to the server.
		 */
		override public function writeExternal(output:IDataOutput):void 
		{
			trace(senderId);
			output.writeUTF(senderId);
		}
		
		/**
		 * Handles deserialising this object when received from the server.
		 */
		override public function readExternal(input:IDataInput):void 
		{
			senderId = input.readUTF();
		}
		
		//////////////////////////////////////
		// IEventDispatcher implementation. //
		//////////////////////////////////////
		
		/**
		 * @inheritDoc
		 */
		public function addEventListener(type:String, listener:Function, useCapture:Boolean = false, priority:int = 0, useWeakReference:Boolean = false):void
		{
			_eventDispatcher.addEventListener(type, listener, useCapture, priority, useWeakReference);
		}
		
		/**
		 * @inheritDoc
		 */
		public function dispatchEvent(event:Event):Boolean
		{
			return _eventDispatcher.dispatchEvent(event);
		}
		
		/**
		 * @inheritDoc
		 */
		public function hasEventListener(type:String):Boolean
		{
			return _eventDispatcher.hasEventListener(type);
		}
		
		/**
		 * @inheritDoc
		 */
		public function removeEventListener(type:String, listener:Function, useCapture:Boolean = false):void
		{
			_eventDispatcher.removeEventListener(type, listener, useCapture);
		}
		
		/**
		 * @inheritDoc
		 */
		public function willTrigger(type:String):Boolean
		{
			return _eventDispatcher.willTrigger(type);
		}
	}
}