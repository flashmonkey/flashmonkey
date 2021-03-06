package org.flashmonkey.flash.pv3d.behaviours
{
	import org.flashmonkey.flash.api.IAvatar;
	import org.flashmonkey.flash.api.IBehaviour;
	import org.flashmonkey.flash.api.IInput;
	import org.papervision3d.objects.DisplayObject3D;

	public class StrafeRightBehaviour implements IBehaviour
	{
		public function StrafeRightBehaviour()
		{
		}

		public function apply(avatar:IAvatar):void
		{
			var input:IInput = avatar.input;
			
			if (input.moveRight)
			{
				DisplayObject3D(avatar.object.displayObject).moveRight(5);
			}
		}
		
	}
}