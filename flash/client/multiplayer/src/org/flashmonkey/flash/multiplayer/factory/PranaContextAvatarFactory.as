package org.flashmonkey.flash.multiplayer.factory
{
	import org.flashmonkey.flash.api.multiplayer.ISynchronisedAvatar;
	import org.flashmonkey.flash.multiplayer.api.IAvatarFactory;	

	/**
	 * @author Trevor
	 */
	public class PranaContextAvatarFactory implements IAvatarFactory 
	{
		public function getAvatar(key : String) : ISynchronisedAvatar
		{
			return null;//ISynchronisedAvatar( CoreContext.getInstance( ).getObject( key ) );
		}
	}
}