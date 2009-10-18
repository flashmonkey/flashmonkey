package org.flashmonkey.java.util.operation;

import org.flashmonkey.java.message.api.IMessage;
import org.red5.server.api.IConnection;
import org.red5.server.api.service.ServiceUtils;

public class SendMessageOperation extends AbstractAsyncOperation {

	private IConnection connection;
	
	private IMessage message;
	
	public SendMessageOperation(IConnection connection, IMessage message) {
		this.connection = connection;
		this.message = message;
	}
	
	@Override
	public void execute() {
		ServiceUtils.invokeOnConnection(connection, "receiveMessag", new Object[]{message});
	}

}
