package org.flashmonkey.java.avatar.factory;

import org.flashmonkey.java.avatar.SimpleAvatar;
import org.flashmonkey.java.avatar.api.IAvatar;
import org.flashmonkey.java.avatar.factory.api.IAvatarFactory;
import org.flashmonkey.java.player.api.IPlayer;

public class SimpleAvatarFactory implements IAvatarFactory {

	public SimpleAvatarFactory() {
		
	}
	
	public IAvatar getAvatar(IPlayer player) {
		IAvatar avatar = new SimpleAvatar();
		avatar.setOwner(player);
		
		return avatar;
	}

}
