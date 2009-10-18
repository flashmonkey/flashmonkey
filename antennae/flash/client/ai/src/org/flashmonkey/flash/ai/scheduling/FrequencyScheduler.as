package org.flashmonkey.flash.ai.scheduling 
{
	/**
	 * @author Trevor
	 */
	public class FrequencyScheduler extends ScheduledObject
	{
		public var behaviours : Array;

		public var frame : int = 0;

		public function FrequencyScheduler()
		{
			super( );	
		}

		public function initialise() : void
		{
			behaviours = new Array( );	
		}

		public function addBehaviour(scheduledObject : ScheduledObject) : void
		{			
			behaviours.push( scheduledObject );
		}

		override public function run(time : int = 0) : void
		{
			frame++;
			
			for each (var behaviour:ScheduledObject in behaviours)
			{
				if (behaviour.frequency % (frame + behaviour.phase))
				{
					behaviour.run( );
				}	
			}	
		}
	}
}
