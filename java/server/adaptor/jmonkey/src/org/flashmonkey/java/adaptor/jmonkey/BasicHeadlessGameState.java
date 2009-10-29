package org.flashmonkey.java.adaptor.jmonkey;

import com.jme.scene.Node;
import com.jmex.game.state.GameState;

public class BasicHeadlessGameState extends GameState {

	/** The root of this GameStates scenegraph. */
	protected Node rootNode;
	
	/**
	 * Creates a new BasicHeadlessGameState with a given name.
	 * 
	 * @param name The name of this GameState.
	 */
	public BasicHeadlessGameState(String name) {
		this.name = name;
		rootNode = new Node(name + ": RootNode");
	}
	
	@Override
	public void cleanup() {
		// TODO Auto-generated method stub

	}

	@Override
	public void render(float arg0) {
		// TODO Auto-generated method stub

	}

	@Override
	public void update(float tpf) {
		rootNode.updateGeometricState(tpf, true);
	}
	
	public Node getRootNode() {
		return rootNode;
	}
}
