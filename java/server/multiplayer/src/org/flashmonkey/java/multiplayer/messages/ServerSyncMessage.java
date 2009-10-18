package org.flashmonkey.java.multiplayer.messages;

import org.flashmonkey.java.api.message.IServerSyncMessage;
import org.flashmonkey.java.core.objects.BasicState;
import org.flashmonkey.java.input.api.IInput;
import org.red5.io.amf3.IDataInput;
import org.red5.io.amf3.IDataOutput;

public class ServerSyncMessage extends PlayerSyncMessage implements IServerSyncMessage {

	protected BasicState state;
	
	public ServerSyncMessage() {
		
	}
	
	public ServerSyncMessage(String senderId, String objectId, int time, IInput input, BasicState state) {
		super(senderId, objectId, time, input);
		
		this.state = state;
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

		state = (BasicState) input.readObject();
	}

	@Override
	public void writeExternal(IDataOutput output) {
		super.writeExternal(output);
		
		output.writeObject(state);
	}
	
	public String toString() {
		return "ServerSyncMessage[From: " + senderId + " RE: " + objectId + "]";
	}
}
