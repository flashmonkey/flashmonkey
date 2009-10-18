package org.flashmonkey.flash.api.ai.sm
{
	import org.springextensions.actionscript.mvcs.service.operation.IOperation;
	
	public interface ITransition
	{
		/**
		 * The transition returns a target state to transition to.
		 */
		function get targetState() : IStateMachineState;
		function set targetState(value:IStateMachineState):void;
		
		/**
		 * The transition needs to decide if it can be triggered or
		 * not. This will depend on the sub-class of transition we're
		 * dealing with.
		 */
		function get isTriggered() : Boolean;
		function set isTriggered(value:Boolean):void;

		/**
		 * The transition can also optionally return a list of actions
		 * that need to be performed during the transition.
		 *
		 * Note that this method should return one or more newly
		 * created action instances, and the caller of this method
		 * should be responsible for the deletion. In the default
		 * implementation, it returns nothing.
		 */
		function get operation() : IOperation;
		function set operation(value:IOperation):void;
	}
}