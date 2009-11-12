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
	
	protected String name;
	
	protected IAvatar scopeObject;	
	
	protected IConnection connection;
	
	public AbstractPlayer(IConnection connection) {
		this.connection = connection;
	}
	
	public abstract void performScopeQuery(List<IAvatar> avatars);

	public abstract boolean sendMessage(IMessage message);
	
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

}
