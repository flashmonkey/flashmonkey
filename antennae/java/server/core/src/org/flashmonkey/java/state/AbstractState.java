package org.flashmonkey.java.state;

import org.flashmonkey.java.state.api.IState;
import org.red5.io.amf3.IDataInput;
import org.red5.io.amf3.IDataOutput;

import com.jme.math.Quaternion;
import com.jme.math.Vector3f;

public abstract class AbstractState implements IState {

	public float px = 0.0f;

	public float py = 0.0f;

	public float pz = 0.0f;

	public float ow = 1.0f;

	public float ox = 0.0f;

	public float oy = 0.0f;

	public float oz = 0.0f;
	
	public abstract Quaternion getOrientation();

	public abstract Vector3f getPosition();

	public abstract void setOrientation(Quaternion orientation);

	public abstract void setPosition(Vector3f position);

	public void readExternal(IDataInput input) {
		px = input.readFloat();
		py = input.readFloat();
		pz = input.readFloat();
		ox = input.readFloat();
		oy = input.readFloat();
		oz = input.readFloat();
		ow = input.readFloat();
	}

	public void writeExternal(IDataOutput output) {
		output.writeFloat(px);
		output.writeFloat(py);
		output.writeFloat(pz);
		output.writeFloat(ox);
		output.writeFloat(oy);
		output.writeFloat(oz);
		output.writeFloat(ow);
	}

}
