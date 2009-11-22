package {
	import com.joeberkovitz.moccasin.service.IOperation;
	import com.pblabs.engine.PBE;
	
	import flash.display.Sprite;
	import flash.events.Event;
	
	import org.flashmonkey.flash.api.AvatarType;
	import org.flashmonkey.flash.api.IAvatarService;
	import org.flashmonkey.flash.api.connection.IClient;
	import org.flashmonkey.flash.api.multiplayer.ISynchronisedAvatar;
	import org.flashmonkey.flash.core.behaviour.CompositeBehaviour;
	import org.flashmonkey.flash.core.game.AbstractGame;
	import org.flashmonkey.flash.core.game.IGame;
	import org.flashmonkey.flash.core.game.state.GameStateManager;
	import org.flashmonkey.flash.game.state.IMultiplayerGameState;
	import org.flashmonkey.flash.multiplayer.client.MultiplayerClient;
	import org.flashmonkey.flash.multiplayer.handshake.Handshake;
	import org.flashmonkey.flash.pv3d.behaviours.AnimatedDAEBehaviour;
	import org.flashmonkey.flash.pv3d.game.state.PV3DMultiplayerGameState;
	import org.flashmonkey.flash.pv3d.operations.ResolveAvatarLocationMessage;
	import org.flashmonkey.flash.pv3d.service.PaperworldAvatarService;
	import org.flashmonkey.flash.utils.input.BasicKeyboardInput;
	import org.papervision3d.objects.parsers.DAE;
	
	import org.flashmonkey.flash.pv3d.behaviours.MoveForwardBehaviour;
	import org.flashmonkey.flash.pv3d.behaviours.MoveBackwardBehaviour;
	import org.flashmonkey.flash.pv3d.behaviours.StrafeLeftBehaviour;
	import org.flashmonkey.flash.pv3d.behaviours.StrafeRightBehaviour;
	import org.flashmonkey.flash.pv3d.behaviours.RotateLeftBehaviour;
	import org.flashmonkey.flash.pv3d.behaviours.RotateRightBehaviour;
	import org.flashmonkey.flash.pv3d.behaviours.StateSettingCompositeBehaviour;

	public class MultiplayerAnimated extends Sprite
	{
		private var state:IMultiplayerGameState;
		
		private var game:IGame;
		
		private var avatarService:IAvatarService;
		
		public function MultiplayerAnimated()
		{
			PBE.startup(this);
			
			game = new AbstractGame();
			
			var client:IClient = new MultiplayerClient();
			client.defaultService = "multiplayer";
			client.handshake = new Handshake(client);
			client.handshake.addClassToRegister(ResolveAvatarLocationMessage);
			
			var connection:IOperation = client.connect("rtmp://localhost/HelloWorldMultiplayer", ["flashmonkey","password"]);
			
			state = new PV3DMultiplayerGameState("Multiplayer Demo", true);
			PV3DMultiplayerGameState(state).client = client;
			state.display.target = this;
			
			avatarService = new PaperworldAvatarService(client);
			state.avatarService = avatarService;
			
			GameStateManager.instance.attachChild(state);
			
			connection.addEventListener(Event.COMPLETE, onConnectionEstablished);
			connection.execute();
		}
		
		private function onConnectionEstablished(event:Event):void 
		{
			trace("connection established");
			
			/*var model : DAE = new DAE(false);
			model.addEventListener(FileLoadEvent.ANIMATIONS_COMPLETE, onModelLoaded);
			model.load("model/trooper/trooper-helm-skin.xml");	*/
			var properties:Object = {id: "flashmonkey"};
			var avatarOperation:IOperation = avatarService.getAvatarAsync(AvatarType.LOCAL, properties);
			avatarOperation.addEventListener(Event.COMPLETE, onAvatarReady);
			avatarOperation.execute();
		}
		
		private function onAvatarReady(e:Event):void 
		{
			trace("Avatar Ready");
			
			var operation:IOperation = IOperation(e.target);
			var avatar:ISynchronisedAvatar = ISynchronisedAvatar(operation.result);
			
			var behaviour:CompositeBehaviour = new StateSettingCompositeBehaviour();
			behaviour.addBehaviour(new AnimatedDAEBehaviour(DAE(avatar.object.displayObject)));
			behaviour.addBehaviour(new MoveForwardBehaviour());
			behaviour.addBehaviour(new MoveBackwardBehaviour());
			behaviour.addBehaviour(new StrafeRightBehaviour());
			behaviour.addBehaviour(new StrafeLeftBehaviour());
			behaviour.addBehaviour(new RotateLeftBehaviour());
			behaviour.addBehaviour(new RotateRightBehaviour());
			
			avatar.behaviour = behaviour;
			avatar.userInput = new BasicKeyboardInput(PBE.mainStage);
			
			state.addSynchronisedObject(avatar);
			
			game.start();
		}
	}
}
