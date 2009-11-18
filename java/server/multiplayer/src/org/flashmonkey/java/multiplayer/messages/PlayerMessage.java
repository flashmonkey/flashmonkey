package org.flashmonkey.java.multiplayer.messages;

import org.flashmonkey.java.api.message.IPlayerMessage;
import org.flashmonkey.java.connection.messages.BaseMessage;
import org.flashmonkey.java.connection.red5.service.api.IMultiplayerService;
import org.red5.io.amf3.IDataInput;
import org.red5.io.amf3.IDataOutput;

public abstract class PlayerMessage extends BaseMessage implements IPlayerMessage {

	private String playerId;
	
	public PlayerMessage() {
		super(null);
	}
	
	public PlayerMessage(String senderId, String playerId) {
		super(senderId);
		
		this.playerId = playerId;
	}
	
	@Override
	public Object read() {
		service.getPlayers().get(playerId).addMessage(this);
		
		return null;
	}
	
	public String getPlayerId() {
		return playerId;
	}
	
	public void setPlayerId(String playerId) {
		this.playerId = playerId;
	}
	
	//@Override
	public void readExternal(IDataInput input) {
		super.readExternal(input);
		
		playerId = input.readUTF();
	}

	//@Override
	public void writeExternal(IDataOutput output) {
		super.writeExternal(output);
		
		output.writeUTF(playerId);
	}

}
