package org.flashmonkey.flash.multiplayer.sync
{
	import com.joeberkovitz.moccasin.service.IOperation;
	import org.flashmonkey.flash.api.IInput;
	import org.flashmonkey.flash.api.connection.IClient;
	import org.flashmonkey.flash.api.connection.messages.IMessage;
	import org.flashmonkey.flash.api.multiplayer.ISyncManager;
	import org.flashmonkey.flash.api.multiplayer.ISynchronisedAvatar;
	import org.flashmonkey.flash.api.multiplayer.ISynchronisedScene;
	import org.flashmonkey.flash.api.multiplayer.messages.IServerSyncMessage;
	import org.flashmonkey.flash.connection.messages.RequestIdMessage;
	import org.flashmonkey.flash.multiplayer.messages.BatchedInputMessage;
	import org.flashmonkey.flash.multiplayer.messages.PlayerSyncMessage;
	import org.flashmonkey.flash.multiplayer.messages.ServerSyncMessage;
	import org.flashmonkey.flash.multiplayer.messages.SynchroniseCreateMessage;
	import org.flashmonkey.flash.utils.AbstractProcessor;
	import org.flashmonkey.flash.utils.timer.ITimer;
	import org.flashmonkey.flash.utils.timer.TimerManager;
	import org.flashmonkey.flash.utils.timer.events.ITimerEvent;
	
	import flash.events.Event;
	import flash.utils.Dictionary;
	
	import org.as3commons.logging.ILogger;
	import org.as3commons.logging.LoggerFactory;
	
	public class SynchronisationManager extends AbstractProcessor implements ISyncManager	
	{		
		private static const SEND_INPUT_TIMER:String = "SendInputTimer";
		
		private static var log:ILogger = LoggerFactory.getLogger("SynchronisationManager");
		
		private var _client:IClient;
		
		private var _scene:ISynchronisedScene;
		
		public function set scene(value:ISynchronisedScene):void 
		{
			_scene = value;
		}
		
		private var _batchedMoves:Array = [];
		
		private var _waitingForId:Dictionary = new Dictionary();
		
		private var _pending:Dictionary = new Dictionary();
		
		private var _queue:Dictionary = new Dictionary();
		
		private var _destroying:Dictionary = new Dictionary();
		
		private var _avatars:Dictionary = new Dictionary();
		
		private var _sendInputTimer:ITimer;
		
		public function set client(value:IClient):void
		{
			_client = value;
		}
		
		public function SynchronisationManager()
		{
			super([SynchroniseCreateMessage, ServerSyncMessage]);
			
			_sendInputTimer = TimerManager.instance.startAccurateIntervalTimer(200, 10000, SEND_INPUT_TIMER);
			_sendInputTimer.addEventListener(ITimerEvent.TICK, _onSendInputTimerTick);
			_sendInputTimer.start();
		}
		
		/**
		 * Register an object that this client will have authority over.
		 * 
		 * Before the object can be synchronised across clients it must be
		 * given a unique id that identifies it. This unique id is given
		 * by the server. So we first send this request message. When it's
		 * received we can start sending synchronisation message for this avatar.
		 */
		public function register(avatar:ISynchronisedAvatar):void 
		{
			// Create the message.
			var message:IMessage = new RequestIdMessage();
			
			// Create the operation that will send the message.
			var operation:IOperation = _client.sendToServer(message);
			operation.addEventListener(Event.COMPLETE, onIdRequestComplete);
			
			// Add the avatar to the waiting list, using the operation as the key.
			_waitingForId[operation] = avatar;
			
			// Send the message.
			operation.execute();
		}
		
		public function unRegister(avatar:ISynchronisedAvatar):void 
		{
			
		}
		
		/**
		 * An id request has completed. We have received a unique id for an
		 * avatar on the server. We apply the id to the avatar and remove
		 * the avatar from the waiting list.
		 */
		protected function onIdRequestComplete(event:Event):void 
		{
			trace("request id complete");
			// Get the message from the completed operation.
			var operation:IOperation = IOperation(event.target);
			var id:String = operation.result as String;

			// Set the id on the avatar that it was requested for.
			var avatar:ISynchronisedAvatar = ISynchronisedAvatar(_waitingForId[operation]);
			avatar.id = id;

			// Remove the avatar from the waiting list now that it has a unique id.
			delete _waitingForId[operation];

			_avatars[avatar.id] = avatar;
			avatar.syncManager = this;
			_scene.addAvatar(avatar);

			// Now that we have a custom id for this avatar we 
			// need to inform all the other clients connected to the 
			// same scene that this avatar has joined. This is done
			// by sending a SynchroniseCreateMessage.
			var message:IMessage = _createSynchroniseCreateMessage(avatar);
			var syncOp:IOperation = _client.sendToServer(message);
			syncOp.addEventListener(Event.COMPLETE, _onSynchroniseCreateMessageComplete);
			syncOp.execute();
		}
		
		/**
		 * This method is called when a player on this client has registered
		 * a new object for synchronisation, a request has been made for a unique
		 * id and that request has succeeded.
		 */
		private function _onSynchroniseCreateMessageComplete(event:Event):void 
		{
			trace("synchronise create message complete");
		}
		
		private function _createSynchroniseCreateMessage(avatar:ISynchronisedAvatar):IMessage
		{
			var message:SynchroniseCreateMessage = new SynchroniseCreateMessage();
			message.playerId = _client.id;
			message.objectId = avatar.id;
			
			return message;
		}
		
		public function handleAvatarMove(id:String, time:int, input:IInput):void
		{
			_batchedMoves.push(new PlayerSyncMessage(id, time, input));
		}
		
		override public function process(object:*):void
		{
			// If we're receiving a synchronise create message
			// then another client has joined the game and 
			// we need to create an avatar that represents them.
			if (object is SynchroniseCreateMessage)
			{
				
			}
			else if (object is ServerSyncMessage)
			{
				var message:IServerSyncMessage = IServerSyncMessage(object);
				var avatar:ISynchronisedAvatar = ISynchronisedAvatar(_avatars[message.objectId]);
				log.debug("STATE: " + message.state.position.z);// + " " + message.state.py + " " + message.state.pz);
				avatar.synchronise(message.time, message.input, message.state);
			}
		}
		
		private function _onSendInputTimerTick(e:ITimerEvent):void 
		{
			// We only need to send input to the server if there's input to send.
			if (_batchedMoves.length > 0)
			{
				// Create a new BatchInputMessage and give it the list
				// batched messages we're currently holding onto.
				var batchMessage:BatchedInputMessage = new BatchedInputMessage();
				batchMessage.messages = _batchedMoves.concat();
				
				// Clear the batched moves array so we can catch more.
				_batchedMoves = [];
				
				// Send the batch to the server.
				_client.sendToServer(batchMessage).execute();
			}
		}
	}
}