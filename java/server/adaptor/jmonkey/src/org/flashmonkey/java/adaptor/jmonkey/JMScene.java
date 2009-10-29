package org.flashmonkey.java.adaptor.jmonkey;

import java.util.List;

import org.flashmonkey.java.avatar.api.IAvatar;
import org.flashmonkey.java.scene.api.IScene;

import com.jme.scene.Spatial;
import com.jmex.game.StandardGame;
import com.jmex.game.state.GameStateManager;

public class JMScene implements IScene {

	StandardGame game;
	
	BasicHeadlessGameState gameState;
	
	public JMScene(String gameName) {
		init(gameName);
	}
	
	public void init(String gameName) {
		game = new StandardGame(gameName, StandardGame.GameType.HEADLESS);
		game.start();
		
		gameState = new BasicHeadlessGameState("BasicState");
		
		GameStateManager.getInstance().attachChild(gameState);
	}
	
	public IAvatar addChild(IAvatar child) {
		gameState.getRootNode().attachChild((Spatial) child);
		return null;
	}

	public List<IAvatar> getChildren() {
		return null;
	}

	public IAvatar removeChild(IAvatar child) {
		// TODO Auto-generated method stub
		return null;
	}

	//@Override
	protected void simpleInitGame() {
		// TODO Auto-generated method stub
		
	}

}
