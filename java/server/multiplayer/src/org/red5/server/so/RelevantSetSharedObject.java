package org.red5.server.so;

import java.util.Map;
import java.util.Set;
import java.util.concurrent.ConcurrentLinkedQueue;
import java.util.concurrent.CopyOnWriteArraySet;

import org.red5.server.api.event.IEventListener;
import org.red5.server.api.persistence.IPersistenceStore;
import org.red5.server.net.rtmp.Channel;
import org.red5.server.net.rtmp.RTMPConnection;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

/**
 * RelevantSetSharedObject overrides the usual shared object behaviour in which all listeners
 * registered are informed of all updates.
 * 
 * RSSO allows a set of listeners to be assigned prior to each update, only those listeners
 * will be informed of the updates that follow. In this way you can save bandwidth and client
 * processing by only handling updates that are relevant to a client.
 * 
 * @author Trevor
 *
 */
public class RelevantSetSharedObject extends SharedObject implements IRelevantSetSharedObject {

	/**
     * Logger
     */
	protected static Logger log = LoggerFactory.getLogger(RelevantSetSharedObject.class);
	
	/**
     * Current Listeners. These are the listeners that will be informed the next time
     * an update is made to this shared object. 
     * 
     * TODO: Check if these listeners need to be sent Client.INITIAL_DATA etc. events 
     * before they can receive updates from the SO.
     */
    protected Set<IEventListener> currentListeners = new CopyOnWriteArraySet<IEventListener>();
	
	public RelevantSetSharedObject(Map<String, Object> data, String name, String path,
			boolean persistent, IPersistenceStore storage) {
		super(data, name, path, persistent, storage);
	}
	
	protected void sendUpdates() {
    	//get the current version
    	int currentVersion = version.get();
    	//
    	boolean persist = isPersistentObject();
    	//get read-only version of events
    	ConcurrentLinkedQueue<ISharedObjectEvent> events = new ConcurrentLinkedQueue<ISharedObjectEvent>(ownerMessage.getEvents());   	
    	//clear out previous events
    	ownerMessage.getEvents().clear();
    	//
		if (!events.isEmpty()) {
			// Send update to "owner" of this update request
			SharedObjectMessage syncOwner = new SharedObjectMessage(null, name,	currentVersion, persist);
			syncOwner.addEvents(events);
			if (source != null) {
				// Only send updates when issued through RTMP request
				Channel channel = ((RTMPConnection) source).getChannel((byte) 3);
				if (channel != null) {
					//ownerMessage.acquire();
					channel.write(syncOwner);
					log.debug("Owner: {}", channel);
				} else {
					log.warn("No channel found for owner changes!?");
				}
			}
		}
		//clear owner events
		events.clear();		
		//get read-only version of sync events
		events.addAll(syncEvents);   	
    	//clear out previous events
		syncEvents.clear();
		if (!events.isEmpty()) {
			// Synchronize updates with the current listeners of this shared
			for (IEventListener listener : currentListeners) {
				if (listener == source) {
					// Don't re-send update to active client
					log.debug("Skipped {}", source);
					continue;
				}
				if (!(listener instanceof RTMPConnection)) {
					log.warn("Can't send sync message to unknown connection {}", listener);
					continue;
				}
				// Create a new sync message for every client to avoid
				// concurrent access through multiple threads
				// TODO: perhaps we could cache the generated message
				SharedObjectMessage syncMessage = new SharedObjectMessage(null,	name, currentVersion, persist);
				syncMessage.addEvents(events);

				Channel channel = ((RTMPConnection) listener).getChannel((byte) 3);
				log.debug("Send to {}", channel);
				channel.write(syncMessage);
			}

		}
	}
	
	public void setCurrentListeners(Set<IEventListener> currentListeners) {
		this.currentListeners = currentListeners;
	}
}
