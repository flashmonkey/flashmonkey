package org.flashmonkey.flash.multiplayer.api 
{
	import org.flashmonkey.flash.api.multiplayer.ISynchronisedAvatar;
	

	/**
	 * @author Trevor
	 */
	public interface IAvatarFactory 
	{
		function getAvatar(key : String) : ISynchronisedAvatar;
	}
}
