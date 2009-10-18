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
package org.flashmonkey.flash.utils.input 
{
	import org.flashmonkey.flash.api.IInput;
	import org.flashmonkey.flash.utils.input.events.UserInputEvent;
	
	import flash.display.Stage;
	import flash.events.EventDispatcher;	

	/**
	 * @author Trevor Burton [worldofpaper@googlemail.com]
	 */
	public class AbstractUserInput extends EventDispatcher implements IUserInput 
	{
		/**
		 * The state of the user's input in the current timestep.
		 */
		private var _current : IInput = new Input();
		
		private var _previous : IInput = new Input();

		public function get input():IInput
		{
			return _current;
		}
		
		public function set input(value:IInput):void 
		{
			_current = value;
		}

		protected var _target : Stage;

		public function set target(value : Stage) : void
		{
			_target = value;
		}

		protected var _commands : Array = [];

		public function AbstractUserInput()
		{
			super( this );
		}

		public function updateListeners() : void
		{
			if (_current.notEquals(_previous))
			{
				_previous.copyFrom(_current);
				
				dispatchEvent( new UserInputEvent( UserInputEvent.INPUT_CHANGED, _current ) );
			}
		}

		public function get mouseX() : Number
		{
			return 0;
		}

		public function get mouseY() : Number
		{
			return 0;
		}
		
		public function addListener(listener : IUserInputListener) : void
		{
			addEventListener( UserInputEvent.INPUT_CHANGED, listener.onInputUpdate );
		}
		
		public function removeListener(listener : IUserInputListener) : void
		{
			removeEventListener( UserInputEvent.INPUT_CHANGED, listener.onInputUpdate );
		}
	}
}
