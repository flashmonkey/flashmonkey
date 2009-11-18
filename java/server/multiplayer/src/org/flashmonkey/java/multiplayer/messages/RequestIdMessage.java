package org.flashmonkey.java.multiplayer.messages;

import org.flashmonkey.java.connection.messages.BaseMessage;
import org.flashmonkey.java.connection.red5.service.api.IMultiplayerService;


public class RequestIdMessage extends BaseMessage {
	
	public RequestIdMessage() {
		
	}
	
	public RequestIdMessage(String senderId) {
		super(senderId);
	}
	
	@Override
	public Object read() {
		return service.getNextId(getSenderId());
	}
}
