package org.flashmonkey.java.api.message;

import org.flashmonkey.java.core.objects.BasicState;
import org.flashmonkey.java.input.api.IInput;
import org.flashmonkey.java.message.api.IMessage;

public interface ISynchroniseCreateMessage extends IMessage {

	public String getPlayerId();	
	public void setPlayerId(String playerId);
	
	public String getObjectId();
	public void setObjectId(String objectId);
	
	public IInput getInput();
	public void setInput(IInput input);
	
	public BasicState getState();
	public void setState(BasicState state);
}
