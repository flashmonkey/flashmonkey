package org.flashmonkey.java.adaptor.jmonkey.behaviour;

import org.flashmonkey.java.behaviour.api.IBehaviour;
import org.flashmonkey.java.core.objects.BasicState;
import org.flashmonkey.java.input.api.IInput;

public class AbstractAvatarBehaviour implements IBehaviour {

	/** A speed value that, if desired, can change how actions are performed. */
    protected float speed = 0;
    
    public AbstractAvatarBehaviour() {
    	
    }
    
    public AbstractAvatarBehaviour(float speed) {
    	this.speed = speed;
    }

    /**
     *
     * <code>setSpeed</code> defines the speed at which this action occurs.
     *
     * @param speed
     *            the speed at which this action occurs.
     */
    public void setSpeed(float speed) {
        this.speed = speed;
    }

    /**
     * Returns the currently set speed. Speed is 0 by default.
     *
     * @return The current speed.
     */
    public float getSpeed() {
        return speed;
    }
    
	public void update(int time, IInput input, BasicState state) {
		
	}

}
