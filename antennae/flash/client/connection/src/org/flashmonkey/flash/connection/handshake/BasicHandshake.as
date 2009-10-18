package org.flashmonkey.flash.connection.handshake
{
	import com.joeberkovitz.moccasin.service.AbstractOperation;
	import org.flashmonkey.flash.api.connection.IClient;
	import org.flashmonkey.flash.api.connection.INetConnection;
	
	import org.springextensions.actionscript.mvcs.service.operation.IOperation;
	
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
	public class BasicHandshake extends AbstractOperation
	{
		private var _client:IClient;
		
		public function BasicHandshake(client:IClient)
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
						
			// Add the connection operation.
			var connectionOp:IOperation = new ConnectToServerOperation(connection, connection.connectionArgs[0], connection.connectionArgs[1]);
			
			// Add the listeners to the operation sequence and execute the sequence.
			connectionOp.addResultListener(handleComplete);
			connectionOp.addErrorListener(handleError);
			connectionOp.execute();
		}
		
		public function setClientID(id:String):void 
		{
			trace("Setting client id: " + _client + " " + id);
			_client.id = id;
		}
	}
}