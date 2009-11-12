package org.flashmonkey.flash.core.game.state
{
	public class GameStateManager extends GameStateNode
	{
		private static var $instance:GameStateNode;
		
		public function GameStateManager()
		{
			super("GameStateManager", true);
		}
		
		public static function get instance():GameStateNode
		{
			return $instance = ($instance == null) ? new GameStateManager() : $instance;
		}
	}
}