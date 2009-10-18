package org.flashmonkey.flash.connection
{
	import org.flashmonkey.flash.api.connection.INetConnection;
	import org.flashmonkey.flash.connection.events.Red5Event;
	
	import flash.events.NetStatusEvent;
	import flash.net.NetConnection;
	import flash.net.ObjectEncoding;

	public class Red5Connection extends NetConnection implements INetConnection
	{
		public static const CODE_CONNECT_SUCCESS 	: String = "NetConnection.Connect.Success";
		public static const CODE_CONNECT_CLOSED		: String = "NetConnection.Connect.Closed";
		public static const CODE_CONNECT_FAILED		: String = "NetConnection.Connect.Failed";
		public static const CODE_CONNECT_REJECTED	: String = "NetConnection.Connect.Rejected";
		public static const CODE_CONNECT_APPSHUTDOWN: String = "NetConnection.Connect.AppShutdown";
		public static const CODE_CONNECT_INVALIDAPP	: String = "NetConnection.Connect.InvalidApp";
		
		public static const CODE_CALL_BADVERSION	: String = "NetConnection.Call.BadVersion";
		public static const CODE_CALL_FAILED		: String = "NetConnection.Call.Failed";
		public static const CODE_CALL_PROHIBITED	: String = "NetConnection.Call.Prohibited";
		
		private var _connected	: Boolean = false;
		
		private var _rtmpURI:String;
		
		public function get rtmpURI():String 
		{
			return _rtmpURI;
		}
		
		public function set rtmpURI(value:String):void 
		{
			_rtmpURI = value;
		}
		
		private var _connectionArgs:Array;
		
		public function set connectionArgs(value:Array):void 
		{
			_connectionArgs = value;
		}
		
		public function get connectionArgs():Array 
		{
			return _connectionArgs;
		}
		
		public function Red5Connection()
		{
			super();
			
			objectEncoding = ObjectEncoding.AMF3;
			
			addEventListener(NetStatusEvent.NET_STATUS, this.onNetStatus);
		}
		
		private function onNetStatus( event:NetStatusEvent ): void
		{
			trace("Red5Connection onNetStatus() - " + event.info.code);
			var infoCode:String = event.info.code;
			
			if ( connected && !_connected && infoCode == Red5Connection.CODE_CONNECT_SUCCESS )
			{
				_connected = true;
				
				dispatchEvent( new Red5Event( Red5Event.CONNECTED ) );
			} 
			else if ( _connected && infoCode == Red5Connection.CODE_CONNECT_CLOSED )
			{
				_connected = false;
				
				dispatchEvent( new Red5Event( Red5Event.DISCONNECTED ) );
			} 
			else if ( infoCode == Red5Connection.CODE_CONNECT_REJECTED ||
						infoCode == CODE_CONNECT_APPSHUTDOWN )
			{
				_connected = false;
				
				dispatchEvent( new Red5Event( Red5Event.DISCONNECTED ) );
			} 
			else if ( infoCode == Red5Connection.CODE_CONNECT_FAILED || 
					  infoCode == Red5Connection.CODE_CONNECT_INVALIDAPP )
			{
				_connected = false;
				
				dispatchEvent( new Red5Event( Red5Event.DISCONNECTED ) );
			}
		}
	}
}