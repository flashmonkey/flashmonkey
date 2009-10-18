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
package org.flashmonkey.flash.ai.sm 
{
	import org.flashmonkey.flash.api.ai.sm.IStateMachineState;
	import org.flashmonkey.flash.api.ai.sm.ITransition;
	
	import org.as3commons.logging.ILogger;
	import org.as3commons.logging.LoggerFactory;
	import org.springextensions.actionscript.mvcs.service.operation.AsyncOperationSequence;
	import org.springextensions.actionscript.mvcs.service.operation.IOperation;	
	
	/**
	 * @author Trevor
	 */
	public class StateMachine 
	{
		private static var log:ILogger = LoggerFactory.getLogger("StateMachine");
		
		/**
		 * Holds the initial state (a pointer into the 'state' array).
		 */
		private var _initialState : IStateMachineState;
		
		public function set initialState(value:IStateMachineState):void 
		{
			_initialState = value;
		}

		/**
		 * Holds the current state of the machine.
		 */
		private var _currentState : IStateMachineState;
		
		public function get currentState():IStateMachineState
		{
			return _currentState;
		}

		/**
		 * This method runs the state machine - it checks for
		 * transitions, applies them and returns a list of actions.
		 */
		public function update() : IOperation
		{
			// The variable to hold the actions to perform
			var operations : AsyncOperationSequence = new AsyncOperationSequence();
	
			// First case - we have no current state.
			if (_currentState == null)
			{
				// In this case we use the entry action for the initial state.
				if (_initialState != null) 
				{	
					// Transition to the first state
					_currentState = _initialState;
	
					// Returns the initial states entry actions
					operations.addOperation(_currentState.entryOperation);
				}
			}
	
	        // Otherwise we have a current state to work with
	        else 
			{
				// Start off with no transition
				var transition : ITransition;
	
				// Check through each transition in the current state.
				for each (var t:ITransition in _currentState.transitions)
				{
					if (t.isTriggered) 
					{
						transition = t;
						break;
					}
				}
	
				// Check if we found a transition
				if (transition) 
				{
					// Find our destination
					var nextState : IStateMachineState = transition.targetState;
					log.debug(transition + " next state: " + nextState);
					// Add each element to the list in turn
					operations.addOperation(_currentState.exitOperation);	
					operations.addOperation(transition.operation);	
					operations.addOperation(nextState.entryOperation);
	
					// Update the change of state
					_currentState = nextState;
				}
	
	            // Otherwise our actions to perform are simply those for the
	            // current state.
	            else 
				{	
					operations.addOperation(_currentState.operation);
				}
			}
	
			return operations;	
		}
	}
}
