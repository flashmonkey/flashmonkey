package org.flashmonkey.java.adaptor.jmonkey.behaviour;

import org.flashmonkey.java.core.objects.BasicState;
import org.flashmonkey.java.input.api.IInput;
import org.flashmonkey.java.state.api.IState;

import com.jme.input.action.InputActionEvent;
import com.jme.math.Matrix3f;
import com.jme.math.Quaternion;
import com.jme.math.Vector3f;

public class AvatarRotateRightBehaviour extends AbstractAvatarBehaviour {

	//temporary variables to handle rotation
    private static final Matrix3f incr = new Matrix3f();

    private static final Matrix3f tempMa = new Matrix3f();

    private static final Matrix3f tempMb = new Matrix3f();

    private static final Vector3f tempVa = new Vector3f();

    //an optional axis to lock, preventing rolling on this axis.
    private Vector3f lockAxis;
    
    public AvatarRotateRightBehaviour() {
    	super();
    }
    
    public AvatarRotateRightBehaviour(float speed) {
    	super(speed);
    }
    
    /**
     * 
     * <code>setLockAxis</code> allows a certain axis to be locked, meaning
     * the camera will always be within the plane of the locked axis. For
     * example, if the node is a first person camera, the user might lock the
     * node's up vector. This will keep the node vertical with the ground.
     * 
     * @param lockAxis
     *            the axis to lock - should be unit length (normalized).
     */
    public void setLockAxis(Vector3f lockAxis) {
        this.lockAxis = lockAxis;
    }

    /**
     * <code>performAction</code> rotates the camera about it's up vector or
     * lock axis at a speed of movement speed * time. Where time is the time
     * between frames and 1 corresponds to 1 second.
     * 
     * @see com.jme.input.action.KeyInputAction#performAction(InputActionEvent)
     */
    public void update(int time, IInput input, BasicState state) {
    	if (input.getYawPositive()) {
    		Quaternion orientation = new Quaternion(state.ox, state.oy, state.oz, state.ow);
	    	incr.loadIdentity();
	        if (lockAxis == null) {
	            orientation.getRotationColumn(1, tempVa);
	            tempVa.normalizeLocal();
	            incr.fromAngleNormalAxis(-speed * toRADIANS, tempVa);
	        } else {
	            incr.fromAngleNormalAxis(-speed * toRADIANS, lockAxis);
	        }
	        orientation.fromRotationMatrix(
	                incr.mult(orientation.toRotationMatrix(tempMa),
	                        tempMb));
	        orientation.normalize();
	        state.ox = orientation.x;
	        state.oy = orientation.y;
	        state.oz = orientation.z;
	        state.ow = orientation.w;
    	}
    }
}
