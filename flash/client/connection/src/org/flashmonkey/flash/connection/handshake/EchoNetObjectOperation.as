package org.flashmonkey.flash.connection.handshake
{
	import flash.net.Responder;
	
	import org.flashmonkey.flash.api.connection.INetConnection;
	import org.flashmonkey.flash.utils.NetObject;
	import org.springextensions.actionscript.mvcs.service.operation.AbstractOperation;

	public class EchoNetObjectOperation extends AbstractOperation
	{
		private var _connection:INetConnection;
		
		private var _command:String;
		
		private var _object:NetObject;
		
		private var _another:int;
		
		public function EchoNetObjectOperation(connection:INetConnection, command:String, object:NetObject, i:int)
		{
			super(this);
			
			_connection = connection;
			_command = command;
			_object = object;
			_another = i;
			
			trace("setting object == " + _object);
		}
		
		override public function execute():void
		{
			trace("echoing " + _object + " " + _another + " to server on " + _connection);
			_connection.call(_command, new Responder(resultReceived, dispatchError), _object);
		}
		
		public function resultReceived(o:Object):void 
		{
			dispatchResult(this);
		}
		
	}
}