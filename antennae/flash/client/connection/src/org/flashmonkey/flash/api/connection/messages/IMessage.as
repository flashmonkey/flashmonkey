package org.flashmonkey.flash.api.connection.messages
{	
	import org.flashmonkey.flash.api.connection.INetConnection;
	
	import flash.events.IEventDispatcher;
		
	/**
	 * All messages sent to the server must implement this interface
	 * at some point along their inheritance chain.
	 * 
	 * The message handles sending itself using the connection held 
	 * by the client. This allows for custom call() method implementations.
	 */
	public interface IMessage extends IEventDispatcher
	{		
		/**
		 * The id of the IClient sending this message.
		 */
		function get senderId():String;
		
		/**
		 * @private
		 */
		function set senderId(value:String):void;
				
		/**
		 * Writes this messages into the connection.
		 */
		function write(connection:INetConnection):void;
		
		/**
		 * Returns the payload of the message.
		 * If this is a message sent from the server it 
		 * will return the Object that's been sent.
		 */
		function read():*;
	}
}