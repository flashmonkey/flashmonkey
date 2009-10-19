package org.red5.core;

/*
 * RED5 Open Source Flash Server - http://www.osflash.org/red5
 * 
 * Copyright (c) 2006-2008 by respective authors (see below). All rights reserved.
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

import org.red5.server.adapter.ApplicationAdapter;
import org.red5.server.api.IConnection;
import org.red5.server.api.IScope;
import org.red5.server.api.Red5;
import org.red5.server.api.stream.IBroadcastStream;

import com.jme.bounding.BoundingSphere;
import com.jme.input.MouseInput;
import com.jme.math.Vector3f;
import com.jme.scene.shape.Box;
import com.jmex.game.StandardGame;
import com.jmex.game.state.DebugGameState;
import com.jmex.game.state.GameStateManager;
import com.xuggle.red5.demo.VideoTranscoderDemo;

/**
 * Sample application that uses the client manager.
 * 
 * @author The Red5 Project (red5@osflash.org)
 */
public class Application extends ApplicationAdapter {

	HelloWorld game;
	
	private VideoTranscoderDemo resamplerDemo = new VideoTranscoderDemo("xuggle_");
	
	public Application() {
		new Thread() {
			public void run() { createGame(); }
		}.start();
	}
	
	private void createGame() {
		game = new HelloWorld();
		
		game.start();
		
		// Create a DebugGameState - has all the built-in features that SimpleGame provides
		// NOTE: for a distributable game implementation you'll want to use something like
		// BasicGameState instead and provide control features yourself.
		DebugGameState state = new DebugGameState();
		// Put our box in it
		Box box = new Box("my box", new Vector3f(0, 0, 0), 2, 2, 2);
		box.setModelBound(new BoundingSphere());
		box.updateModelBound();
		// We had to add the following line because the render thread is already running
		// Anytime we add content we need to updateRenderState or we get funky effects
		box.updateRenderState();
		state.getRootNode().attachChild(box);
		state.getRootNode().updateRenderState();
		// Add it to the manager
		GameStateManager.getInstance().attachChild(state);
		// Activate the game state
		state.setActive(true);
	}
	
	/** {@inheritDoc} */
    @Override
	public boolean connect(IConnection conn, IScope scope, Object[] params) {
		return true;
	}

	/** {@inheritDoc} */
    @Override
	public void disconnect(IConnection conn, IScope scope) {
		super.disconnect(conn, scope);
	}
    
    /**
	   * Called on publish: NetStream.publish("streamname", "live")
	   */
	  @Override
	  public void streamPublishStart(IBroadcastStream stream) {
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

}
