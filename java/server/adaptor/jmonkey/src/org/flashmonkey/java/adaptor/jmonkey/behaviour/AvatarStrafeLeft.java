package org.flashmonkey.java.adaptor.jmonkey.behaviour;

import org.flashmonkey.java.core.objects.BasicState;
import org.flashmonkey.java.input.api.IInput;

import com.jme.math.Quaternion;
import com.jme.math.Vector3f;

public class AvatarStrafeLeft extends AbstractAvatarBehaviour {

	//temporary vector for translation
    private static final Vector3f tempVa = new Vector3f();
    
	public AvatarStrafeLeft() {
		super();
	}
	
	public AvatarStrafeLeft(float speed) {
		super(speed);
	}
	
	//@Override
	public void update(int time, IInput input, BasicState state) {
		if (input.getMoveLeft()) {
			Vector3f loc = new Vector3f(state.px, state.py, state.pz);
			Quaternion orientation = new Quaternion(state.ox, state.oy, state.oz, state.ow);
	        loc.addLocal(orientation.getRotationColumn(0, tempVa)
	                .multLocal(-speed));
	        state.px = loc.x;
	        state.py = loc.y;
	        state.pz = loc.z;
		}
	}
}
