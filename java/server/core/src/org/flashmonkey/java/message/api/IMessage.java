package org.flashmonkey.java.message.api;

import org.red5.io.amf3.IExternalizable;

public interface IMessage extends IExternalizable {

	public Object read();
	
	public void write();
	
	public void setService(Object service);
	
	public String getSenderId();
	
	public void setSenderId(String id);
}
