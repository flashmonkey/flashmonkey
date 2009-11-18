package {
	import com.joeberkovitz.moccasin.service.IOperation;
	import com.pblabs.engine.PBE;
	
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.NetStatusEvent;
	import flash.net.NetConnection;
	import flash.net.ObjectEncoding;
	import flash.net.SharedObject;
	import flash.utils.ByteArray;
	
	import org.flashmonkey.flash.api.connection.IClient;
	import org.flashmonkey.flash.connection.Red5Connection;
	import org.flashmonkey.flash.core.game.AbstractGame;
	import org.flashmonkey.flash.core.game.IGame;
	import org.flashmonkey.flash.core.game.state.GameStateManager;
	import org.flashmonkey.flash.core.game.state.IGameState;
	import org.flashmonkey.flash.game.state.IMultiplayerGameState;
	import org.flashmonkey.flash.multiplayer.client.MultiplayerClient;
	import org.flashmonkey.flash.pv3d.game.state.PV3DMultiplayerGameState;
	import org.papervision3d.objects.primitives.Sphere;

	public class HelloWorldMultiplayerClient extends Sprite
	{		
		private var game:IGame;
		
		private var state:IGameState;
		
		public function HelloWorldMultiplayerClient()
		{
			trace("Creation Completed");
			
			NetConnection.defaultObjectEncoding = ObjectEncoding.AMF3;
			ByteArray.defaultObjectEncoding = ObjectEncoding.AMF3;
			SharedObject.defaultObjectEncoding = ObjectEncoding.AMF3;
			
			PBE.startup(this);
				
			var connection:Red5Connection = new Red5Connection();
			connection.connectionArgs = ["this","that"];
			connection.rtmpURI = "rtmp://localhost/HelloWorldMultiplayer";
			
			var game:IGame = new AbstractGame();
			
			var client:IClient = new MultiplayerClient(connection);
			client.defaultService = "multiplayer";
			
			state = new PV3DMultiplayerGameState("Multiplayer Demo", true);
			PV3DMultiplayerGameState(state).client = client;
			state.display.target = this;
			
			GameStateManager.instance.attachChild(state);
			
			game.start();
			
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
			
			var localObj:Sphere = new Sphere();
			
			IMultiplayerGameState(state).addSynchronisedObject(localObj);
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
