package org.flashmonkey.flash.pv3d
{
	import com.pblabs.engine.PBE;
	
	import org.flashmonkey.flash.api.IPaperworldObject;
	import org.flashmonkey.flash.api.multiplayer.ISynchronisedAvatar;
	import org.flashmonkey.flash.multiplayer.api.IAvatarFactory;
	import org.flashmonkey.flash.multiplayer.avatar.LocalAvatar;
	import org.flashmonkey.flash.multiplayer.avatar.RemoteAvatar;
	import org.flashmonkey.flash.pv3d.objects.PaperworldObject;
	import org.flashmonkey.flash.utils.input.BasicKeyboardInput;
	import org.papervision3d.objects.primitives.Sphere;

	public class SphereAvatarFactory implements IAvatarFactory
	{
		public function SphereAvatarFactory()
		{
		}

		public function getAvatar(key:String):ISynchronisedAvatar
		{
			var s:Sphere = new Sphere();
			
			var avatar:ISynchronisedAvatar;
			
			if (key == "remote")
			{
				avatar = new RemoteAvatar();
			}
			else
			{
				avatar = new LocalAvatar();
				avatar.userInput = new BasicKeyboardInput(PBE.mainStage);
			}
			
			var syncObject:IPaperworldObject = new PaperworldObject();
			syncObject.displayObject = s;
			
			avatar.object = syncObject;
			
			return avatar;
		}
		
	}
}