package org.flashmonkey.flash.multiplayer.avatar 
{
	import org.flashmonkey.flash.api.IInput;
	import org.flashmonkey.flash.api.IState;
	
	import flash.events.Event;	

	/**
	 * @author Trevor
	 */
	public class PhysicsEnabledLocalAvatar extends LocalAvatar 
	{
		/**
		 * The amount that this object's time will change by on the next update() call.
		 */
		public var deltaTime : Number = 1;

		public var lastTime : int = 0;

		public function PhysicsEnabledLocalAvatar()
		{
			super( );
		}

		override public function update(e:Event = null) : void
		{								
			_time += deltaTime;
				
			var integerTime : int = int( _time ) - lastTime;
			
			while (integerTime > 0)
			{				
				integerTime -= 1;
			}
			
			lastTime = int( _time );
			
			// update scene
			super.update( );		
		}

		override public function synchronise(time : int, input : IInput, state : IState) : void
		{            	
			// Handle the server time update.
			if (time > _time)
			{
				deltaTime = 1.25;
			}
			else if (time < _time)
			{
				deltaTime = 0.75;
			}
			else
			{
				deltaTime = 1.0;
			}
		}
	}
}
