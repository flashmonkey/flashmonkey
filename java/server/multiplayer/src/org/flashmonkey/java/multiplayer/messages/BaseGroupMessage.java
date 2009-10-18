package org.flashmonkey.java.multiplayer.messages;

import org.flashmonkey.java.message.BaseMessage;
import org.flashmonkey.java.message.api.IGroupMessage;

public abstract class BaseGroupMessage extends BaseMessage implements
		IGroupMessage {

	private String groupId;
	
	public BaseGroupMessage() {
		super(null);
	}
	
	public BaseGroupMessage(String senderId, String groupId) {
		super(senderId);
		
		this.groupId = groupId;
	}
	
	public String getGroupId() {
		return groupId;
	}

	public void setGroupId(String groupId) {
		this.groupId = groupId;
	}
}
