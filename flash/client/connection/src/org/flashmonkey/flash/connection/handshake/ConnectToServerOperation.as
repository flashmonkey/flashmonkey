package org.flashmonkey.flash.connection.handshake
{
	import org.flashmonkey.flash.api.connection.INetConnection;
	import org.flashmonkey.flash.connection.events.Red5Event;
	
	import org.springextensions.actionscript.mvcs.service.operation.AbstractOperation;

	public class ConnectToServerOperation extends AbstractOperation
	{
		private var _connection:INetConnection;
		
		private var _username:String;
		
		private var _password:String;
		
		public function ConnectToServerOperation(connection:INetConnection, username:String, password:String)
		{
			super(this);
			
			_connection = connection;
			_username = username;
			_password = password;
		}
		
		override public function execute():void
		{
			trace("connecting to server");
			_connection.addEventListener(Red5Event.CONNECTED, dispatchResult);
			_connection.addEventListener(Red5Event.REJECTED, dispatchError);
			_connection.connect(_connection.rtmpURI, _username, _password);
		}
		
	}
}