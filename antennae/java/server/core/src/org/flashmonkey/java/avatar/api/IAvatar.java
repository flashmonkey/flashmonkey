package org.flashmonkey.java.avatar.api;

import org.flashmonkey.java.behaviour.api.IBehaviour;
import org.flashmonkey.java.core.objects.BasicState;
import org.flashmonkey.java.input.api.IInput;
import org.flashmonkey.java.player.api.IPlayer;
import org.red5.server.api.IConnection;

public interface IAvatar {

	public void setBehaviour(IBehaviour behaviour);

	public void updateUserInput(int time, IInput input);

	public void setConnection(IConnection connection);

	public IConnection getConnection();

	public BasicState getState();

	public int getTime();

	public void update();

	public IInput getInput();

	public void setInput(IInput input);

	public String getId();

	public void setId(String id);

	public IPlayer getOwner();

	public void setOwner(IPlayer owner);
}
