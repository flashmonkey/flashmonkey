package org.flashmonkey.flash.connection
{
	import org.flashmonkey.flash.api.connection.INetConnection;
	import org.flashmonkey.flash.api.connection.ISharedObject;
	import org.flashmonkey.flash.connection.events.Red5Event;
	
	import flash.events.AsyncErrorEvent;
	import flash.events.EventDispatcher;
	import flash.events.NetStatusEvent;
	import flash.events.SyncEvent;
	import flash.net.NetConnection;
	import flash.net.SharedObject;

	public class RemoteSharedObject extends EventDispatcher implements ISharedObject
	{
		private var _persistent:Boolean;
		
		public function get persistent():Boolean
		{
			return _persistent;
		}
		
		public function set persistent(value:Boolean):void 
		{
			_persistent = value;
		}
		
		private var _secure:Boolean;
		
		public function get secure():Boolean
		{
			return _secure;
		}
		
		public function set secure(value:Boolean):void 
		{
			_secure = value;
		}
		
		private var _connection:INetConnection;
		
		public function get connection():INetConnection
		{
			return _connection;
		}
		
		public function set connection(value:INetConnection):void 
		{
			if (value != null)
			{
				_connection = value;
				
				if( connection.connected ) 
				{
					connect( connection );
				} 
				else 
				{
					connection.addEventListener( Red5Event.CONNECTED, onConnectionConnected );
					connection.addEventListener( Red5Event.DISCONNECTED, onConnectionDisconnected );
				}
			}
		}
		
		private var _name:String;
		
		public function get name():String 
		{
			return _name;
		}
		
		public function set name(value:String):void 
		{
			_name = value;
		}
		
		private var _sharedObject:SharedObject;
		
		public function get sharedObject():SharedObject
		{
			return _sharedObject;
		}
		
		public function set sharedObject(value:SharedObject):void 
		{
			_sharedObject = value;
		}
		
		public function RemoteSharedObject(name:String, connection:INetConnection, persistent:Boolean = false, secure:Boolean = false )
		{
			super(this);
			
			this.name = name;
			this.persistent = persistent;
			this.secure = secure;
			this.connection = connection;
		}
		
		private function connect( value:INetConnection, params:String='' ):void
		{
			sharedObject = SharedObject.getRemote( name, connection.rtmpURI, persistent, secure )
			sharedObject.connect( NetConnection(value) );
			sharedObject.addEventListener(NetStatusEvent.NET_STATUS, onNetStatus);
			sharedObject.addEventListener(SyncEvent.SYNC, onSync);
			sharedObject.addEventListener(AsyncErrorEvent.ASYNC_ERROR, onAsyncError);
		}
		
		private function onNetStatus(event:NetStatusEvent) : void 
		{
			dispatchEvent(event);
		}
		
		private function onSync(event:SyncEvent) : void 
		{
			dispatchEvent(event);
		}
		
		private function onAsyncError(event:AsyncErrorEvent) : void 
		{
			dispatchEvent(event);
		}
		
		private function onConnectionConnected( value:Red5Event ):void
		{
			connect( connection );
		}
		
		private function onConnectionDisconnected( value:Red5Event ):void
		{
			
		}
	}
}