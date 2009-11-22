package org.flashmonkey.java.connection.messages;

import java.util.Map;

import org.flashmonkey.java.connection.red5.service.api.IMultiplayerService;
import org.flashmonkey.java.player.api.IPlayer;

public class BroadcastMessage extends BaseMessage {
	
	public Object read() {
		Map<String, IPlayer> players = service.getPlayers();

		for (String key : players.keySet()) {
			IPlayer player = players.get(key);

			if (!player.getId().equals(getSenderId())) {
				player.addMessage(this);
			}
		}

		return null;
	}
	
	//@Override 
	public void write() {
		
	}
}
