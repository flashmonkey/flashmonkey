package org.flashmonkey.java.connection.red5.service;

import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;
import java.util.concurrent.ConcurrentMap;

import org.flashmonkey.java.avatar.api.IAvatar;
import org.flashmonkey.java.connection.red5.service.api.IMultiplayerService;
import org.flashmonkey.java.message.api.IMessage;
import org.flashmonkey.java.player.api.IPlayer;
import org.red5.server.adapter.MultiThreadedApplicationAdapter;
import org.red5.server.api.IClient;
import org.red5.server.api.IConnection;
import org.red5.server.api.IScope;
import org.red5.server.api.ScopeUtils;
import org.red5.server.api.so.ISharedObject;
import org.red5.server.api.so.ISharedObjectService;

public abstract class AbstractMultiplayerService extends AbstractService implements IMultiplayerService {

	protected MultiThreadedApplicationAdapter application;
	
	/**
	 * A Map of IPlayer objects currently using this service keyed
	 * by the Player's connection id.
	 */
	protected final ConcurrentMap<String, IPlayer> players = new ConcurrentHashMap<String, IPlayer>();
	
	protected final ConcurrentMap<String, IAvatar> avatars = new ConcurrentHashMap<String, IAvatar>();

	protected Map<String, Integer> idMap = new ConcurrentHashMap<String, Integer>();
	
	public AbstractMultiplayerService() {
		
	}
	
	public void init() {
		
	}

	@Override
	public void setApplication(MultiThreadedApplicationAdapter application) {
		this.application = application;
		this.application.addListener(this);
	}

	@Override
	public boolean appConnect(IConnection connection, Object[] args) {
		System.out.println("user " + args[0].toString() + " with password " + args[1].toString() + " joining");
		return true;
	}

	@Override
	public void appDisconnect(IConnection connection) {

	}

	@Override
	public boolean appJoin(IClient client, IScope scope) {
		return true;
	}

	@Override
	public void appLeave(IClient client, IScope scope) {

	}

	@Override
	public boolean appStart(IScope scope) {
		return true;
	}

	@Override
	public void appStop(IScope scope) {

	}

	@Override
	public boolean roomConnect(IConnection connection, Object[] args) {
		return true;
	}

	@Override
	public void roomDisconnect(IConnection connection) {

	}

	@Override
	public boolean roomJoin(IClient client, IScope scope) {
		return true;
	}

	@Override
	public void roomLeave(IClient client, IScope scope) {

	}

	@Override
	public boolean roomStart(IScope scope) {
		return true;
	}

	@Override
	public void roomStop(IScope scope) {

	}

	public void receiveMessage(IMessage message) {
		message.read(this);
	}
	 
	public void sendMessage(IMessage message) {
		
	}
	
	public Map<String, IPlayer> getPlayers() {
		return players;
	}
	
	public ISharedObject getSharedObject(String name, boolean persistent) {

        ISharedObjectService service = (ISharedObjectService) ScopeUtils
                .getScopeService(application.getScope(),
                        ISharedObjectService.class, false);
        return service
                .getSharedObject(application.getScope(), name, persistent);
    }
	
	public String getNextId(String id) {
		int currentId = idMap.get(id);
		idMap.put(id, currentId + 1);
		
		return id + "_" + currentId;
	}
	
	public void registerAvatar(IAvatar avatar) {
		
	}

}
