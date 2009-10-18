package org.flashmonkey.java.service;

import org.flashmonkey.java.api.message.IServerSyncMessage;
import org.flashmonkey.java.avatar.api.IAvatar;
import org.flashmonkey.java.avatar.factory.SimpleAvatarFactory;
import org.flashmonkey.java.avatar.factory.api.IAvatarFactory;
import org.flashmonkey.java.connection.red5.service.BasePaperworldService;
import org.flashmonkey.java.multiplayer.messages.ServerSyncMessage;
import org.flashmonkey.java.player.SimplePlayer;
import org.flashmonkey.java.player.api.IPlayer;
import org.red5.server.api.IConnection;
import org.red5.server.api.scheduling.IScheduledJob;
import org.red5.server.api.scheduling.ISchedulingService;
import org.red5.server.api.so.ISharedObject;

public class SimpleService extends BasePaperworldService {

	protected IAvatarFactory factory = new SimpleAvatarFactory();
	
	public SimpleService() {

	}

	public void init() {
		super.init();

		application.addScheduledJob(200, new UpdateConnectionsJob());
		application.addScheduledJob(100, new UpdateAvatarsJob());
	}

	@Override
	public boolean appConnect(IConnection connection, Object[] args) {
		String uid = connection.getClient().getId();
		String username = args[0].toString();

		IPlayer player = createPlayer(connection, username);

		players.put(uid, player);
		idMap.put(uid, 0);
		
		return true;
	}

	protected IPlayer createPlayer(IConnection connection, String username) {
		return new SimplePlayer(connection, username);
	}

	public IPlayer getPlayer(String id) {
		return players.get(id);
	}
	
	public void registerAvatar(IAvatar avatar) {
		avatars.put(avatar.getId(), avatar);
	}

	public IAvatar getAvatar(String objectId) {
		return avatars.get(objectId);
	}

	private class UpdateConnectionsJob implements IScheduledJob {

		public void execute(ISchedulingService service)
				throws CloneNotSupportedException {

			ISharedObject so = getSharedObject("avatars", false);

			so.beginUpdate();

			for (String key : avatars.keySet()) {
				IAvatar avatar = avatars.get(key);
				try {
					IPlayer player = avatar.getOwner();
					String id = player.getId();

					IServerSyncMessage syncMessage = new ServerSyncMessage(id,
							avatar.getId(), avatar.getTime(), avatar.getInput(), avatar
									.getState());

					so.setAttribute(id, syncMessage);
				} catch (Exception e) {

				}
			}

			so.endUpdate();
		}

	}
	
	private class UpdateAvatarsJob implements IScheduledJob {

		public void execute(ISchedulingService service) throws CloneNotSupportedException {
			for (String key : avatars.keySet()) {
				avatars.get(key).update();
			}
		}		
	}

	/*@Override
	public IAvatarFactory getFactory() {
		return factory;
	}*/

	public void setAvatarFactory(IAvatarFactory factory) {
		this.factory = factory;
	}
}
