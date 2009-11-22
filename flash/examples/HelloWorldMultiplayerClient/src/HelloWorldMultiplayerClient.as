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
	
	import org.flashmonkey.flash.api.AvatarType;
	import org.flashmonkey.flash.api.IAvatarService;
	import org.flashmonkey.flash.api.connection.IClient;
	import org.flashmonkey.flash.api.multiplayer.ISynchronisedAvatar;
	import org.flashmonkey.flash.core.game.AbstractGame;
	import org.flashmonkey.flash.core.game.IGame;
	import org.flashmonkey.flash.core.game.state.GameStateManager;
	import org.flashmonkey.flash.game.state.IMultiplayerGameState;
	import org.flashmonkey.flash.multiplayer.client.MultiplayerClient;
	import org.flashmonkey.flash.multiplayer.handshake.Handshake;
	import org.flashmonkey.flash.pv3d.game.state.PV3DMultiplayerGameState;
	import org.flashmonkey.flash.pv3d.service.PaperworldAvatarService;
	import org.flashmonkey.flash.utils.input.BasicKeyboardInput;

	public class HelloWorldMultiplayerClient extends Sprite
	{		
		private var game:IGame;
		
		private var state:IMultiplayerGameState;
		
		private var avatarService:IAvatarService;
		
		public function HelloWorldMultiplayerClient()
		{
			PBE.startup(this);
			
			var client:IClient = new MultiplayerClient();
			client.defaultService = "multiplayer";
			client.handshake = new Handshake(client);
			
			var connection:IOperation = client.connect("rtmp://localhost/HelloWorldMultiplayer", ["flashmonkey","password"]);
			
			game = new AbstractGame();

			state = new PV3DMultiplayerGameState("Multiplayer Demo", true);
			PV3DMultiplayerGameState(state).client = client;
			state.display.target = this;
			
			avatarService = new PaperworldAvatarService();
			
			state.avatarService = avatarService;
			
			GameStateManager.instance.attachChild(state);
						
			connection.addEventListener(Event.COMPLETE, onConnectionEstablished);
			connection.execute();
		}
		
		private function onConnectionEstablished(event:Event):void 
		{
			trace("connection established");

			var properties:Object = {displayObject: new ColouredCube()};
			var avatarOperation:IOperation = avatarService.getAvatarAsync(AvatarType.LOCAL, properties);
			avatarOperation.addEventListener(Event.COMPLETE, onAvatarReady);
			avatarOperation.execute();
		}
		
		private function onAvatarReady(e:Event):void 
		{
			var operation:IOperation = IOperation(e.target);
			var avatar:ISynchronisedAvatar = ISynchronisedAvatar(operation.result);
			
			avatar.userInput = new BasicKeyboardInput(PBE.mainStage);
			
			state.addSynchronisedObject(avatar);

			game.start();
		}
	}
}
