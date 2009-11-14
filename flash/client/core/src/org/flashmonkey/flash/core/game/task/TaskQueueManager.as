package org.flashmonkey.flash.core.game.task
{
	import flash.utils.Dictionary;
	
	import org.flashmonkey.flash.utils.AsyncOperationSequence;
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
			createQueue(UPDATE);
			createQueue(RENDER);
		}
		
		public static function get instance():TaskQueueManager
		{
			return $instance = ($instance == null) ? new TaskQueueManager() : $instance;
		}
		
		public function createQueue(name:String):void 
		{
			$queues[name] = new AsyncOperationSequence(true);
		}

		/*public function addQueue(name:String, queue:IOperation = null):void 
		{
			if (!queue)
			{
				trace("Creating new Queue " + name);
				queue = new AsyncOperationSequence();
			}
			
			$queues[name] = queue;
		}*/
		
		public function getQueue(name:String):AsyncOperationSequence 
		{
			return AsyncOperationSequence($queues[name]);
		}
		
		public function addToQueue(queueName:String, operation:IOperation, create:Boolean = true):void
		{
			trace("Adding " + operation + " to " + queueName + " queue");
			var queue:AsyncOperationSequence = getQueue(queueName);
			
			if (queue)
			{
				queue.addOperation(operation);
			}/*
			else if (create)
			{
				addQueue(queueName);
				addToQueue(queueName, operation);
			}*/
		}
	}
}