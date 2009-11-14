package org.flashmonkey.flash.multiplayer.avatar
{
	import org.flashmonkey.flash.api.multiplayer.ISynchronisedAvatar;
	import org.springextensions.actionscript.mvcs.service.operation.AbstractOperation;

	public class UpdateAvatarOperation extends AbstractOperation
	{
		private var _avatar:ISynchronisedAvatar;
		
		public function UpdateAvatarOperation(avatar:ISynchronisedAvatar)
		{
			super(this);
			
			_avatar = avatar;
		}
		
		public override function execute():void 
		{
			_avatar.update();
			
			dispatchResult(this);
		}
	}
}