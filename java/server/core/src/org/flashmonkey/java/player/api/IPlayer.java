package org.flashmonkey.java.player.api;

import java.util.List;

import org.flashmonkey.java.avatar.api.IAvatar;
import org.flashmonkey.java.message.api.IMessage;
import org.flashmonkey.java.message.api.IMessageQueue;
import org.red5.server.api.IConnection;

public interface IPlayer extends IMessageQueue {

	public String getId();
	
	public String getName();
	
	public void setName(String name);
	
	public void addAvatar(IAvatar avatar);
	
	public void removeAvatar(IAvatar avatar);
	
	public List<IAvatar> getAvatars();
	
	public IAvatar getScopeObject();	
	public void setScopeObject(IAvatar avatar);
	
	public void performScopeQuery(List<IAvatar> avatars);
	
	public IConnection getConnection();
	
	public void setConnection(IConnection connection);
	
	//public boolean sendMessage(IMessage message);
	
	public void createSyncMessage();
	
	public void destroy();
}
