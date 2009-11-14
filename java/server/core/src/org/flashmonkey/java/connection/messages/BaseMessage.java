package org.flashmonkey.java.connection.messages;

import org.flashmonkey.java.connection.red5.service.api.IMultiplayerService;
import org.flashmonkey.java.core.net.NetObject;
import org.flashmonkey.java.message.api.IMessage;
import org.red5.io.amf3.IDataInput;
import org.red5.io.amf3.IDataOutput;

public class BaseMessage extends NetObject implements IMessage {

	protected String senderId;
	
	public BaseMessage() {
		
	}
	
	public BaseMessage(String senderId) {
		this.senderId = senderId;
	}
	
	public String getSenderId() {
		return senderId;
	}
	
	public void setSenderId(String senderId) {
		this.senderId = senderId;
	}
	
	public void write(IMultiplayerService service) {
		
	}
	
	public Object read(IMultiplayerService service) {
		return null;
	}

	public void readExternal(IDataInput input) {
		System.out.println("Writing Base Message");
		senderId = input.readUTF();
	}

	public void writeExternal(IDataOutput output) {
		output.writeUTF(senderId);
	}

}
