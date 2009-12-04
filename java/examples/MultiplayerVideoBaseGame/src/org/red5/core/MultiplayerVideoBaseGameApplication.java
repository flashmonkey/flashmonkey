package org.red5.core;

/*
 * RED5 Open Source Flash Server - http://www.osflash.org/red5
 * 
 * Copyright (c) 2006-2007 by respective authors (see below). All rights reserved.
 * 
 * This library is free software; you can redistribute it and/or modify it under the 
 * terms of the GNU Lesser General Public License as published by the Free Software 
 * Foundation; either version 2.1 of the License, or (at your option) any later 
 * version. 
 * 
 * This library is distributed in the hope that it will be useful, but WITHOUT ANY 
 * WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A 
 * PARTICULAR PURPOSE. See the GNU Lesser General Public License for more details.
 * 
 * You should have received a copy of the GNU Lesser General Public License along 
 * with this library; if not, write to the Free Software Foundation, Inc., 
 * 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA 
 */

import org.flashmonkey.java.message.api.IMessage;
import org.red5.server.adapter.ApplicationAdapter;
import org.red5.server.api.IConnection;
import org.red5.server.api.IScope;
import org.red5.server.api.Red5;
import org.red5.server.api.service.ServiceUtils;
import org.red5.server.api.stream.IBroadcastStream;
import org.red5.server.api.stream.IStreamAwareScopeHandler;

/**
 * Red5Server Framework.
 * 
 * @author The Red5 Project (red5@osflash.org)
 * @author Dominick Accattato
 * @author Joachim Bauch (jojo@struktur.de)
 */
public class MultiplayerVideoBaseGameApplication extends ApplicationAdapter implements IStreamAwareScopeHandler {
	
	private VideoTranscoder resamplerDemo = new VideoTranscoder("xuggle_");
	
	private VideoGame game = new VideoGame();
	
	private MultiplayerVideoInputHandler inputHandler;
	
	public MultiplayerVideoBaseGameApplication() {
		System.out.println("MultiplayerVideoBaseGameApplication 2");
				
		new Thread() {
			public void run() { createGame(); }
		}.start();
		//game.start();
		//createGame();
	}
	
	private void createGame() {
		game = new VideoGame();
		resamplerDemo.setGame(game);
		game.start();
	}
	
	public Object receiveMessage(IMessage message) {
		message.setService(this);
		message.read();
		return null;
	}
	
	/** {@inheritDoc} */
    @Override
	public boolean connect(IConnection conn, IScope scope, Object[] params) {
		// Check if the user passed valid parameters.
		/*if (params == null || params.length == 0) {
			// NOTE: "rejectClient" terminates the execution of the current method!
			rejectClient("No username passed.");
		}*/

		// Call original method of parent class.
		/*if (!super.connect(conn, scope, params)) {
			return false;
		}*/

    	super.connect(conn, scope, params);

		String uid = conn.getClient().getId();
		
		// Notify client about unique id.
		ServiceUtils.invokeOnConnection(conn, "setClientID", new Object[] { uid });
		
		return true;
	}

	/** {@inheritDoc} */
    @Override
	public void disconnect(IConnection conn, IScope scope) {
		
		// Call original method of parent class.
		super.disconnect(conn, scope);
	}
    
    public Object echo(IMessage o) {
    	return o;
    }
    
	  /**
	   * Called on publish: NetStream.publish("streamname", "live")
	   */
	  @Override
	  public void streamPublishStart(IBroadcastStream stream) {
		  System.out.println("Starting to publish stream " + stream.getName());
	    super.streamPublishStart(stream);
	    
	    resamplerDemo.startTranscodingStream(stream,
	        Red5.getConnectionLocal().getScope());
	  }
	  
	  @Override
	  public void streamBroadcastClose(IBroadcastStream stream) {
	    //log.debug("streamBroadcastClose: {}; {}", stream, stream.getPublishedName());
	    
	    resamplerDemo.stopTranscodingStream(stream,
	        Red5.getConnectionLocal().getScope());
	    super.streamBroadcastClose(stream);
	  }
	  
	  public MultiplayerVideoInputHandler getInputHandler() {
		  return inputHandler;
	  }
	
}
