package org.flashmonkey.java.adaptor.jmonkey;

import java.util.List;

import org.flashmonkey.java.avatar.api.IAvatar;
import org.flashmonkey.java.scene.api.IScene;

import com.jme.app.SimpleHeadlessApp;
import com.jme.scene.Spatial;

public class JMScene extends SimpleHeadlessApp implements IScene {

	public JMScene() {
		
	}
	
	public IAvatar addChild(IAvatar child) {
		rootNode.attachChild((Spatial) child);
		return null;
	}

	public List<IAvatar> getChildren() {
		return null;
	}

	public IAvatar removeChild(IAvatar child) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	protected void simpleInitGame() {
		// TODO Auto-generated method stub
		
	}

}
