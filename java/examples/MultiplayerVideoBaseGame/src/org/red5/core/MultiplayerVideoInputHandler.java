package org.red5.core;

import org.flashmonkey.java.input.api.IInput;
import org.flashmonkey.java.utils.input.SimpleInput;

import jmetest.flagrushtut.lesson9.Vehicle;
import jmetest.flagrushtut.lesson9.actions.DriftAction;
import jmetest.flagrushtut.lesson9.actions.ForwardAndBackwardAction;
import jmetest.flagrushtut.lesson9.actions.VehicleRotateAction;

import com.jme.input.InputHandler;
import com.jme.input.action.InputActionEvent;

public class MultiplayerVideoInputHandler extends InputHandler {

	private IInput input = new SimpleInput();
	
	ForwardAndBackwardAction forward;
	ForwardAndBackwardAction backward;
	VehicleRotateAction rotateLeft;
	VehicleRotateAction rotateRight;
	
	//the vehicle we are going to control
    private Vehicle vehicle;
    //the default action
    protected DriftAction drift;
    
    public void update(float time) {
        if ( !isEnabled() ) return;

        super.update(time);
        
        if (!input.equals(null)) {
        	
        	InputActionEvent evt = new InputActionEvent();
        	evt.setTime(time);
        	
        	if (input.getMoveForward()) {
        		forward.performAction(evt);
        	}
        	
        	if (input.getMoveBackward()) {
        		backward.performAction(evt);
        	}
        	
        	if (input.getYawPositive()) {
        		rotateRight.performAction(evt);
        	}
        	
        	if (input.getYawNegative()) {
        		rotateLeft.performAction(evt);
        	}
        }
        
        //we always want to allow friction to control the drift
        drift.performAction(event);
        vehicle.update(time);
    }
    
    /**
     * Supply the node to control and the api that will handle input creation.
     * @param vehicle the node we wish to move
     * @param api the library that will handle creation of the input.
     */
    public MultiplayerVideoInputHandler(Vehicle vehicle, String api) {
        this.vehicle = vehicle;
        setActions(vehicle);
    }

    /**
     * assigns action classes to triggers. These actions handle moving the node forward, backward and 
     * rotating it. It also creates an action for drifting that is not assigned to key trigger, this
     * action will occur each frame.
     * @param node the node to control.
     */
    private void setActions(Vehicle node) {
    	forward = new ForwardAndBackwardAction(node, ForwardAndBackwardAction.FORWARD);
        backward = new ForwardAndBackwardAction(node, ForwardAndBackwardAction.BACKWARD);
        rotateLeft = new VehicleRotateAction(node, VehicleRotateAction.LEFT);
        rotateRight = new VehicleRotateAction(node, VehicleRotateAction.RIGHT);
        
        //not triggered by keyboard
        drift = new DriftAction(node);
    }
    
    public void setInput(IInput input) {
    	this.input = input;
    }
}
