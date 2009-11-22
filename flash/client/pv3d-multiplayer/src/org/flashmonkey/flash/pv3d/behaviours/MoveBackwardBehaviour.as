package org.flashmonkey.flash.pv3d.behaviours
{
	import org.flashmonkey.flash.api.IAvatar;
	import org.flashmonkey.flash.api.IBehaviour;
	import org.flashmonkey.flash.api.IInput;
	import org.papervision3d.objects.DisplayObject3D;

	public class MoveBackwardBehaviour implements IBehaviour
	{
		public function MoveBackwardBehaviour()
		{
		}

		public function apply(avatar:IAvatar):void
		{
			var input:IInput = avatar.input;
			
			if (input.moveBackward)
			{
				DisplayObject3D(avatar.object.displayObject).moveBackward(5);
			}
		}
		
	}
}