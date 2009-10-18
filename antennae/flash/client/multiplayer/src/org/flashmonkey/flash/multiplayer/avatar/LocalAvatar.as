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
	import org.flashmonkey.flash.api.IInput;
	import org.flashmonkey.flash.api.IState;
	import org.flashmonkey.flash.utils.History;
	import org.flashmonkey.flash.utils.Move;
	import org.flashmonkey.flash.utils.input.IUserInput;
	import org.flashmonkey.flash.utils.input.IUserInputListener;
	import org.flashmonkey.flash.utils.input.events.UserInputEvent;	

	/**
	 * @author Trevor Burton [worldofpaper@googlemail.com]
	 */
	public class LocalAvatar extends AbstractSynchronisedAvatar implements IUserInputListener
	{
		protected var _history : History = new History( );

		private static var log:ILogger = LoggerFactory.getLogger("PW-Multiplayer");

		override public function set userInput(value : IUserInput) : void
		{
			value.input = input;
			value.addEventListener(UserInputEvent.INPUT_CHANGED, onInputUpdate);
		}

		public function LocalAvatar()
		{
			super( );
			
			initialise();
		}

		override public function update(e:Event = null) : void
		{	
			//trace("STATE: " + state);
			//
								
			_behaviour.apply( this );
			
			//trace("updating LocalAvatar " + state.position.x + " " + state.position.y + " " + state.position.z);
						
			// add to history
			var move : Move = new Move( );
			move.time = _time;
			move.input = _input.clone( );
			move.state = _current.clone( );

			_history.add( move );
			
			// update scene
			super.update( );		
		}

		override public function synchronise(time : int, input : IInput, state : IState) : void
		{			
			/*var original : State = state.clone( );
			
			if (original.compare( state ))
			{
            	smooth( );
   			}*/
			trace("synchronising local avatar " + state.position.x);// + " " + state.py + " " + state.pz);
			snap(state);
			//_history.correction( this, time, state, input );	
            	
			//super.synchronise( time, input, state );
		}

		public function onInputUpdate(event : UserInputEvent) : void
		{
			syncManager.handleAvatarMove(id, _time, _input.clone());
		}
	}
}
