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
	 *
     * Compund actions are made up of sub-actions. This is a base
     * class that adds the sub-action management code that then has
     * sematics added in its sub-classes.
	 * 
	 * @author Trevor
	 */
	public class CompoundAction extends Action 
	{
		public var subActions : Action;

		/**
		 * Requests that the action delete itself and its children.
		 */
		override public function deleteList() : void
		{
			if (subActions) subActions.deleteList( );
			super.deleteList( );
		}

		/**
		 * Compound actions are compatible, only if all their
		 * components are compatible.
		 */
		override public function canDoBoth(other : Action) : Boolean
		{
			var next : Action = subActions;
	        
			while (next)
			{
				if (!next.canDoBoth( other )) return false;
				next = next.next;
			}
	        
			return true;
		}
	}
}
