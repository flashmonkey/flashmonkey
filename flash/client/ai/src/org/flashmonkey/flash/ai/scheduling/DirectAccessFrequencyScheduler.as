package org.flashmonkey.flash.ai.scheduling 
{
	import org.springextensions.actionscript.collections.IMap;
	import org.springextensions.actionscript.collections.Map;
	
	/**
	 * @author Trevor
	 */
	public class DirectAccessFrequencyScheduler extends ScheduledObject
	{
		public var sets : IMap;

		public var frame : int = 0;

		public function DirectAccessFrequencyScheduler()
		{
			super( );
		}

		public function initialise() : void
		{
			sets = new Map( );
		}

		public function addBehaviour(scheduledObject : ScheduledObject) : void
		{
			// Find the correct set.
			var fSet : BehaviourSet = BehaviourSet( sets.get( scheduledObject.frequency ) );
			
			// Add the function to the list.
			Map( fSet.functionLists.get( scheduledObject.phase ) ).insert( scheduledObject.frequency, scheduledObject );
		}

		override public function run(time : int = 0) : void
		{
			// Increment the frame number.
			frame++;
			
			// Go through each frequency set.
			/*var iterator : Iterator = sets.getIterator( );
			
			while(iterator.hasNext( ))
			{
				var behaviourSet : BehaviourSet = BehaviourSet( iterator.next( ) );
				
				// Calculate the phase for this frequency.
				var phase : Number = behaviourSet.frequency % frame;
				
				var behavioursForPhase : Map = Map( behaviourSet.functionLists.get( phase ) );
				var setIterator : Iterator = behavioursForPhase.getIterator( );
				
				// Runs the behaviours.
				while(setIterator.hasNext( ))
				{
					Scheduleable( setIterator.next( ) ).run( );
				}	
			}	*/
		}
	}
}
