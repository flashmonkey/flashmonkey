package org.flashmonkey.flash.multiplayer.client
{
	import org.flashmonkey.flash.api.connection.IHandshake;
	import org.flashmonkey.flash.api.connection.INetConnection;
	import org.flashmonkey.flash.api.connection.ISharedObject;
	import org.flashmonkey.flash.connection.RemoteSharedObject;
	import org.flashmonkey.flash.connection.client.BasicClient;
	import org.flashmonkey.flash.multiplayer.handshake.Handshake;

	public class MultiplayerClient extends BasicClient
	{
		public function MultiplayerClient(connection:INetConnection=null, sharedObject:ISharedObject=null)
		{
			super(connection, sharedObject);
		}
		
		override protected function init():void 
		{
			super.init();
			
			sharedObject = new RemoteSharedObject("avatars", connection);
		}
		
		override protected function createHandshake():IHandshake 
		{
			return new Handshake(this);	
		}
	}
}