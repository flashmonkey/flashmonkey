package org.flashmonkey.flash.core.game
{
	import org.flashmonkey.flash.api.IAvatar;
	
	public interface IGame
	{
		function addAvatar(avatar:IAvatar):void;
		
		function removeAvatar(avatar:IAvatar):void;
	}
}