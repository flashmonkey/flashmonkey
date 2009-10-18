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
	
	import flash.display.Stage;
	import flash.events.IEventDispatcher;	

	/**
	 * @author Trevor Burton [worldofpaper@googlemail.com]
	 */
	public interface IUserInput extends IEventDispatcher
	{
		function get input() : IInput;
		
		function set input(value:IInput):void;

		function set target(value : Stage) : void;
		
		function updateListeners():void;

		/**
		 * Returns the mouse x position.
		 */
		//function get mouseX() : Number 

		/**
		 * Returns the mouse y position.
		 */
		//function get mouseY() : Number

		/**
		 * Called by the <code>GameTimer</code>'s integration event.</br>
		 * Takes a snapshot of the user's input.
		 */
		//function update( event : ClockEvent = null ) : void;

		//function addListener(listener : IUserInputListener) : void;

		//function removeListener(listener : IUserInputListener) : void;
	}
}
