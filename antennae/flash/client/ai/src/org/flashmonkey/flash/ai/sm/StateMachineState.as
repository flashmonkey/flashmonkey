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
	
	import flash.utils.Dictionary;
	
	import org.as3commons.logging.ILogger;
	import org.as3commons.logging.LoggerFactory;
	import org.springextensions.actionscript.mvcs.service.operation.IOperation;	
	
	/**
	 * This represents one internal state a character be in: such as
     * angry, or searching-for-ammo.
     */
	public class StateMachineState implements IStateMachineState
	{
		private static var log:ILogger = LoggerFactory.getLogger("StateMachineState");
		
		/**
		 * The list of transitions that can occur from this state.
		 */
		private var _transitions:Array = [];
		
		/**
		 * The first in the sequence of transitions that can leave
		 * this state.
		 */
		public function get transitions() : Array
		{
			return _transitions;
		}
		
		public function addTransition(transition:ITransition):void
		{
			_transitions.push(transition);
		}

		private var _operation:IOperation;
		
		/**
		 * Returns the first in a sequence of actions that should be
		 * performed while the character is in this state.
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
			_operation = value
		}

		private var _entryOperation:IOperation;

		/**
		 * Returns the sequence of actions to perform when arriving in
		 * this state.
		 *
		 * Note that this method should return one or more newly
		 * created action instances, and the caller of this method
		 * should be responsible for the deletion. In the default
		 * implementation, it returns nothing.
		 */
		public function get entryOperation() : IOperation
		{
			log.debug("Getting entryOperation " + _entryOperation);
			return _entryOperation;	
		}
		
		public function set entryOperation(value:IOperation) : void
		{
			_entryOperation = value;
		}

		private var _exitOperation:IOperation;

		/**
		 * Returns the sequence of actions to perform when leaving
		 * this state.
		 *
		 * Note that this method should return one or more newly
		 * created action instances, and the caller of this method
		 * should be responsible for the deletion. In the default
		 * implementation, it returns nothing.
		 */
		public function get exitOperation() : IOperation
		{
			log.debug("Getting exitOperation " + _exitOperation);
			return _exitOperation;	
		}
		
		public function set exitOperation(value:IOperation):void
		{
			_exitOperation = value;
		}
	}
}
