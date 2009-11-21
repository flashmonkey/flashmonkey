package org.flashmonkey.java.message.api;

import java.util.List;

public interface IMessageQueue {
	
	public List<IMessage> getMessages();
	
	public void addMessage(IMessage message);
	
	public void clearMessages();
}
