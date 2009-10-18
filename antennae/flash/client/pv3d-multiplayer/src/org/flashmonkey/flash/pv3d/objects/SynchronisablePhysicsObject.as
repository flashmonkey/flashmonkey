package org.flashmonkey.flash.pv3d.objects 
{
	import org.flashmonkey.flash.api.IInput;
	import org.flashmonkey.flash.api.IPaperworldObject;
	import org.flashmonkey.flash.api.IState;
	
	import org.papervision3d.objects.DisplayObject3D;	

	/**
	 * @author Trevor
	 */
	public class SynchronisablePhysicsObject implements IPaperworldObject
	{
		private var _displayObject : *;
		
		public function get displayObject() : *
		{
			return _displayObject;
		}

		public function set displayObject(value : *) : void
		{
			_displayObject = value
		}

		public function SynchronisablePhysicsObject(displayObject : DisplayObject3D = null, physicsObject : * = null) 
		{			
			this.displayObject = displayObject;
		}

		public function synchronise(time : int, input : IInput, state : IState) : void
		{
			//physicsObject.px = state.position.x;
			//physicsObject.py = state.position.y;
			//physicsObject.velocity = new Vector3( state.velocity.x, state.velocity.z );
			
			super.synchronise( time, input, state );
		}
	}
}
