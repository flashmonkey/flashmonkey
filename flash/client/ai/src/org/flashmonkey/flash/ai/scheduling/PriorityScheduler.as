package org.flashmonkey.flash.ai.scheduling 
{
	import flash.utils.getTimer;
	
	import org.springextensions.actionscript.collections.IMap;	

	/**
	 * @author Trevor
	 */
	public class PriorityScheduler extends ScheduledObject
	{
		public var behaviours : IMap;

		public var frame : int;
		
		public var currentTime : int = 0;

		public var lastTime : int = 0;

		public function addBehaviour(scheduledObject : ScheduledObject) : void
		{
			behaviours.put( scheduledObject.frequency, scheduledObject );
		}

		override public function run(time : int = 0) : void
		{
			// Increment the frame number.
			frame++;
			
			// Keep a list of behaviours to run and their total priority.
			var runThese:Array = new Array();
			var totalPriority:int = 0;
			
			var scheduled : ScheduledObject;
			
			// Go through each behaviour.
			/*var iterator : Iterator = behaviours.getIterator();
			
			while (iterator.hasNext())
			{
				scheduled = ScheduledObject(iterator.next());
				
				// If it is due, schedule it.
				if (scheduled.frequency % (frame + scheduled.phase))	
				{
					runThese.push(scheduled);
					totalPriority += scheduled.priority;	
				}
			}*/
			
			lastTime = getTimer();
			
			// Find the number of behaviours we need to run.
			var numToRun : int = runThese.length;
			
			// Go through the behaviours to run.
			for (var i:int = 0; i < numToRun; i++)
			{
				scheduled = ScheduledObject(runThese[i]);
				
				// Find the available time.
				currentTime = getTimer();
				var timeToRun:int = currentTime - lastTime;
				var availableTime:int = timeToRun * scheduled.priority / totalPriority;
				
				// Run the function.
				scheduled.run( availableTime );
				
				// Store the current time.
				lastTime = currentTime;	
			}
		}
	}
}
