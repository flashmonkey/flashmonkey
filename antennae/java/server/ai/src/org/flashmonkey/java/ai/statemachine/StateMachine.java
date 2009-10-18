/*
 * Part of the Artificial Intelligence for Games system.
 *
 * Copyright (c) Ian Millington 2003-2006. All Rights Reserved.
 *
 * This software is distributed under licence. Use of this software
 * implies agreement with all terms and conditions of the accompanying
 * software licence.
 * 
 * Java port - Trevor Burton [worldofpaper@googlemail.com]
 */
package org.flashmonkey.java.ai.statemachine;

import org.flashmonkey.java.action.Action;

public class StateMachine
{
	/**
	 * Holds the initial state (a pointer into the 'state' array).
	 */
	public StateMachineState	initialState;
	
	/**
	 * Holds the current state of the machine.
	 */
	public StateMachineState	currentState;
	
	/**
	 * This method runs the state machine - it checks for transitions, applies
	 * them and returns a list of actions.
	 */
	public Action update()
	{
		// The variable to hold the actions to perform
		Action actions = null;
		
		// First case - we have no current state.
		if (currentState == null)
		{
			// In this case we use the entry action for the initial state.
			if (initialState != null)
			{
				
				// Transition to the first state
				currentState = initialState;
				
				// Returns the initial states entry actions
				actions = currentState.getEntryActions();
				
			}
			else
			{
				
				// We have nothing to do
				actions = null;
			}
		}
		
		// Otherwise we have a current state to work with
		else
		{
			// Start off with no transition
			Transition transition = null;
			
			// Check through each transition in the current state.
			BaseTransition testTransition = currentState.firstTransition;
			while (testTransition != null)
			{
				if (testTransition.isTriggered())
				{
					transition = (Transition) testTransition;
					break;
				}
				testTransition = testTransition.next;
			}
			
			// Check if we found a transition
			if (transition != null)
			{
				// Find our destination
				StateMachineState nextState = transition.getTargetState();
				
				// Accumulate our list of actions
				Action tempList = null;
				Action last = null;
				
				// Add each element to the list in turn
				actions = currentState.getExitActions();
				last = actions.getLast();
				
				tempList = transition.getActions();
				last.next = tempList;
				last = tempList.getLast();
				
				tempList = nextState.getActions();
				last.next = tempList;
				
				// Update the change of state
				currentState = nextState;
			}
			
			// Otherwise our actions to perform are simply those for the
			// current state.
			else
			{
				
				actions = currentState.getActions();
			}
		}
		
		return actions;
	}
}
