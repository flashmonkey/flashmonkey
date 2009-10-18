package org.flashmonkey.java.rm;

import org.red5.io.amf3.IExternalizable;

public interface IMessage extends IExternalizable {

	public void read(IMessageService service);
	
	public void write(IMessageService service);
}
