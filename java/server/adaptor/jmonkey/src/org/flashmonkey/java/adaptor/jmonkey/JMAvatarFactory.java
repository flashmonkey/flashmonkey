package org.flashmonkey.java.adaptor.jmonkey;

import org.flashmonkey.java.avatar.api.IAvatar;
import org.flashmonkey.java.avatar.factory.api.IAvatarFactory;
import org.flashmonkey.java.player.api.IPlayer;

public class JMAvatarFactory implements IAvatarFactory {

	public JMAvatarFactory() {
		
	}
	
	public IAvatar getAvatar(IPlayer player) {
		IAvatar avatar = new JMAvatar();
		avatar.setOwner(player);
		
		return avatar;
	}

}
