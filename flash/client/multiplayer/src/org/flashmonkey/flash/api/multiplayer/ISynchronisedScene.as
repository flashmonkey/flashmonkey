package org.flashmonkey.flash.api.multiplayer
{
	public interface ISynchronisedScene
	{
		function addAvatar(avatar:ISynchronisedAvatar):ISynchronisedAvatar;
		
		function removeAvatar(avatar:ISynchronisedAvatar):ISynchronisedAvatar;
		
		function get scene():*;
		function set scene(value:*):void;
	}
}