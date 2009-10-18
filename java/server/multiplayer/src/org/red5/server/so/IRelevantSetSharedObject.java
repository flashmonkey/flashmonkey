package org.red5.server.so;

import java.util.Set;

import org.red5.server.api.event.IEventListener;

public interface IRelevantSetSharedObject {

	public void setCurrentListeners(Set<IEventListener> currentListeners);
}
