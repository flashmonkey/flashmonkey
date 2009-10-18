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
	 * The action manager is a central marshalling system that can be
	 * notified of actions that bits of AI wants to perform, and can
	 * correctly and flexibly schedule them. It supports priorities in
	 * actions, mixing actions together, and sequences of action.
	 * 
	 * @author Trevor
	 */
	public class ActionManager
	{
		/**
		 * Holds the highest priority value for all actions in the
		 * active set.
		 */
		public var activePriority : int;

		/**
		 * Holds the head of the action queue. This consists of
		 * actions that have been scheduled, but are not yet being
		 * performed.
		 */
		public var actionQueue : Action;

		/**
		 * Holds the list of actions that are currently being
		 * performed.
		 */
		public var active : Action;

		/**
		 * Adds the given action to the queue.
		 */
		public function scheduleAction(newAction : Action) : void
		{
			// Find the correct place to insert the new action
			var previous : Action = actionQueue;
			var next : Action = actionQueue;
	        
			while (next)
			{
				// if we've found a lower priority, we go here. Note that
				// this will be much quicker with a >=, but it means in
				// the absence of priority ordering the queue defaults to
				// fifo, which isn't very useful.
				if (newAction.priority > next.priority)
				{
					break;
				}
	
				previous = next.next;
				next = next.next;
			}
	
			// When we get here, we've either found the location mid-list
			// or reached the end of the list, so add it on
			previous = newAction;
			newAction.next = next;
		}

		/**
		 * Runs the action manager, running the component actions in
		 * turn. Note that the action manager deletes the action
		 * objects it is done with.
		 */
		public function execute() : void
		{
			// Check if we need to interrupt the currently active actions
			checkInterrupts( );
	
			// Add as many actions to the active set as play with the
			// actions already there.
			addAllToActive( );
	
			// Execute the active set
			runActive( );
		}

		/**
		 * Runs all the active actions, deleting any that
		 * complete. This is called automatically by the execute
		 * function.
		 */
		protected function runActive() : void
		{
			var previous : Action = active;
			var next : Action = active;
	
			while (next)
			{
				// Do the action first
				next.act( );
	
				// Check if we're done with this action
				if (next.isComplete())
				{
					// Remove it from the list
					previous = next.next;
	
					// Keep a temp of what we're about to delete
					var temp : Action = next;
	
					// Move the next pointer only along (previous stays)
					next = next.next;
	
					// And delete the item
					//delete temp;
				}
	            else
				{
					// We're not done, just chug along
					previous = next.next;
					next = next.next;
				}
			}
		}

		/**
		 * Allows any high-priority actions to interrupt the currently
		 * active set. This is called automatically be the execute
		 * method.
		 */
		protected function checkInterrupts() : void
		{
			// Find any new interrupters
			var previous : Action = actionQueue;
			var next : Action = actionQueue;
	        
			while (next)
			{
				// If we drop below the active priority, give up
				if (next.priority < activePriority)
				{
					break;
				}
	
				// Otherwise we're beating for priority, so check if we
				// need to interrupt.
				if (next.canInterrupt) 
				{
	
					// So we have to interrupt. Initially just replace the
					// active set.
	
					// Delete the previous active list
					if (active) active.deleteList( );
	
					// Add the new one
					active = next;
					activePriority = active.priority;
	
					// Rewire the queue to extract our action
					previous = next.next;
					next.next = null;
	
					// And stop looking (the highest priority interrupter
					// wins).
					break;
				}
	
				// Check the next one
				previous = next.next;
				next = next.next;
			}
		}

		/**
		 * Checks through all the actions in the action queue, to see
		 * if they can be performed at the same time as the actions
		 * already in the active set. If so, they are scheduled. This
		 * is called automatically be the execute method.
		 */
		protected function addAllToActive() : void
		{
			var previous : Action = actionQueue;
			var next : Action = actionQueue;
	        
	       /* while (next)
	        {
	            var inActive:Action = active;
	            
	            while (inActive)
	            {
	                // Check for compatibility
	                if (!inActive.canDoBoth(next) ||
	                    !next.canDoBoth(inActive)) {
	                    goto nextInQueue;
	                }
	            }
	
	            // We are compatible, so move from the queue to the active set
	            previous = next.next;
	            next.next = active;
	            active = next;
	
	            // Move the next counter, but keep the previous as is.
	            next = next.next;
	
	            // Don't fall through, because we don't want to update
	            // previous
	            continue;
	
	        nextInQueue:
	            // We only get here if there was no compatibility, so chug along
	            previous = next.next;
	            next = next.next;
	        }*/
		}
	}
}
