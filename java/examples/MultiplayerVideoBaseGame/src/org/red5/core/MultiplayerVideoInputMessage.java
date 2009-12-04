package org.red5.core;

import org.flashmonkey.java.connection.messages.AbstractMessage;
import org.flashmonkey.java.input.api.IInput;
import org.red5.io.amf3.IDataInput;
import org.red5.io.amf3.IDataOutput;

public class MultiplayerVideoInputMessage extends AbstractMessage {

	protected MultiplayerVideoBaseGameApplication service;
	
	private IInput input;
	
	public MultiplayerVideoInputMessage() {
		
	}
	
	@Override
	public Object read() {
		service.getInputHandler().setInput(input);
		return null;
	}

	@Override
	public void setService(Object service) {
		if (service instanceof MultiplayerVideoBaseGameApplication) {
			this.service = (MultiplayerVideoBaseGameApplication)service;
		}
	}
	
	public void writeExternal(IDataOutput output) {
		super.writeExternal(output);
		
		output.writeObject(input);
	}
	
	public void readExternal(IDataInput input) {
		super.readExternal(input);
		
		this.input = (IInput)input.readObject();
	}
}
