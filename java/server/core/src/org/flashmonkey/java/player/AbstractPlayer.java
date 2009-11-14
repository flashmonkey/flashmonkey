package org.flashmonkey.java.player;

import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

import org.flashmonkey.java.avatar.api.IAvatar;
import org.flashmonkey.java.message.api.IMessage;
import org.flashmonkey.java.player.api.IPlayer;
import org.red5.server.api.IConnection;

public abstract class AbstractPlayer implements IPlayer {

	protected List<IAvatar> avatars = Collections.synchronizedList(new ArrayList<IAvatar>());
	
	protected List<IMessage> messages = Collections.synchronizedList(new ArrayList<IMessage>());
	
	protected String name;
	
	protected IAvatar scopeObject;	
	
	protected IConnection connection;
	
	public AbstractPlayer(IConnection connection) {
		this.connection = connection;
	}
	
	public abstract void performScopeQuery(List<IAvatar> avatars);
	
	public void addAvatar(IAvatar avatar) {
		avatars.add(avatar);
	}
	
	public void removeAvatar(IAvatar avatar) {
		avatars.remove(avatar);
	}

	public String getName() {
		return name;
	}
	
	public void setName(String name) {
		this.name = name;
	}
	
	public IAvatar getScopeObject() {
		return scopeObject;
	}

	public void setScopeObject(IAvatar scopeObject) {
		if (!avatars.contains(scopeObject)) {
			avatars.add(scopeObject);
		}
		this.scopeObject = scopeObject;
	}
	
	public IConnection getConnection() {
		return connection;
	}
	
	public void setConnection(IConnection connection) {
		this.connection = connection;
	}
	
	public List<IAvatar> getAvatars() {
		return avatars;
	}
	
	public abstract String getId();
	
	public abstract void createSyncMessage();
	
	////////////////////////////////////////
	// IMessageQueue Implementation
	////////////////////////////////////////
	
	public void addMessage(IMessage message) {
		messages.add(message);
	}
	
	public List<IMessage> getMessages() {
		List<IMessage> copy = new ArrayList<IMessage>();
		copy.addAll(messages);
		return copy;
	}
	
	public void clearMessages() {
		messages.clear();
	}
	
	public void destroy() {
		avatars.clear();
		messages.clear();
	}

}
