package org.flashmonkey.java.rm;

import org.red5.io.amf3.IDataInput;
import org.red5.io.amf3.IDataOutput;

public abstract class AbstractMessage implements IMessage {

	protected String senderId;
	
	public AbstractMessage() {
		
	}
	
	public void read(IMessageService service) {
		
	}
	
	public void write(IMessageService service) {
		
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

	public void readExternal(IDataInput input) {
		senderId = input.readUTF();
	}

	public void writeExternal(IDataOutput output) {
		output.writeUTF(senderId);
	}

}
