package org.flashmonkey.flash.ai.scheduling 
{
	import org.flashmonkey.flash.core.action.Action;

	/**
	 * @author Trevor
	 */
	public class ScheduledObject implements Scheduleable
	{
		public var behaviour:Action;
		
		public var frequency:int;
		
		public var phase:int;
		
		public var priority : int;
		
		public function run(time : int = 0) : void
		{
		}
	}
}
