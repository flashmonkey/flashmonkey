package org.flashmonkey.flash.pv3d.game.state
{
	import org.flashmonkey.flash.api.IAvatarService;
	import org.flashmonkey.flash.api.connection.IClient;
	import org.flashmonkey.flash.api.multiplayer.ISynchronisedAvatar;
	import org.flashmonkey.flash.api.multiplayer.ISynchronisedScene;
	import org.flashmonkey.flash.game.state.IMultiplayerGameState;
	import org.flashmonkey.flash.multiplayer.sync.SynchronisationManager;
	import org.flashmonkey.flash.pv3d.scenes.SynchronisedScene;
	import org.flashmonkey.flash.pv3d.service.PaperworldAvatarService;
	import org.papervision3d.scenes.Scene3D;
	
	public class PV3DMultiplayerGameState extends PV3DGameState implements IMultiplayerGameState
	{
		protected var _syncScene:ISynchronisedScene;
		
		protected var _syncManager:SynchronisationManager;
		
		protected var _client:IClient;
		
		public override function set avatarService(value:IAvatarService):void 
		{
			super.avatarService = value;
			
			if (_syncManager)
			{
				_syncManager.avatarService = _avatarService;
			}
		}
		
		public function set client(value:IClient):void
		{
			_client = value;
			
			if (_syncManager)
			{
				_syncManager.client = _client;
				_client.addMessageProcessor(_syncManager);
			}
		}
		
		/**
		 * TODO: Remove the dedicated 'multiplayer' state and let the normal state be flagged as
		 * multiplayer/synchronised or not. If it's flagged as synchronised (or a synchronised object
		 * is added) then the sync manager is created and used for synchronisation.
		 */
		public function PV3DMultiplayerGameState(name:String, active:Boolean=false)
		{
			super(name, active);
		}
		
		override protected function init():void
		{
			super.init();
			
			avatarService = new PaperworldAvatarService();
			
			_syncScene = createSynchronisedScene();
			_syncManager = createSynchronisationManager();
		}
		
		protected function createSynchronisedScene():ISynchronisedScene
		{
			return new SynchronisedScene(Scene3D(_display.scene));
		}
		
		protected function createSynchronisationManager():SynchronisationManager
		{
			var syncManager:SynchronisationManager = new SynchronisationManager();
			syncManager.scene = _syncScene;
			
			if (_avatarService)
			{
				syncManager.avatarService = _avatarService;
			}
			
			return syncManager;
		}
		
		public function addSynchronisedObject(avatar:ISynchronisedAvatar):void
		{
			trace("Adding synchronised Object");
			
			_syncManager.register(avatar);
		}
	}
}