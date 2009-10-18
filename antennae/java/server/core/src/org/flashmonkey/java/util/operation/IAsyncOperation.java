package org.flashmonkey.java.util.operation;

import net.schst.EventDispatcher.IEventDispatcher;

public interface IAsyncOperation extends IEventDispatcher {

	public void execute();
	
	public void result();
	
	public void error();
}
