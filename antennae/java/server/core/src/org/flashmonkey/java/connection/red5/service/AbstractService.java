package org.flashmonkey.java.connection.red5.service;

import org.flashmonkey.java.connection.red5.service.api.IService;
import org.red5.server.adapter.MultiThreadedApplicationAdapter;
import org.red5.server.api.IClient;
import org.red5.server.api.IConnection;
import org.red5.server.api.IScope;

public abstract class AbstractService implements IService {

	protected MultiThreadedApplicationAdapter application;
	
	public MultiThreadedApplicationAdapter getApplication() {
		return application;
	}

	public void setApplication(MultiThreadedApplicationAdapter application) {
		this.application = application;
	}

	public boolean appConnect(IConnection arg0, Object[] arg1) {
		return false;
	}

	public void appDisconnect(IConnection arg0) {

	}

	public boolean appJoin(IClient arg0, IScope arg1) {
		return false;
	}

	public void appLeave(IClient arg0, IScope arg1) {

	}

	public boolean appStart(IScope arg0) {
		return false;
	}

	public void appStop(IScope arg0) {

	}

	public boolean roomConnect(IConnection arg0, Object[] arg1) {
		return false;
	}

	public void roomDisconnect(IConnection arg0) {

	}

	public boolean roomJoin(IClient arg0, IScope arg1) {
		return false;
	}

	public void roomLeave(IClient arg0, IScope arg1) {

	}

	public boolean roomStart(IScope arg0) {
		return false;
	}

	public void roomStop(IScope arg0) {

	}

}
