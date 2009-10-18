package org.flashmonkey.java.message;

import java.util.Map;

import org.flashmonkey.java.connection.red5.service.api.IMultiplayerService;
import org.flashmonkey.java.player.api.IPlayer;

public class BroadcastMessage extends AbstractMessage {

	@Override
	public void read(IMultiplayerService service) {
		Map<String, IPlayer> players = service.getPlayers();

		for (String key : players.keySet()) {
			IPlayer player = players.get(key);

			if (!player.getId().equals(getSenderId())) {
				player.sendMessage(this);
			}
		}

	}
	
	@Override 
	public void write(IMultiplayerService service) {
		
	}
}
