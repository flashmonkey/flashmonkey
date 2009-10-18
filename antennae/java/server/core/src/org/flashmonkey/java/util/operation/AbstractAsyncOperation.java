package org.flashmonkey.java.util.operation;

import net.schst.EventDispatcher.Event;
import net.schst.EventDispatcher.EventDispatcher;

public abstract class AbstractAsyncOperation extends EventDispatcher implements
		IAsyncOperation {

	public abstract void execute();
	
	public void result() {
		try {
			triggerEvent(new Event(Event.COMPLETE, this));
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	public void error() {
		try {
			triggerEvent(new Event(Event.ERROR, this));
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	public void addResultListener(Object listener, String method) {
		try {
			addListener(Event.COMPLETE, listener, method);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	public void addErrorListener(Object listener, String method) {
		try {
			addListener(Event.ERROR, listener, method);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

}
