package org.flashmonkey.java.multiplayer.messages;

import org.flashmonkey.java.connection.red5.service.api.IMultiplayerService;
import org.flashmonkey.java.message.AbstractMessage;
import org.red5.io.amf3.IDataInput;
import org.red5.io.amf3.IDataOutput;


public class RequestIdMessage extends AbstractMessage {

	private String id;
	
	public RequestIdMessage() {
		
	}
	
	public RequestIdMessage(String senderId) {
		super(senderId);
	}

	public void setId(String id) {
		this.id = id;
	}
	
	@Override
	public void read(IMultiplayerService service) {
		id = service.getNextId(getSenderId());
		
		write(service);
	}
	
	@Override
	public void write(IMultiplayerService service) {
		service.getPlayer(senderId).sendMessage(this);
	}
	
	@Override
	public void readExternal(IDataInput input) {
		super.readExternal(input);
		
		id = input.readUTF();
	}

	@Override
	public void writeExternal(IDataOutput output) {
		super.writeExternal(output);
		
		output.writeUTF(id);
	}
}
