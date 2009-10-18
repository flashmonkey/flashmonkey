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
package org.flashmonkey.flash.ai.sm.markov 
{
	import org.flashmonkey.flash.api.ai.sm.ITransition;
	import org.flashmonkey.flash.core.action.Action;		

	/**
	 * The markov state machine is responsible for keeping track of
	 * the current array of states and modifying them under influence
	 * of transitions.
	 */
	public class MarkovStateMachine 
	{
		/**
		 * Holds the values in the state vector. Note that there is no
		 * separate set of initial values. Unlike a regular state
		 * machine, it doesn't make sense for a markov state machine
		 * to be in an indefinite initial state. It needs to be set up
		 * with starting numbers.
		 */
		public var stateVector : Number;

		/**
		 * Holds the number of values in the state vector.
		 */
		public var stateVectorSize : int;

		/**
		 * Unlike other state machines the transitions are a feature
		 * of the machine itself.
		 */
		public var firstTransition : MarkovTransition;

		/**
		 * Holds the transition that will fire after a while if no
		 * other transitions fire.
		 */
		public var defaultTransition : MarkovTransition;

		/**
		 * Holds the number of frames of inactivity before the default
		 * transition fires.
		 */
		public var framesToDefault : int;

		/**
		 * Keeps track of the number of frames since a transition fired.
		 */
		public var framesPassed : int;

		/**
		 * This method runs the state machine - it checks for
		 * transitions, applies them and returns a list of actions.
		 */
		public function update() : Action
		{
			// The variable to hold the actions to perform
			var actions : Action;

			// Start off with no transition
			var transition : MarkovTransition;

			// Check through each transition in the current state.
			var testTransition : ITransition = firstTransition;
			
			/*while (testTransition) 
			{
				if (testTransition.isTriggered) 
				{
					transition = MarkovTransition(testTransition);
					break;
				}
				
				testTransition = testTransition.next;
			}*/

			// Check if we need to run the default transition
			framesPassed++;
			
			if (transition == null && framesPassed > framesToDefault)
			{
				transition = defaultTransition;
			}

			// Check if we found a transition
			if (transition != null) 
			{
				// Find the matrix and update the state vector
				var matrix : Array = transition.getMatrix();
				updateStateVector(matrix);

				// The actions are those given by the transition
				//actions = transition.getActions();

				// Stop the counting
				framesPassed = 0;
			}

			// NB: We don't have an else for what to do if there is no
			// transition, since there is no simple way to map a multitude
			// of states to responsibility for generating actions - its
			// left for the user to do in whatever way makes sense for
			// their application. One simple possibility would be to have
			// a default action to perform if no transitions were fired.
			return actions;	
		}

		/**
		 * This helper function does the state vector update.
		 */
		protected function updateStateVector(matrix : Array) : void
		{
			var i : int;
			
			// Create temporary storage and zero it
			var tempState : Array = new Array(stateVectorSize);
			//memset(tempState, 0, sizeof(real) * stateVectorSize);
			for (i = 0;i < stateVectorSize; i++)
			{
				tempState[i] = 0;	
			}
	
			// Now work through each element of the matrix
			for (i = 0;i < stateVectorSize * stateVectorSize; i++)
			{
				// Work out which item in the state vector and target
				// vector we're affecting. Note that if you want the
				// matrix to be post-multiplied, then change the % and /
				// operators in these two lines.
				var stateIndex : int = i % stateVectorSize;
				var	targetIndex : int = i / stateVectorSize;
	
				// Add this component
				tempState[targetIndex] += matrix[i] * stateVector[stateIndex];
			}
	
			// Copy across the new vector's data
			//memcpy(stateVector, tempState, sizeof(real) * stateVectorSize);	
			for (i = 0;i < stateVectorSize; i++)
			{
				stateVector[i] = tempState[i];	
			}
		}
	}
}
