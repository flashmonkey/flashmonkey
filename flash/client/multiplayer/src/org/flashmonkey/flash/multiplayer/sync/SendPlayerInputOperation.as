package org.flashmonkey.flash.multiplayer.sync
{
	
	import flash.events.Event;
	
	import org.flashmonkey.flash.connection.messages.BatchMessage;
	import org.springextensions.actionscript.mvcs.service.operation.AbstractOperation;

	public class SendPlayerInputOperation extends AbstractOperation
	{
		private var _syncManager:SynchronisationManager;
		
		public function SendPlayerInputOperation(syncManager:SynchronisationManager)
		{
			super();
			
			_syncManager = syncManager;
		}
		
		public override function execute():void 
		{	
			var moves:Array = _syncManager.batchedMoves;
			
			if (moves.length > 0)
			{
				// Create a new BatchInputMessage and give it the list
				// batched messages we're currently holding onto.
				var batchMessage:BatchMessage = new BatchMessage();
				batchMessage.messages = moves.concat();
				
				// Clear the batched moves array so we can catch more.
				_syncManager.batchedMoves = [];
				
				// Send the batch to the server.
				_syncManager.client.sendToServer(batchMessage).execute();
			}
			
			dispatchResult(this);
		}
		
	}
}