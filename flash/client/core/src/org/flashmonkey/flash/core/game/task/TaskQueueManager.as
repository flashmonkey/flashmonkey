package org.flashmonkey.flash.core.game.task
{
	import flash.utils.Dictionary;
	
	import org.springextensions.actionscript.mvcs.service.operation.AsyncOperationSequence;
	import org.springextensions.actionscript.mvcs.service.operation.IOperation;
	
	public class TaskQueueManager
	{
		public static const UPDATE:String = "update";
		public static const RENDER:String = "render";
		
		private static var $instance:TaskQueueManager;
		
		private var $queues:Dictionary = new Dictionary();
		
		public function TaskQueueManager()
		{
			init();
		}
		
		protected function init():void 
		{
			addQueue(UPDATE);
			addQueue(RENDER);
		}
		
		public static function get instance():TaskQueueManager
		{
			return $instance = ($instance == null) ? new TaskQueueManager() : $instance;
		}

		public function addQueue(name:String, queue:IOperation = null):void 
		{
			if (!queue)
			{
				queue = new AsyncOperationSequence();
			}
			
			$queues[name] = queue;
		}
		
		public function getQueue(name:String):IOperation 
		{
			return $queues[name] as IOperation;
		}
	}
}