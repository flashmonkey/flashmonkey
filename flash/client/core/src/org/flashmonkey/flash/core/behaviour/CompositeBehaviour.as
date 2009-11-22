package org.flashmonkey.flash.core.behaviour
{
	import org.flashmonkey.flash.api.IAvatar;
	import org.flashmonkey.flash.api.IBehaviour;

	public class CompositeBehaviour implements IBehaviour
	{
		protected var _behaviours:Array = [];
		
		public function CompositeBehaviour()
		{
		}
		
		public function addBehaviour(behaviour:IBehaviour):void 
		{
			_behaviours.push(behaviour);
		}
		
		public function removeBehaviour(behaviour:IBehaviour):void 
		{
			for (var i:int = 0; i < _behaviours.length; i++)
			{
				if (IBehaviour(_behaviours[i]) == behaviour)
				{
					_behaviours.splice(i, 1);
					break;
				}
			}
		}

		public function apply(avatar:IAvatar):void
		{
			for each (var behaviour:IBehaviour in _behaviours)
			{
				behaviour.apply(avatar);
			}
		}
		
	}
}