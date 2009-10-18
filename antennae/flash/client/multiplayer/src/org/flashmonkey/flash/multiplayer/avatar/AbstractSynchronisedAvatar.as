/* --------------------------------------------------------------------------------------
 * PaperWorld3D - building better worlds
 * --------------------------------------------------------------------------------------
 * Real-Time Multi-User Application Framework for the Flash Platform.
 * --------------------------------------------------------------------------------------
 * Copyright (C) 2008 Trevor Burton [worldofpaper@googlemail.com]
 * --------------------------------------------------------------------------------------
 * 
 * This library is free software; you can redistribute it and/or modify it under the 
 * terms of the GNU Lesser General Public License as published by the Free Software 
 * Foundation; either version 2.1 of the License, or (at your option) any later version.
 *
 * This library is distributed in the hope that it will be useful, but WITHOUT ANY 
 * WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A 
 * PARTICULAR PURPOSE. See the GNU Lesser General Public License for more details.
 *
 * You should have received a copy of the GNU Lesser General Public License along with 
 * this library; if not, write to the Free Software Foundation, Inc., 59 Temple Place, 
 * Suite 330, Boston, MA 02111-1307 USA 
 * 
 * -------------------------------------------------------------------------------------- */
package org.flashmonkey.flash.multiplayer.avatar
{
	import flash.events.Event;
	
	import org.as3commons.logging.ILogger;
	import org.as3commons.logging.LoggerFactory;
	import org.flashmonkey.flash.ai.steering.SteeringOutput;
	import org.flashmonkey.flash.api.IBehaviour;
	import org.flashmonkey.flash.api.IInput;
	import org.flashmonkey.flash.api.IPaperworldObject;
	import org.flashmonkey.flash.api.IState;
	import org.flashmonkey.flash.api.multiplayer.ISyncManager;
	import org.flashmonkey.flash.api.multiplayer.ISynchronisedAvatar;
	import org.flashmonkey.flash.core.objects.BasicState;
	import org.flashmonkey.flash.multiplayer.inputhandlers.SimpleAvatarInputHandler25D;
	import org.flashmonkey.flash.utils.input.IUserInput;
	import org.flashmonkey.flash.utils.input.Input;
	import org.flashmonkey.flash.utils.timer.ITimer;
	import org.flashmonkey.flash.utils.timer.TimerManager;
	import org.flashmonkey.flash.utils.timer.events.ITimerEvent;	

	/**
	 * @author Trevor Burton [worldofpaper@googlemail.com]
	 */
	public class AbstractSynchronisedAvatar implements ISynchronisedAvatar
	{
		private static var logger:ILogger = LoggerFactory.getLogger("Paperworld");
		
		public static const AVATAR_UPDATE_TIMER:String = "AvatarUpdateTimer";
		
		private var _syncManager:ISyncManager;
		
		public function get syncManager():ISyncManager
		{
			return _syncManager;
		}
		
		public function set syncManager(value:ISyncManager):void 
		{
			_syncManager = value;
		}

		public function set userInput(value : IUserInput) : void
		{
		}

		/**
		 * AbstractSynchronisedScene stores SyncObject instances in a single linked list
		 * as an optimisation for iterating over the synchronisable objects in a scene.
		 */
		protected var _next : ISynchronisedAvatar;

		public function get next() : ISynchronisedAvatar
		{
			return _next;
		}

		public function set next(value : ISynchronisedAvatar) : void
		{
			_next = value;
		}

		public var synchronisedObject : IPaperworldObject;

		public function get object() : IPaperworldObject
		{
			return synchronisedObject;
		}	

		public function set object(value : IPaperworldObject) : void
		{
			synchronisedObject = value;
		}

		/**
		 * The default tightness for adaptive smoothing.
		 */
		public var defaultTightness : Number = 0.1;

		/**
		 * The 'loosest' tightness allowed in the adaptive smoothing algorithm.
		 */
		public var smoothTightness : Number = 0.01;

		/**
		 * The current tightness value for adaptive smoothing.
		 */
		protected var _tightness : Number = defaultTightness;

		public function get tightness() : Number
		{
			return _tightness;
		}

		public function set tightness(tightness : Number) : void
		{
			_tightness = tightness;
		}

		/**
		 * The AvatarBehaviour instance used to interpret user input for this SyncObject.
		 */
		protected var _behaviour : IBehaviour;

		public function set behaviour(behaviour : IBehaviour) : void
		{
			_behaviour = behaviour;
		}

		/**
		 * The current user input state for this object.
		 */
		protected var _input : IInput = new Input();

		public function get input() : IInput
		{
			return _input;
		}

		public function set input(input : IInput) : void
		{
			_input = input;
		}

		/**
		 * The State of this object in the previous frame.
		 */
		protected var _previous : IState = new BasicState();

		/**
		 * The State of this object in the current frame.
		 */
		protected var _current : IState = new BasicState();

		/**
		 * Returns the current State of this object.
		 */
		public function get state() : IState
		{
			return _current.clone();	
		}

		/**
		 * @private
		 */
		public function set state(value : IState) : void
		{
			_previous = _current;
			_current = value;
		}

		protected var output : SteeringOutput;	

		/**
		 * The current time stream for this object.
		 */
		public var _time : Number = 0;

		public function get time() : int
		{
			return _time;
		}

		public function set time(time : int) : void
		{
			_time = time;
		}

		/**
		 * Flagged true if this object is currently 
		 * replaying from it's Move history buffer.
		 */
		public var _replaying : Boolean;

		public function get replaying() : Boolean
		{
			return _replaying;
		}

		public function set replaying(replaying : Boolean) : void
		{
			_replaying = replaying;
		}

		public function AbstractSynchronisedAvatar() 
		{
		}

		public function update(e:Event = null) : void
		{	
			_time++;		
			
			_tightness += (defaultTightness - _tightness) * 0.01;
					
			synchronisedObject.synchronise( _time, _input, _current );	
		}

		public function synchronise(time : int, input : IInput, state : IState) : void
		{
			_tightness = defaultTightness;
		}

		/**
		 * Immediately sets the State of this object to the State passed. Handles
		 * cases where the update from the server is showing us that we're wildly 
		 * out of sync, there's no point in smoothing - so we just 'snap'.
		 */
		public function snap(state : IState) : void
		{
			_previous = _current.clone( );
			_current = state.clone( );
			
			synchronisedObject.synchronise( _time, _input, _current );
		}

		/**
		 * Loosen the tightness of adaptive smoothing (called when we've just
		 * synchronised with a server update, we can relax for a moment!).
		 */
		public function smooth() : void
		{
			_tightness = smoothTightness;
		}

		/**
		 * Initialise implementation. Sets up any required objects/values.
		 */
		public function initialise() : void
		{						
			_behaviour = new SimpleAvatarInputHandler25D( );
			
			output = new SteeringOutput( );
			
			trace("TimerManager registering update");
			var timer:ITimer = TimerManager.instance.getTimerByName(AVATAR_UPDATE_TIMER);
			
			if (!timer)
			{
				timer = TimerManager.instance.startSimpleIntervalTimer(100, 10000, AVATAR_UPDATE_TIMER);
			}
			trace("TIMER: " + timer);
			timer.addEventListener(ITimerEvent.TICK, update);
		}

		/**
		 * Destroy implementation. Clean up and remove references so GC can work correctly.
		 */
		public function destroy() : void 
		{			
			_current = null;	
			_previous = null;
		}

		/**
		 * Determine if this SyncObject is in the same state as another SyncObject instance.
		 */
		public function equals(other : AbstractSynchronisedAvatar) : Boolean
		{				
			return  _tightness == other.tightness && _time == other.time && _input.equals( other.input ) && _current.equals( other.state );	
		}

		public function toString() : String
		{
			return '[Avatar: ' + synchronisedObject + ']';
		}

		protected var _id : String;

		public function get id() : String
		{
			return _id;
		}

		public function set id(value : String) : void
		{
			_id = value;
		}
	}
}