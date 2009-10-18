/*
 * Part of the Artificial Intelligence for Games system.
 *
 * Copyright (c) Ian Millington 2003-2006. All Rights Reserved.
 *
 * This software is distributed under licence. Use of this software
 * implies agreement with all terms and conditions of the accompanying
 * software licence.
 * 
 * Actionscript port - Trevor Burton [worldofpaper@googlemail.com]
 */
package org.flashmonkey.flash.core.action
{

	/**
	 * An action combination is a set of actions that can be performed
	 * at the same time.
	 * 
	 * @author Trevor
	 */
	public class ActionSequence extends CompoundAction 
	{
		/**
		 * Checks if this action can interrupt. The combination can
		 * interrupt if the first action can.
		 */
		override public function get canInterrupt() : Boolean
		{
			if (subActions) return subActions.canInterrupt;
	        else return false;
		}

		/**
		 * Returns true if all the sub-actions are done. Otherwise the
		 * manager keeps scheduling the action.
		 */
		override public function isComplete() : Boolean
		{
			return subActions == null;
		}

		override public function act() : void
		{
			// Check if we have anything to do
			if (subActions) return;
	
			// Run the first action in the list
			subActions.act( );
	
			// Then consume it if its done
			if (subActions.isComplete()) 
			{	
				//var temp : Action = subActions;
				subActions = subActions.next;
			}
		}
	}
}
