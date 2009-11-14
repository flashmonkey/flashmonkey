package org.flashmonkey.java.adaptor.jmonkey;

import org.flashmonkey.java.adaptor.jmonkey.behaviour.AvatarBackwardBehaviour;
import org.flashmonkey.java.adaptor.jmonkey.behaviour.AvatarForwardBehaviour;
import org.flashmonkey.java.adaptor.jmonkey.behaviour.AvatarRotateLeftBehaviour;
import org.flashmonkey.java.adaptor.jmonkey.behaviour.AvatarRotateRightBehaviour;
import org.flashmonkey.java.adaptor.jmonkey.behaviour.AvatarStrafeLeft;
import org.flashmonkey.java.adaptor.jmonkey.behaviour.AvatarStrafeRight;
import org.flashmonkey.java.avatar.SimpleAvatar;
import org.flashmonkey.java.behaviour.CompositeBehaviour;
import org.flashmonkey.java.core.objects.BasicState;

import com.jme.bounding.BoundingBox;
import com.jme.math.Quaternion;
import com.jme.scene.Spatial;
import com.jme.scene.shape.Box;

public class JMAvatar extends SimpleAvatar {
	
	protected Spatial spatial;
	
	public JMAvatar() {
		init();
	}
	
	public void init() {
		initBehaviour();
		initSpatial();
	}
	
	public void initBehaviour() {
		CompositeBehaviour compBehaviour = new CompositeBehaviour();
		compBehaviour.addBehaviour(new AvatarForwardBehaviour(30));
		compBehaviour.addBehaviour(new AvatarBackwardBehaviour(30));
		compBehaviour.addBehaviour(new AvatarStrafeRight(30));
		compBehaviour.addBehaviour(new AvatarStrafeLeft(30));
		compBehaviour.addBehaviour(new AvatarRotateLeftBehaviour(5));
		compBehaviour.addBehaviour(new AvatarRotateRightBehaviour(5));
		
		behaviour = compBehaviour;
	}
	
	public void initSpatial() {
		spatial = new Box();
		spatial.setModelBound(new BoundingBox());
		spatial.updateModelBound();
	}
	
	//@Override
	/*public void updateUserInput(int time, IInput input) {
		super.updateUserInput(time, input);
		
		//System.out.println("position" + spatial.getLocalTranslation().x + " " + spatial.getLocalTranslation().y + " " + spatial.getLocalTranslation().z);
		//System.out.println("position" + state.getPosition().x + " " + state.getPosition().y + " " + state.getPosition().z);

		//System.out.println("forward: " + input.getMoveForward());
	}*/
	
	//@Override
	public void update() {
		super.update();

		spatial.setLocalTranslation(state.px, state.py, state.pz);
		spatial.setLocalRotation(new Quaternion(state.ox, state.oy, state.oz, state.ow));
		
		//System.out.println("position " + spatial.getLocalTranslation().x + " " + spatial.getLocalTranslation().y + " " + spatial.getLocalTranslation().z);
		//System.out.println("orientation " + spatial.getLocalRotation().x + " " + spatial.getLocalRotation().y + " " + spatial.getLocalRotation().z + " " + spatial.getLocalRotation().w);
	}

	//@Override
	public BasicState getState() {		
		return state;
	}

}
