package org.flashmonkey.java.connection.messages;

import java.util.ArrayList;
import java.util.List;

import org.flashmonkey.java.message.api.IMessage;
import org.red5.io.amf3.IDataInput;
import org.red5.io.amf3.IDataOutput;

public class BatchMessage extends BaseMessage {

	private List<IMessage> messages = new ArrayList<IMessage>();
	
	public BatchMessage() {
		
	}
	
	public BatchMessage(List<IMessage> messages) {
		this.messages = messages;
	}
	
	public void addMessage(IMessage message) {
		messages.add(message);
	}
	
	public List<IMessage> getMessages() {
		return messages;
	}
	
	@Override
	public Object read() {
		for (IMessage message : messages) {
			message.read();
		}

		return null;
	}
	
	@Override 
	public void write() {
		service.getPlayer(senderId).addMessage(this);
	}
	
	@Override 
	public void setService(Object service) {
		super.setService(service);
		
		for (IMessage message : messages) {
			message.setService(service);
		}
	}
	
	@Override
	public void readExternal(IDataInput input) {
		super.readExternal(input);
		
		int numberOfMessages = input.readInt();
		
		for (int i = 0; i < numberOfMessages; i++) {
			IMessage message = (IMessage)input.readObject();
			if (!messages.equals(null)) {
				messages.add(message);
			}
		}
	}
	
	@Override
	public void writeExternal(IDataOutput output) {
		super.writeExternal(output);

		output.writeInt(messages.size());

		for (IMessage message : messages) {
			output.writeObject(message);
		}
	}
}
