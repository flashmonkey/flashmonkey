package org.flashmonkey.java.player;

import java.util.List;

import org.flashmonkey.java.avatar.api.IAvatar;
import org.flashmonkey.java.message.api.IMessage;
import org.red5.server.api.IConnection;
import org.red5.server.api.service.ServiceUtils;

public class SimplePlayer extends AbstractPlayer {

	public SimplePlayer(IConnection connection, String name) {
		super(connection);
		this.name = name;
	}
	
	//@Override
	public void performScopeQuery(List<IAvatar> avatars) {
		// TODO Auto-generated method stub

	}

	//@Override
	public boolean sendMessage(IMessage message) {
		return ServiceUtils.invokeOnConnection(connection, "receiveMessage", new Object[]{message});
	}

	//@Override
	public String getId() {
		System.out.println("connection " + connection);
		return connection.getClient().getId();
	}

}
