package org.flashmonkey.flash.multiplayer.handshake
{
	import com.joeberkovitz.moccasin.service.AbstractOperation;
	import org.flashmonkey.flash.api.connection.IClient;
	import org.flashmonkey.flash.api.connection.INetConnection;
	import org.flashmonkey.flash.connection.handshake.ConnectToServerOperation;
	import org.flashmonkey.flash.connection.handshake.EchoNetObjectOperation;
	import org.flashmonkey.flash.connection.messages.BaseMessage;
	import org.flashmonkey.flash.core.objects.BasicState;
	import org.flashmonkey.flash.multiplayer.messages.PlayerSyncMessage;
	import org.flashmonkey.flash.multiplayer.messages.ServerSyncMessage;
	import org.flashmonkey.flash.utils.input.Input;
	
	import org.as3commons.reflect.ClassUtils;
	import org.springextensions.actionscript.mvcs.service.operation.AsyncOperationSequence;
	
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
	public class Handshake extends AbstractOperation
	{
		private var classesToRegister:Array = [/*Input, */BasicState, BaseMessage, PlayerSyncMessage, ServerSyncMessage];
		
		private var _client:IClient;
		
		public function Handshake(client:IClient)
		{
			_client = client;
		}
		
		/**
		 * Perform the actual handshaking.
		 */
		override public function execute():void 
		{
			// Grab the NetConnection we're using to connect
			// and reset the client property to this object.
			var connection:INetConnection = _client.connection;
			connection.client = this;
			
			// Create a operation sequence.
			var opSequence:AsyncOperationSequence = new AsyncOperationSequence();
			
			// Add the connection operation.
			opSequence.addOperation(new ConnectToServerOperation(connection, connection.connectionArgs[0], connection.connectionArgs[1]));
			
			// Add an operation for each of the classes that need to be registered with the server.
			for (var i:int = 0; i < classesToRegister.length; i++)
			{
				opSequence.addOperation(new EchoNetObjectOperation(connection, "multiplayer.echo", ClassUtils.newInstance(classesToRegister[i] as Class)));
			}
			
			// Add the listeners to the operation sequence and execute the sequence.
			opSequence.addResultListener(handleComplete);
			opSequence.addErrorListener(handleError);
			opSequence.execute();
		}
		
		public function setClientID(id:String):void 
		{
			_client.id = id;
		}
	}
}