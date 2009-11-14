package org.flashmonkey.java.core.objects;

import org.red5.annotations.DontSerialize;
import org.red5.io.amf3.IDataInput;
import org.red5.io.amf3.IDataOutput;
import org.red5.io.amf3.IExternalizable;

import com.jme.math.Quaternion;
import com.jme.math.Vector3f;

public class BasicState implements IExternalizable {
	
	public float px = 0.0f;

	public float py = 0.0f;

	public float pz = 0.0f;
	
	/*@DontSerialize
	private boolean positionDirty = true;
	
	@DontSerialize
	protected Vector3f position = new Vector3f(-1, -1, -1);
	
	public Vector3f getPosition() {
		if (positionDirty) {
			position = new Vector3f(px, py, pz);
			positionDirty = false;
		}
		
		return position;
	}
	
	public void setPosition(Vector3f position) {
		positionDirty = true;
		px = position.x;
		py = position.y;
		pz = position.z;
	}*/

	public float ow = 1.0f;

	public float ox = 0.0f;

	public float oy = 0.0f;

	public float oz = 0.0f;
	
	/*@DontSerialize
	private boolean orientationDirty = true;
	
	@DontSerialize
	protected Quaternion orientation = new Quaternion();
	
	public Quaternion getOrientation() {
		if (orientationDirty) {
			orientation = new Quaternion(ox, oy, oz, ow);
			orientationDirty = false;
		}
		
		return orientation;
	}
	
	public void setOrientation(Quaternion orientation) {
		ox = orientation.x;
		oy = orientation.y;
		oz = orientation.z;
		ow = orientation.w;
	}*/
	
	public BasicState() {
	}

	public void readExternal(IDataInput input) {
		px = input.readFloat();
		py = input.readFloat();
		pz = input.readFloat();
		ox = input.readFloat();
		oy = input.readFloat();
		oz = input.readFloat();
		ow = input.readFloat();
		//position = new Vector3f(input.readFloat(), input.readFloat(), input.readFloat());
		//orientation = new Quaternion(input.readFloat(), input.readFloat(), input.readFloat(), input.readFloat());
	}

	public void writeExternal(IDataOutput output) {
		System.out.println("writing state " + px + " " + py + " " + pz);
		output.writeFloat(px);
		output.writeFloat(py);
		output.writeFloat(pz);
		output.writeFloat(ox);
		output.writeFloat(oy);
		output.writeFloat(oz);
		output.writeFloat(ow);
		/*System.out.println("writing external " + position);
		output.writeFloat(position.x);
		output.writeFloat(position.y);
		output.writeFloat(position.z);
		output.writeFloat(orientation.x);
		output.writeFloat(orientation.y);
		output.writeFloat(orientation.z);
		output.writeFloat(orientation.w);*/
	}
}
