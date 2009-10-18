package org.flashmonkey.java.rm;

public class BaseMessageService implements IMessageService {

	public void receiveMessage(IMessage message) {
		message.read(this);
	}

	public void sendMessage(IMessage message) {
		// TODO Auto-generated method stub

	}

}
