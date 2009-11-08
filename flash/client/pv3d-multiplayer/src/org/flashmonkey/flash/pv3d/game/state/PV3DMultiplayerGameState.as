package org.flashmonkey.flash.pv3d.game.state
{
	import org.flashmonkey.flash.api.connection.IClient;
	import org.flashmonkey.flash.api.multiplayer.ISynchronisedScene;
	import org.flashmonkey.flash.multiplayer.sync.SynchronisationManager;
	import org.flashmonkey.flash.pv3d.scenes.SynchronisedScene;
	
	public class PV3DMultiplayerGameState extends PV3DGameState
	{
		protected var _syncScene:ISynchronisedScene;
		
		protected var _syncManager:SynchronisationManager;
		
		override public function set client(value:IClient):void
		{
			super.client = client;
			
			if (_syncManager)
			{
				_syncManager.client = _client;
				_client.addMessageProcessor(_syncManager);
			}
		}
		
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
			return new SynchronisedScene(_scene);
		}
		
	}
}