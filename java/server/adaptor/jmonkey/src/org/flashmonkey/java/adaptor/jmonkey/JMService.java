package org.flashmonkey.java.adaptor.jmonkey;

import org.flashmonkey.java.scene.api.IScene;
import org.flashmonkey.java.player.api.IPlayer;
import org.flashmonkey.java.service.SimpleService;

/**
 * Extends the SimpleService class to provide an adaptor for a JMonkey scene.
 * 
 * @author Trevor
 *
 */
public class JMService extends SimpleService {
	
	IScene scene;
	
	public JMService(String gameName) {
		scene = new JMScene(gameName);
	}
	
	@Override
	public IPlayer getPlayer(String id) {
		IPlayer player = super.getPlayer(id);
		player.setScopeObject(factory.getAvatar(player));
		return player;
	}
}
