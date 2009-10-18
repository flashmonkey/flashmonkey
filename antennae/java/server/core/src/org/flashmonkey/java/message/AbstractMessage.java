package org.flashmonkey.java.message;

import org.flashmonkey.java.connection.red5.service.api.IMultiplayerService;
import org.flashmonkey.java.core.net.NetObject;
import org.flashmonkey.java.message.api.IMessage;
import org.red5.io.amf3.IDataInput;
import org.red5.io.amf3.IDataOutput;

public abstract class AbstractMessage extends NetObject implements IMessage {

	protected String senderId;
	
	public AbstractMessage() {
		
	}
	
	public abstract void read(IMultiplayerService service);
	
	public void write(IMultiplayerService service) {
		
	}
	
	public AbstractMessage(String senderId) {
		this.senderId = senderId;
	}
	
	public String getSenderId() {
		return senderId;
	}
	
	public void setSenderId(String senderId) {
		this.senderId = senderId;
	}

	@Override
	public void readExternal(IDataInput input) {
		senderId = input.readUTF();
	}

	@Override
	public void writeExternal(IDataOutput output) {
		output.writeUTF(senderId);
	}

}
