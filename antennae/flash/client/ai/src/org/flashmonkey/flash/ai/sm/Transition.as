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
	import org.springextensions.actionscript.mvcs.service.operation.IOperation;
	

	/**
     * Transitions map between state machines.
     */
	public class Transition implements ITransition 
	{
		private static var log:ILogger = LoggerFactory.getLogger("Transition");
		
		private var _targetState:IStateMachineState;
		
		private var _isTriggered:Boolean = false;
		
		/**
		 * The transition needs to decide if it can be triggered or
		 * not. This will depend on the sub-class of transition we're
		 * dealing with.
		 */
		public function get isTriggered() : Boolean
		{
			return _isTriggered;
		}
		
		public function set isTriggered(value:Boolean):void 
		{
			_isTriggered = value;
		}
		
		public function Transition(targetState:IStateMachineState = null)
		{
			_targetState = targetState;			
		}		
		
		/**
		 * The transition returns a target state to transition to.
		 */
		public function get targetState() : IStateMachineState
		{
			return _targetState;	
		}
		
		public function set targetState(value:IStateMachineState):void 
		{
			_targetState = value;
		}		
		
		private var _operation:IOperation;

		/**
		 * The transition can also optionally return a list of actions
		 * that need to be performed during the transition.
		 *
		 * Note that this method should return one or more newly
		 * created action instances, and the caller of this method
		 * should be responsible for the deletion. In the default
		 * implementation, it returns nothing.
		 */
		public function get operation() : IOperation
		{
			return _operation;	
		}
		
		public function set operation(value:IOperation):void 
		{
			_operation = value;
		}
	}
}
