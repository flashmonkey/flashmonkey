package org.flashmonkey.java.avatar;

import org.flashmonkey.java.avatar.api.IAvatar;
import org.flashmonkey.java.behaviour.api.IBehaviour;
import org.flashmonkey.java.core.objects.BasicState;
import org.flashmonkey.java.input.api.IInput;
import org.flashmonkey.java.player.api.IPlayer;
import org.red5.server.api.IConnection;

public abstract class AbstractAvatar implements IAvatar {
	
	protected int time = 0;
	
	protected String id;
	
	protected IInput input;
	
	protected BasicState state;
	
	protected IBehaviour behaviour;
	
	protected IConnection connection;
	
	protected IPlayer owner;
	
	public AbstractAvatar() {
		
	}
	
	public void setBehaviour(IBehaviour behaviour) {
		this.behaviour = behaviour;
	}

	public IConnection getConnection() {
		return connection;
	}

	public void setConnection(IConnection connection) {
		this.connection = connection;
	}
	
	public BasicState getState() {
		return state;
	}

	public IPlayer getOwner() {
		return owner;
	}

	public void setOwner(IPlayer owner) {
		this.owner = owner;		
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public IInput getInput() {
		return input;
	}

	public void setInput(IInput input) {
		this.input = input;
	}
	
	public int getTime() {
		return time;
	}

	public abstract void update();

	public abstract void updateUserInput(int time, IInput input);

}
