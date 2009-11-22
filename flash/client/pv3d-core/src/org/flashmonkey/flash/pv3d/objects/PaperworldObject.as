package org.flashmonkey.flash.pv3d.objects
{
	import org.flashmonkey.flash.api.IInput;
	import org.flashmonkey.flash.api.IState;
	import org.flashmonkey.flash.api.ISynchronisedObject;
	import org.flashmonkey.flash.core.action.Action;
	import org.flashmonkey.flash.pv3d.behaviours.BasePV3DBehaviour;
	import org.papervision3d.core.math.Matrix3D;
	import org.papervision3d.objects.DisplayObject3D;

	public class PaperworldObject implements ISynchronisedObject
	{
		private var _behaviour:Action;
		
		public function get behaviour():Action
		{
			return _behaviour;
		}
		
		public function set behaviour(value:Action):void
		{
			_behaviour = value;
			BasePV3DBehaviour(_behaviour).actor = this;
		}
		
		private var _displayObject:DisplayObject3D;
		
		public function get displayObject():*
		{
			return _displayObject;
		}
		
		public function set displayObject(value:*):void 
		{
			_displayObject = value;
		}
		
		public function PaperworldObject()
		{
		}

		public function synchronise(time : int, input : IInput, state : IState) : void
		{
			/*var m:Matrix3D = Matrix3D.quaternion2matrix(state.orientation.x, state.orientation.y, state.orientation.z, state.orientation.w, _displayObject.transform);

			m.n14 = state.position.x;
			m.n24 = state.position.y;
			m.n34 = state.position.z;
			
			_displayObject.transform = m;*/
		}
		
	}
}