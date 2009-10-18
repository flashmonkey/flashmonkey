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
	import org.flashmonkey.flash.utils.keys.KeyDefinitions;
	import org.flashmonkey.flash.utils.keys.KeyDownCommand;
	import org.flashmonkey.flash.utils.keys.KeyUpCommand;
	
	import flash.display.Stage;	

	/**
	 * @author Trevor Burton [worldofpaper@googlemail.com]
	 */
	public class BasicKeyboardInput extends KeyboardInput 
	{
		public function BasicKeyboardInput(stage:Stage = null)
		{
			super( stage );
			
			initialise();
		}
		
		public function initialise():void
		{			
			// Handle Forward Key Press - mapped to 'w' key.
			var forwardKeyUpCommand : KeyUpCommand = new KeyUpCommand(this );
			forwardKeyUpCommand.property = Input.MOVE_FORWARD;
			
			var forwardKeyDownCommand : KeyDownCommand = new KeyDownCommand(this );
			forwardKeyDownCommand.property = Input.MOVE_FORWARD;
			
			_keyUpCommands[KeyDefinitions.W] = forwardKeyUpCommand;
			_keyDownCommands[KeyDefinitions.W] = forwardKeyDownCommand;
			
			// Handle Back Key Press - mapped to 's' key.
			var backKeyUpCommand : KeyUpCommand = new KeyUpCommand(this );
			backKeyUpCommand.property = Input.MOVE_BACKWARD;
			
			var backKeyDownCommand : KeyDownCommand = new KeyDownCommand(this );
			backKeyDownCommand.property = Input.MOVE_BACKWARD;
			
			_keyUpCommands[KeyDefinitions.S] = backKeyUpCommand;
			_keyDownCommands[KeyDefinitions.S] = backKeyDownCommand;
			
			// Handle Right Key Press - mapped to 'd' key.
			var rightKeyUpCommand : KeyUpCommand = new KeyUpCommand(this );
			rightKeyUpCommand.property = Input.MOVE_RIGHT;
			
			var rightKeyDownCommand : KeyDownCommand = new KeyDownCommand(this );
			rightKeyDownCommand.property = Input.MOVE_RIGHT;
			
			_keyUpCommands[KeyDefinitions.D] = rightKeyUpCommand;
			_keyDownCommands[KeyDefinitions.D] = rightKeyDownCommand;
			
			// Handle Left Key Press - mapped to 'a' key.
			var leftKeyUpCommand : KeyUpCommand = new KeyUpCommand(this );
			leftKeyUpCommand.property = Input.MOVE_LEFT;
			
			var leftKeyDownCommand : KeyDownCommand = new KeyDownCommand(this );
			leftKeyDownCommand.property = Input.MOVE_LEFT;
			
			_keyUpCommands[KeyDefinitions.A] = leftKeyUpCommand;
			_keyDownCommands[KeyDefinitions.A] = leftKeyDownCommand;
			
			// Handle Right Arrow Key Press - mapped to '->' key.
			var turnRightKeyUpCommand : KeyUpCommand = new KeyUpCommand(this );
			turnRightKeyUpCommand.property = Input.YAW_POSITIVE;
			
			var turnRightKeyDownCommand : KeyDownCommand = new KeyDownCommand(this );
			turnRightKeyDownCommand.property = Input.YAW_POSITIVE;
			
			_keyUpCommands[KeyDefinitions.RIGHT_ARROW] = turnRightKeyUpCommand;
			_keyDownCommands[KeyDefinitions.RIGHT_ARROW] = turnRightKeyDownCommand;
			
			// Handle Left Arrow Key Press - mapped to '<-' key.
			var turnLeftKeyUpCommand : KeyUpCommand = new KeyUpCommand(this );
			turnLeftKeyUpCommand.property = Input.YAW_NEGATIVE;
			
			var turnLeftKeyDownCommand : KeyDownCommand = new KeyDownCommand(this );
			turnLeftKeyDownCommand.property = Input.YAW_NEGATIVE;
			
			_keyUpCommands[KeyDefinitions.LEFT_ARROW] = turnLeftKeyUpCommand;
			_keyDownCommands[KeyDefinitions.LEFT_ARROW] = turnLeftKeyDownCommand;
			
			var fireDownCommand : KeyDownCommand = new KeyDownCommand( this );
			fireDownCommand.property = Input.FIRE;
			
			var fireUpCommand : KeyUpCommand = new KeyUpCommand( this );
			fireUpCommand.property = Input.FIRE;
			
			_keyUpCommands[KeyDefinitions.SPACEBAR] = fireUpCommand;			_keyDownCommands[KeyDefinitions.SPACEBAR] = fireDownCommand;
		}
	}
}
