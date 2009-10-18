package org.flashmonkey.flash.ai.sm
{
	import org.flashmonkey.flash.api.ai.sm.ICondition;
	import org.flashmonkey.flash.api.ai.sm.IStateMachineState;

	public class ConditionAwareTransition extends Transition
	{
		private var _conditions:Array = [];
		
		override public function get isTriggered() : Boolean
		{
			for each (var condition:ICondition in _conditions)
			{
				if (condition.test())
				{
					return true;
				}
			}	
			
			return false;
		}
		
		public function ConditionAwareTransition(targetState:IStateMachineState=null, conditions:Array=null)
		{
			super(targetState);
			
			if (conditions)
			{
				_conditions = conditions;
			}
		}
		
		public function addCondition(condition:ICondition):void 
		{
			if (condition != null)
			{
				_conditions.push(condition);
			}
		}
	}
}