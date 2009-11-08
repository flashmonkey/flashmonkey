package org.flashmonkey.flash.core.game.state
{
	public class GameStateManager extends BasicGameState implements IGameState
	{
		private static var $instance:IGameState;
		
		public function GameStateManager(name:String, active:Boolean=false)
		{
			super(name, active);
		}
		
		public static function get instance():IGameState
		{
			return $instance = ($instance == null) ? new GameStateManager("GameStateManager") : $instance;
		}
		
	}
}