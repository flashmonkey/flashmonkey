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
	import flash.display.Stage;
	import flash.events.MouseEvent;	

	/**
	 * @author Trevor Burton [worldofpaper@googlemail.com]
	 */
	public class KeyboardAndMouseInput extends KeyboardInput 
	{
		/**
		 * Sensitivity of the mouse values. The larger this value is the less angular movement
		 * you'll get with your player's avatar.
		 */
		public var sensitivity : Number = 300;

		public var threshold : Number = 0;
		
		override public function set target(value : Stage) : void
		{
			super.target = value;
			
			_target.addEventListener( MouseEvent.MOUSE_MOVE, onMouseMove );
			_target.addEventListener( MouseEvent.CLICK, onClick );
		}
		
		public function KeyboardAndMouseInput()
		{
			super( );
		}
		
		/**
		 * Handles a mouse move. Updates the <code>Input</code> object.
		 */
		public function onMouseMove( event : MouseEvent ) : void
		{						
			var x : Number = ( event.stageX - ( _target.stageWidth / 2 ) ) / sensitivity;
			var y : Number = ( event.stageY - ( _target.stageHeight / 2 ) ) / sensitivity;
			
			var squareDistance : Number = x * x + y * y;
			
			if (squareDistance > threshold)
			{
				input.mouseX = x;
				input.mouseY = y;
				
				updateListeners();
			}
		}
	}
}
