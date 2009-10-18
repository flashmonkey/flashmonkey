package org.flashmonkey.flash.api.ai.sm
{
	import flash.utils.Dictionary;
	
	import org.springextensions.actionscript.mvcs.service.operation.IOperation;
	
	public interface IStateMachineState
	{
		/**
		 * The first in the sequence of transitions that can leave
		 * this state.
		 */
		function get transitions() : Array;
		
		function addTransition(transition:ITransition):void;
		
		/**
		 * Returns the first in a sequence of actions that should be
		 * performed while the character is in this state.
		 *
		 * Note that this method should return one or more newly
		 * created action instances, and the caller of this method
		 * should be responsible for the deletion. In the default
		 * implementation, it returns nothing.
		 */
		function get operation() : IOperation;

		/**
		 * Returns the sequence of actions to perform when arriving in
		 * this state.
		 *
		 * Note that this method should return one or more newly
		 * created action instances, and the caller of this method
		 * should be responsible for the deletion. In the default
		 * implementation, it returns nothing.
		 */
		function get entryOperation() : IOperation;
		function set entryOperation(value:IOperation):void;

		/**
		 * Returns the sequence of actions to perform when leaving
		 * this state.
		 *
		 * Note that this method should return one or more newly
		 * created action instances, and the caller of this method
		 * should be responsible for the deletion. In the default
		 * implementation, it returns nothing.
		 */
		function get exitOperation() : IOperation;
		function set exitOperation(value:IOperation):void;
	}
}