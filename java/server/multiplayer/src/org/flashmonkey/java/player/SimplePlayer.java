package org.flashmonkey.java.player;

import java.util.List;

import org.flashmonkey.java.api.message.IServerSyncMessage;
import org.flashmonkey.java.avatar.api.IAvatar;
import org.flashmonkey.java.multiplayer.messages.ServerSyncMessage;
import org.red5.server.api.IConnection;

import com.jme.math.Vector3f;

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
	/*public boolean sendMessage(IMessage message) {
		return ServiceUtils.invokeOnConnection(connection, "receiveMessage", new Object[]{message});
	}*/

	//@Override
	public String getId() {
		return connection.getClient().getId();
	}
	
	public void createSyncMessage() {
		IAvatar avatar = getScopeObject();
		
		//Vector3f position = avatar.getState().getPosition();
		//System.out.println("state " + position);
		IServerSyncMessage syncMessage = new ServerSyncMessage(getId(),
				avatar.getId(), avatar.getTime(), avatar.getInput(), avatar
						.getState());
		
		messages.add(syncMessage);
	}

}
