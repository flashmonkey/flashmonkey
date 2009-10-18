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
package org.flashmonkey.flash.ai.learning 
{
	import org.flashmonkey.flash.utils.number.RandomUtils;		

	/**
	 * This is a concrete class that implements the LearningProblem
	 * interface with a set of states in an array, each containing a
	 * the same number of actions. It is mostly suitable for
	 * relatively toy problems.
	 */
	public class ArrayBasedLearningProblem extends LearningProblem 
	{
		/** Holds the number of states in the problem. */
		protected var stateCount : int;

		/** Holds the number of actions per state. */
		protected var actionsPerState : int;

		/** Holds the state objects */
		protected var states : Array;

		/** Holds the actions */
		protected var actions : Array;

		/**
		 * Holds the transition information: this tells the problem
		 * which state and action combinations map to which
		 * others. The array starts with each action for the first
		 * state - indicating the index of the state that is reached
		 * by taking the action. It then continues for the second
		 * state and so on. A value of 0xffffff in this array
		 * indicates that the action isn't valid for that state.
		 */
		protected var destination : int;

		/**
		 * Holds the reward matrix - in the same format as destination
		 * above, but this time giving the reward for each action from
		 * each state.
		 */
		protected var rewards : Array;

		/**
		 * Creates a new problem with the given data.
		 */
		public function ArrayBasedLearningProblem(stateCount : int, actionsPerState : int, destination : int, rewards : Array)
		{
			this.stateCount = stateCount;
			this.actionsPerState = actionsPerState;
			this.destination = destination;
			this.rewards = rewards;
		}

		public function initialise() : void
		{
			// Create the arrays
			states = new Array(stateCount);
			actions = new Array(actionsPerState);
	
			var i : int;
		
			// Fill the array values with their index numbers
			for (i = 0;i < stateCount; i++)
			{
				var state : LearningProblemState = new LearningProblemState();
				state.index = i;
	            
				states[i] = state;
			}
	
			for (i = 0;i < actionsPerState; i++)
			{
				var action : LearningProblemAction = new LearningProblemAction();
				action.index = i;
								actions[i] = action;
			}	
		}

		public function destroy() : void
		{
			var i : int;
		
			// Empty the arrays, destroy their contents, then nullify.
			for (i = 0;i < stateCount; i++)
			{
				var state : LearningProblemState = LearningProblemState(states[i]);
				state.destroy();
	            
				states[i] = null;
			}
			
			states = null;
	
			for (i = 0;i < actionsPerState; i++)
			{
				var action : LearningProblemAction = LearningProblemAction(actions[i]);
				action.destroy();
				
				actions[i] = null;
			}	
			
			states = null;
		}

		/** Returns the number of states in the problem. */
		override public function getStateCount() : int
		{
			return stateCount;	
		}

		/** Returns the number of states in the problem. */
		override public function getActionCount() : int
		{
			return actionsPerState;	
		}

		/** Returns the state with the given index. */
		override public function getState(index : int) : LearningProblemState
		{
			return LearningProblemState(states[index]);	
		}

		/** Returns a random state at which to start learning. */
		override public function getRandomState() : LearningProblemState
		{
			return LearningProblemState(states[RandomUtils.randomInt(0, stateCount)]);	
		}

		/** Returns the list of actions that are valid from the given state. */
		override public function getActions(state : LearningProblemState) : LearningProblemAction
		{
			var action : LearningProblemAction;
			for (var i : int = 0;i < actionsPerState; i++)
			{
				// Check if we've got a valid destination
				if (destination[state.index * actionsPerState + i] < 0xffffff)
				{
					// Add to the list
					actions[i].next = action;
					action = actions[i];
				}
			}

			// Return the list
			return action;
		}

		/**
		 * Returns the result of taking the given action from the given state.
		 */
		override public function getResult(state : LearningProblemState, action : LearningProblemAction) : LearningProblemActionResult
		{
			// Create the result structure
			var result : LearningProblemActionResult;

			// Find the destination
			var matrixIndex : int = state.index * actionsPerState + action.index;
			var di : int = destination[matrixIndex];
			result.state = states[di];
			result.reward = rewards[matrixIndex];

			return result;
		}
	}
}
