package org.flashmonkey.java.state.api;

import org.red5.io.amf3.IExternalizable;

import com.jme.math.Quaternion;
import com.jme.math.Vector3f;

public interface IState extends IExternalizable {

	public Vector3f getPosition();	
	public void setPosition(Vector3f position);
	
	public Quaternion getOrientation();	
	public void setOrientation(Quaternion orientation);
}
