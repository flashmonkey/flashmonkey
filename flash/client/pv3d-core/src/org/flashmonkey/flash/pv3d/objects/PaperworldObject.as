package org.flashmonkey.flash.pv3d.objects
{
	import org.flashmonkey.flash.api.IInput;
	import org.flashmonkey.flash.api.IState;
	import org.flashmonkey.flash.api.ISynchronisedObject;
	import org.flashmonkey.flash.core.action.Action;
	import org.flashmonkey.flash.pv3d.behaviours.BasePV3DBehaviour;
	import org.papervision3d.objects.DisplayObject3D;

	public class PaperworldObject implements ISynchronisedObject
	{
		private static var toDEGREES 	:Number = 180/Math.PI;
		private static var toRADIANS 	:Number = Math.PI/180;
		
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
			_displayObject.x = state.position.x;
			_displayObject.y = state.position.y;
			_displayObject.z = state.position.z;

			var angles:Array = state.orientation.toAngles();

			_displayObject.rotationY = angles[1] * toDEGREES;
		}
		
	}
}