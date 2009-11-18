package org.flashmonkey.flash.multiplayer.handshake
{
	import org.flashmonkey.flash.api.connection.IClient;
	import org.flashmonkey.flash.connection.handshake.BasicHandshake;
	import org.flashmonkey.flash.connection.messages.BaseMessage;
	import org.flashmonkey.flash.connection.messages.BatchMessage;
	import org.flashmonkey.flash.core.objects.BasicState;
	import org.flashmonkey.flash.multiplayer.messages.PlayerSyncMessage;
	import org.flashmonkey.flash.multiplayer.messages.ServerSyncMessage;
	import org.flashmonkey.flash.multiplayer.messages.SynchroniseCreateMessage;
	import org.flashmonkey.flash.utils.input.SimpleInput;
	
	/**
	 * The default handshake:
	 * 
	 * 1 - Connect to the server.
	 * 2 - Receive a unique client id from the server.
	 * 3 - Send an instance of each object that needs to be received over the wire.
	 * 
	 * Step 3 is required to ensure that objects are de/serialized correctly. If
	 * an object is sent server->client before it's been sent client->server
	 * it'll be received as an instance of [object Object] rather than [object NetObject].
	 */
	public class Handshake extends BasicHandshake
	{	
		public function Handshake(client:IClient)
		{
			super(client);
			
			classesToRegister = [SimpleInput, 
								 BasicState, 
								 BaseMessage, 
								 PlayerSyncMessage, 
								 ServerSyncMessage, 
								 SynchroniseCreateMessage, 
								 BatchMessage];
		}
	}
}