package org.flashmonkey.flash.pv3d.behaviours
{
	import org.flashmonkey.flash.api.IAvatar;
	import org.flashmonkey.flash.core.behaviour.CompositeBehaviour;
	import org.flashmonkey.flash.utils.math.Quaternion;
	import org.flashmonkey.flash.utils.math.Vector3f;
	import org.papervision3d.objects.DisplayObject3D;

	public class StateSettingCompositeBehaviour extends CompositeBehaviour
	{
		private static var toDEGREES 	:Number = 180/Math.PI;
		private static var toRADIANS 	:Number = Math.PI/180;
		
		public function StateSettingCompositeBehaviour()
		{
			super();
		}
		
		public override function apply(avatar:IAvatar):void
		{
			super.apply(avatar);
			
			var displayObject:DisplayObject3D = DisplayObject3D(avatar.object.displayObject);
			avatar.state.position = new Vector3f(displayObject.x, displayObject.y, displayObject.z);
			avatar.state.orientation.fromAngles(displayObject.rotationX * toRADIANS, displayObject.rotationY * toRADIANS, displayObject.rotationZ * toRADIANS);
		}
	}
}