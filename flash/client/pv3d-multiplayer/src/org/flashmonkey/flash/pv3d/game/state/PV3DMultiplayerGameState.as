package org.flashmonkey.flash.pv3d.game.state
{
	import org.flashmonkey.flash.api.IPaperworldObject;
	import org.flashmonkey.flash.api.connection.IClient;
	import org.flashmonkey.flash.api.multiplayer.ISynchronisedAvatar;
	import org.flashmonkey.flash.api.multiplayer.ISynchronisedScene;
	import org.flashmonkey.flash.game.state.IMultiplayerGameState;
	import org.flashmonkey.flash.multiplayer.avatar.LocalAvatar;
	import org.flashmonkey.flash.multiplayer.sync.SynchronisationManager;
	import org.flashmonkey.flash.pv3d.objects.PaperworldObject;
	import org.flashmonkey.flash.pv3d.scenes.SynchronisedScene;
	import org.papervision3d.objects.DisplayObject3D;
	import org.papervision3d.scenes.Scene3D;
	
	public class PV3DMultiplayerGameState extends PV3DGameState implements IMultiplayerGameState
	{
		protected var _syncScene:ISynchronisedScene;
		
		protected var _syncManager:SynchronisationManager;
		
		protected var _client:IClient;
		
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
			
			_syncScene = createSynchronisedScene();
			
			_syncManager = new SynchronisationManager();
			_syncManager.scene = _syncScene;
		}
		
		protected function createSynchronisedScene():ISynchronisedScene
		{
			return new SynchronisedScene(Scene3D(_display.scene));
		}
		
		public function addSynchronisedObject(o:Object):void
		{
			trace("Adding synchronised Object");
			
			if (o is DisplayObject3D)
			{
				trace("Adding a display object 3d");
				var localAvatar:ISynchronisedAvatar = new LocalAvatar();
				var syncObject:IPaperworldObject = new PaperworldObject();
				syncObject.displayObject = o;
				
				localAvatar.object = syncObject;
				
				_syncManager.register(localAvatar);
			}
		}
		
	}
}