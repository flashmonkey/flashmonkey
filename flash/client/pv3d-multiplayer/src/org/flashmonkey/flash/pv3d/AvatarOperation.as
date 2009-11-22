package org.flashmonkey.flash.pv3d
{
	import com.joeberkovitz.moccasin.service.AbstractOperation;
	
	import flash.events.Event;
	
	import org.flashmonkey.flash.api.AvatarType;
	import org.flashmonkey.flash.api.IAvatar;
	import org.flashmonkey.flash.multiplayer.avatar.LocalAvatar;
	import org.flashmonkey.flash.multiplayer.avatar.RemoteAvatar;

	public class AvatarOperation extends AbstractOperation
	{
		protected var _type:AvatarType;
		
		protected var _avatar:IAvatar;
		
		public function AvatarOperation(type:AvatarType)
		{
			super();
			
			_type = type;
		}
		
		public override function execute():void
		{
			switch (_type)
			{
				case AvatarType.LOCAL:
					_avatar = new LocalAvatar();
					break;
					
				case AvatarType.REMOTE:
					_avatar = new RemoteAvatar();
					break;
					
				default:
					break;
			}
			
			handleComplete(new Event(Event.COMPLETE));
		}
		
		public override function get result():* 
		{
			return _avatar;
		}
	}
}