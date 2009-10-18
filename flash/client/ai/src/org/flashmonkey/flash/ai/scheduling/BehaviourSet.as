package org.flashmonkey.flash.ai.scheduling 
{
	import org.springextensions.actionscript.collections.IMap;
	import org.springextensions.actionscript.collections.Map;
	
	/**
	 * @author Trevor
	 */
	public class BehaviourSet
	{
		public var functionLists:IMap;
		
		public var frequency:int = 0;
		
		public function BehaviourSet()
		{
			super();	
		}
		
		public function initialise():void
		{
			functionLists = new Map();	
		}
	}
}
