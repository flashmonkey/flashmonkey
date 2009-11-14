package org.flashmonkey.flash.core.game
{
	import flash.events.Event;
	
	import org.flashmonkey.flash.core.game.state.BasicGameState;
	import org.flashmonkey.flash.core.game.state.GameStateManager;
	import org.flashmonkey.flash.core.game.state.IGameState;
	import org.flashmonkey.flash.core.game.task.TaskQueueManager;
	import org.flashmonkey.flash.utils.AsyncOperationSequence;
	import org.flashmonkey.flash.utils.clock.Clock;
	import org.flashmonkey.flash.utils.clock.events.ClockEvent;
	import org.flashmonkey.flash.utils.timer.ITimer;

	public class AbstractGame implements IGame
	{	
		protected var _gameStates:IGameState;
		
		protected var _timer:ITimer;
		
		public function AbstractGame()
		{
			init();
		}
		
		protected function init():void
		{
			_gameStates = createGameState();
			_timer = createTimer();
		}
		
		protected function createGameState():IGameState 
		{
			return new BasicGameState("RootGameState", true);
		}
		
		protected function createTimer():ITimer 
		{			
			return new Clock();
		}
		
		public function start():void 
		{
			_timer.addEventListener(ClockEvent.RENDER, render);
			_timer.addEventListener(ClockEvent.TIMESTEP, update);
			_timer.start();
		}
		
		public function update(e:Event = null):void
		{
			TaskQueueManager.instance.getQueue(TaskQueueManager.UPDATE).execute();
			
			var tpf:Number = ClockEvent(e).time;
			
			GameStateManager.instance.update(tpf);
		}
		
		public function render(e:Event = null):void
		{
			TaskQueueManager.instance.getQueue(TaskQueueManager.RENDER).execute();
			
			var tpf:Number = ClockEvent(e).time;
			
			GameStateManager.instance.render(tpf);
		}
		
		public function finish():void
		{
			
		}
		
		public function cleanup():void
		{
			
		}
	}
}