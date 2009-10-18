package org.flashmonkey.flash.ai.scheduling 
{
	import flash.utils.getTimer;
	
	import org.springextensions.actionscript.collections.IMap;
	import org.springextensions.actionscript.collections.Map;	

	/**
	 * @author Trevor
	 */
	public class LoadBalancingScheduler implements Scheduleable
	{
		public var behaviours : IMap;

		public var frame : int = 0;

		public var currentTime : int = 0;

		public var lastTime : int = 0;

		public function LoadBalancingScheduler()
		{
			super( );
		}

		public function initialise() : void
		{
			behaviours = new Map( );	
		}

		public function addBehaviour(scheduledObject : ScheduledObject) : void
		{
			behaviours.put( scheduledObject.frequency, scheduledObject );
		}

		public function run(time : int = 0) : void
		{
			// Increment the frame number.
			frame++;
			
			// Keep a list of behaviours to run.
			var runThese : Array = new Array( );
			
			var scheduled : ScheduledObject;
			
			// Go through each behaviour.
			/*var iterator : Iterator = behaviours.getIterator( );
			
			while (iterator.hasNext( ))
			{
				scheduled = ScheduledObject( iterator.next( ) );
				
				if (scheduled.frequency % (frame + scheduled.phase))
				{
					runThese.push( scheduled );
				}
			}*/
			
			// Keep track of the current time.
			lastTime = getTimer( );
			
			// Find the number of behaviours we need to run.
			var numToRun : int = runThese.length;
			
			// Go through the behaviours to run.
			for (var i : int = 0; i < numToRun ; i++)
			{
				// Find the available time.
				scheduled = ScheduledObject( runThese[i] );
				currentTime = getTimer( );
				var timeToRun : int = currentTime - lastTime;
				var availableTime : int = timeToRun / (numToRun - i);	
				
				// Run the function.
				scheduled.run( availableTime );
				
				lastTime = currentTime;
			}
		}
	}
}
