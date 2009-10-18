package org.flashmonkey.flash.pv3d.behaviours
{
	public class RotateAroundY extends BasePV3DBehaviour
	{
		private var _rotation:Number = 1;
		
		public function get rotation():Number
		{
			return _rotation;
		}
		
		public function set rotation(value:Number):void 
		{
			_rotation = value;
		}
		
		public function RotateAroundY()
		{
			super();
		}
		
		override public function act():void
		{
			_actor.displayObject.yaw(rotation);
		}
		
	}
}