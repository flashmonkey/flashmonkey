package org.flashmonkey.java.message.api;

import org.flashmonkey.java.connection.red5.service.api.IMultiplayerService;
import org.red5.io.amf3.IExternalizable;

public interface IMessage extends IExternalizable {

	public void read(IMultiplayerService service);
	
	public void write(IMultiplayerService service);
	
	public String getSenderId();
	
	public void setSenderId(String id);
}
