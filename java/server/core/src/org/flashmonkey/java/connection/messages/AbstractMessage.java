package org.flashmonkey.java.connection.messages;

import org.flashmonkey.java.core.net.NetObject;
import org.flashmonkey.java.message.api.IMessage;
import org.red5.io.amf3.IDataInput;
import org.red5.io.amf3.IDataOutput;

public abstract class AbstractMessage extends NetObject implements IMessage {

	protected String senderId;
	
	public AbstractMessage() {
		
	}
	
	public abstract Object read();
	
	public void write() {
		
	}
	
	public abstract void setService(Object service);
	
	public AbstractMessage(String senderId) {
		this.senderId = senderId;
	}
	
	public String getSenderId() {
		return senderId;
	}
	
	public void setSenderId(String senderId) {
		this.senderId = senderId;
	}

	//@Override
	public void readExternal(IDataInput input) {
		senderId = input.readUTF();
	}

	//@Override
	public void writeExternal(IDataOutput output) {
		output.writeUTF(senderId);
	}

}
