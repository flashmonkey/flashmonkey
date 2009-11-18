package org.flashmonkey.examples.mousegesturecontrolvideo.messages;

import org.flashmonkey.examples.mousegesturecontrolvideo.IGestureService;
import org.flashmonkey.java.connection.messages.AbstractMessage;

public class BaseGestureMessage extends AbstractMessage {
	
	protected IGestureService service;
	
	public BaseGestureMessage() {
		
	}
	
	public void write() {
		
	}
	
	public Object read() {
		return null;
	}
	
	public void setService(Object service) {
		System.out.println("Setting service " + (service instanceof IGestureService));
		if (service instanceof IGestureService) {
			this.service = (IGestureService)service;
		}
	}

}
