package org.flashmonkey.java.multiplayer.messages;

import org.flashmonkey.java.api.message.ISynchroniseCreateMessage;
import org.flashmonkey.java.avatar.api.IAvatar;
import org.flashmonkey.java.connection.messages.BroadcastMessage;
import org.flashmonkey.java.connection.red5.service.api.IMultiplayerService;
import org.flashmonkey.java.core.objects.BasicState;
import org.flashmonkey.java.input.api.IInput;
import org.flashmonkey.java.player.api.IPlayer;
import org.red5.io.amf3.IDataInput;
import org.red5.io.amf3.IDataOutput;

public class SynchroniseCreateMessage extends BroadcastMessage implements
		ISynchroniseCreateMessage {

	private String playerId;
	
	private String objectId;
	
	private IInput input;
	
	private BasicState state;
	
	public SynchroniseCreateMessage() {
		
	}
	
	@Override
	public Object read() {		
		IPlayer player = service.getPlayer(getPlayerId());
		
		IAvatar avatar = player.getScopeObject();
		System.out.println("Object id for avatar " + getObjectId());
		avatar.setId(getObjectId());
		
		// Get all the currently registered avatars.
		// We need to let the new player know about them.
		for (IAvatar currentAvatar : service.getAvatars()) {
			ISynchroniseCreateMessage syncCreateMessage = new SynchroniseCreateMessage();
			syncCreateMessage.setPlayerId(avatar.getOwner().getId());
			syncCreateMessage.setObjectId(avatar.getId());
			syncCreateMessage.setInput(avatar.getInput());
			syncCreateMessage.setState(avatar.getState());
			
			player.addMessage(syncCreateMessage);
		}

		service.registerAvatar(avatar);

		setInput(avatar.getInput());
		setState(avatar.getState());
		
		return super.read();
	}
	
	public String getPlayerId() {
		return playerId;
	}

	public void setPlayerId(String playerId) {
		this.playerId = playerId;
	}
	
	public String getObjectId() {
		return objectId;
	}
	
	public void setObjectId(String objectId) {
		this.objectId = objectId;
	}
	
	public IInput getInput() {
		return input;
	}
	
	public void setInput(IInput input) {
		this.input = input;		
	}

	public BasicState getState() {
		return state;
	}	

	public void setState(BasicState state) {
		this.state = state;
	}
	
	@Override
	public void readExternal(IDataInput input) {
		super.readExternal(input);
		
		playerId = input.readUTF();
		objectId = input.readUTF();
		
		this.input = (IInput) input.readObject();
		state = (BasicState) input.readObject();
	}

	@Override
	public void writeExternal(IDataOutput output) {
		super.writeExternal(output);
		
		output.writeUTF(playerId);
		output.writeUTF(objectId);
		
		output.writeObject(input);
		output.writeObject(state);
	}
}
