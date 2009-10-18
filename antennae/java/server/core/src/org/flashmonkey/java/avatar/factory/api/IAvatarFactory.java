package org.flashmonkey.java.avatar.factory.api;

import org.flashmonkey.java.avatar.api.IAvatar;
import org.flashmonkey.java.player.api.IPlayer;

public interface IAvatarFactory {

	public IAvatar getAvatar(IPlayer player);
}
