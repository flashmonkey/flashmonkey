package org.flashmonkey.java.api.message;

import org.flashmonkey.java.message.api.IMessage;

public interface IPlayerMessage extends IMessage {

	public String getPlayerId();
	
	public void setPlayerId(String playerId);
}
