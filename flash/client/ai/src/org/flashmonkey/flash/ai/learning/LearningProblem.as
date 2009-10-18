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
	/**
	 * This is a class that you need to implement in order to
	 * represent the problem you're trying to solve to the learning
	 * system. Note that this problem assumes that the problem has a
	 * finite and easily numerable set of states. If this isn't true
	 * then some major recoding would be required.
	 */
	public class LearningProblem
	{
		/** Returns the number of states in the problem. */
		public function getStateCount() : int
		{
			return 0;	
		}

		/** Returns the maximum number of actions in the problem. */
		public function getActionCount() : int
		{
			return 0;	
		}

		/** Returns the state with the given index. */
		public function getState(index : int) : LearningProblemState
		{
			return null;	
		}

		/** Returns a random state at which to start learning. */
		public function getRandomState() : LearningProblemState
		{
			return null;	
		}

		/**
		 * Returns an initial state at which to start learning. The
		 * default implementation is to start at a random state.
		 */
		public function getInitialState() : LearningProblemState
		{
			return getRandomState();
		}	

		/** Returns the list of actions that are valid from the given state. */
		public function getActions(state : LearningProblemState) : LearningProblemAction
		{
			return null;	
		}

		/**
		 * Returns the result of taking the given action from the
		 * given state.
		 */
		public function getResult(state : LearningProblemState, action : LearningProblemAction) : LearningProblemActionResult
		{
			return null;
		}
	}
}
