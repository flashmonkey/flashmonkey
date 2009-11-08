package {
	import com.joeberkovitz.moccasin.service.IOperation;
	
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.NetStatusEvent;
	
	import org.flashmonkey.flash.api.connection.IClient;
	import org.flashmonkey.flash.api.multiplayer.ISynchronisedAvatar;
	import org.flashmonkey.flash.connection.Red5Connection;
	import org.flashmonkey.flash.core.game.IGame;
	import org.flashmonkey.flash.core.game.AbstractGame;
	import org.flashmonkey.flash.core.game.state.IGameState;
	import org.flashmonkey.flash.multiplayer.avatar.LocalAvatar;
	import org.flashmonkey.flash.multiplayer.messages.ServerSyncMessage;
	import org.flashmonkey.flash.multiplayer.client.MultiplayerClient;
	import org.flashmonkey.flash.pv3d.game.state.PV3DMultiplayerGameState;
	import org.flashmonkey.flash.core.game.state.GameStateManager;
	import org.papervision3d.objects.primitives.Sphere;

	public class HelloWorldMultiplayerClient extends Sprite
	{		
		private var game:IGame;
		
		public function HelloWorldMultiplayerClient()
		{
			trace("Creation Completed");
				
			var connection:Red5Connection = new Red5Connection();
			connection.connectionArgs = ["this","that"];
			connection.rtmpURI = "rtmp://localhost/HelloWorldMultiplayer";
			
			var game:IGame = new AbstractGame();
			
			var client:IClient = new MultiplayerClient(connection);
			
			var state:IGameState = new PV3DMultiplayerGameState("Multiplayer Demo", true);
			
			state.client = client;
			
			GameStateManager.instance.attachChild(state);
			
			/*client = new BasicClient(connection);
			client.handshake = new Handshake(client);
			client.sharedObject = new RemoteSharedObject("avatars", connection);
			
			syncManager = new SynchronisationManager();
			syncManager.client = client;
			
			var syncScene:ISynchronisedScene = new SynchronisedScene(scene);
			syncManager.scene = syncScene;
			
			client.addMessageProcessor(syncManager);*/
						
			var connect:IOperation = client.connect();
			connect.addEventListener(Event.COMPLETE, onConnectionEstablished);
			connect.execute();
		}
		
		private function onNetStatus(e:NetStatusEvent):void 
		{
			trace("NetStatus: " + e.info.code);
		}
		
		private function onConnectionEstablished(event:Event):void 
		{
			trace("connection established");
			
			//var message:ServerSyncMessage = new ServerSyncMessage();
			//message.senderId = "ME!"
			//client.connection.call("multiplayer.receiveMessage", new Responder(onResponse, onFault), new Input());
			//client.connection.call("multiplayer.receiveMessage", new Responder(onResponse, onFault), new State());
			//client.connection.call("multiplayer.receiveMessage", new Responder(onResponse, onFault), message);
			//var localAvatar:ISynchronisedAvatar = new LocalAvatar();
			//var syncObject:IPaperworldObject = new PaperworldObject();
			//syncObject.displayObject = new Sphere();
			
			//localAvatar.object = syncObject;
			
			//syncManager.register(localAvatar);
		}
		
		private function onResponse(response:Object):void 
		{
			trace("response: " + response);
			
			for (var i:String in response)
			{
				trace(i + " => " + response[i]);
			}
		}
		
		private function onFault(fault:Object):void 
		{
			trace("response: " + fault);
			
			for (var i:String in fault)
			{
				trace(i + " => " + fault[i]);
			}
		}
	}
}
