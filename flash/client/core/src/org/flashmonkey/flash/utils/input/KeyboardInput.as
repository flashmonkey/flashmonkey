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
	import org.flashmonkey.flash.utils.patterns.command.ICommand;
	
	import flash.display.Stage;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	
	/**
	 * @author Trevor Burton [worldofpaper@googlemail.com]
	 */
	public class KeyboardInput extends AbstractUserInput 
	{		
		protected var _keyUpCommands:Array = [];
		
		public function get keyUpCommands():Array 
		{
			return _keyUpCommands;
		}
		
		public function set keyUpCommands(value:Array):void 
		{
			_keyUpCommands = value;
		}

		protected var _keyDownCommands:Array = [];

		public function get keyDownCommands():Array 
		{
			return _keyDownCommands;
		}
		
		public function set keyDownCommands(value:Array):void 
		{
			_keyDownCommands = value;
		}

		override public function set target(value : Stage) : void
		{
			super.target = value;
				
			_target.addEventListener( KeyboardEvent.KEY_DOWN, onKeyDown );
			_target.addEventListener( KeyboardEvent.KEY_UP, onKeyUp );
		}

		public function KeyboardInput(stage:Stage = null)
		{
			super( );
			
			if (stage) 
			{
				target = stage;
			}
			
			_commands[0] = _keyUpCommands;
			_commands[1] = _keyDownCommands;
		}

		public function onClick(event : MouseEvent) : void
		{
		}

		/**
		 * Handles a key being pressed. Updates the <code>InputData</code> object.
		 */
		public function onKeyDown( event : KeyboardEvent ) : void 
		{	
			var command : ICommand = ICommand( _keyDownCommands[event.keyCode] );
			
			if (command) command.execute( );
		}

		/**
		 * Handles a key being released. Updates the <code>InputData</code> object.
		 */
		public function onKeyUp( event : KeyboardEvent ) : void 
		{
			var command : ICommand = ICommand( _keyUpCommands[event.keyCode] );
			
			if (command) command.execute( );
		}
	}
}
