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
	import flash.events.EventDispatcher;	
	/**
	 * Action is a Base Class that for triggering ANY behaviour, whether visible to the user or internal.
	 * 
	 * <p>Actions can be sequenced or combined to create more complex, aggregate behaviours.</p>
	 * 
	 * @author Trevor Burton [worldofpaper@googlemail.com]
	 */
	public class Action extends EventDispatcher
	{
		/**
		 * The relative priority of this action. This allows actions
		 * to prempt others.
		 */
		public var priority : int;

		/**
		 * Actions naturally come in sequences, so their are
		 * implemented as a single linked list by default.
		 */
		public var next : Action;

		/**
		 * Retutns the last action in the list of actions.
		 */
		public function get last() : Action
		{
			// If we're at the end, then end
			if (!next) return this;
	
			// Otherwise find the end iteratively
			var thisAction : Action = this;
			var nextAction : Action = next;
			
			while (nextAction) 
			{
				thisAction = nextAction;
				nextAction = nextAction.next;
			}
	
			// The final element is in thisAction, so return it
			return thisAction;
		}

		/**
		 * Requests that the action delete itself and its children.
		 */
		public function deleteList() : void
		{
			// Decurse first
			if (next) next.deleteList( );
	
			// Delete ourself
			destroy( );
		}

		/**
		 * Called to make the action do its stuff. This depends on the
		 * type of action, and the default implementation does
		 * nothing.
		 */
		public function act() : void
		{
	        // Does nothing.
		}

		/**
		 * Checks if this action can be interrupt others. By default
		 * no actions can be interrupt.
		 */
		public function get canInterrupt() : Boolean
		{
			return false;
		}

		/**
		 * Asks the action to check if it be performed at the same
		 * time as the given action. This relationship may not be
		 * reflexible: both actions in a pair are asked, and things
		 * only progress if both agree. By default an action cannot be
		 * done with any other.
		 */
		public function canDoBoth(other : Action) : Boolean
		{
			return false;
		}

		/**
		 * Returns true if the action is done. Otherwise the manager
		 * keeps scheduling the action. The default implementation is
		 * always done.
		 */
		public function isComplete() : Boolean
		{
			return true;
		}

		/**
		 * Declares whether or not this Action is allowed to act. Defaults to true.
		 */
		public function canAct() : Boolean
		{
			return true;	
		}

		/**
		 * Destroy implementation.
		 */
		public function destroy() : void
		{
			priority = NaN;
			next = null;	
		}

		public function equals(other : Action) : Boolean
		{				
			return priority == other.priority && next.equals( other.next );	
		}
	}
}
