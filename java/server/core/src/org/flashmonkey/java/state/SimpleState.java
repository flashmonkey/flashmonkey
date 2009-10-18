package org.flashmonkey.java.state;

import com.jme.math.Quaternion;
import com.jme.math.Vector3f;

public class SimpleState extends AbstractState {
	
	public SimpleState() {
	}

	@Override
	public Quaternion getOrientation() {
		return new Quaternion(ox, oy, oz, ow);
	}

	@Override
	public Vector3f getPosition() {
		return new Vector3f(px, py, pz);
	}

	@Override
	public void setOrientation(Quaternion orientation) {
		ox = orientation.x;
		oy = orientation.y;
		oz = orientation.z;
		ow = orientation.w;
	}

	@Override
	public void setPosition(Vector3f position) {
		px = position.x;
		py = position.y;
		pz = position.z;
	}
}
