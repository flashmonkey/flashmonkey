package org.flashmonkey.java.input;

import org.flashmonkey.java.input.api.IInput;
import org.red5.io.amf3.IDataInput;
import org.red5.io.amf3.IDataOutput;

public abstract class AbstractInput implements IInput {

	private boolean moveForward;

	public boolean getMoveForward() {
		return moveForward;
	}
	
	public void setMoveForward(boolean forward) {
		this.moveForward = forward;
	}
	
	private boolean moveBackward;
	
	public boolean getMoveBackward() {
		return moveBackward;
	}
	
	public void setMoveBackward(boolean backward) {
		this.moveBackward = backward;
	}
	
	private boolean moveLeft;

	public boolean getMoveLeft() {
		return moveLeft;
	}
	
	public void setMoveLeft(boolean left) {
		this.moveLeft = left;
	}
	
	private boolean moveRight;

	public boolean getMoveRight() {
		return moveRight;
	}
	
	public void setMoveRight(boolean right) {
		this.moveRight = right;
	}
	
	private boolean moveUp;

	public boolean getMoveUp() {
		return moveUp;
	}
	
	public void setMoveUp(boolean up) {
		this.moveUp = up;
	}
	
	private boolean moveDown;

	public boolean getMoveDown() {
		return moveDown;
	}
	
	public void setMoveDown(boolean down) {
		this.moveDown = down;
	}
	
	private boolean pitchPositive;

	public boolean getPitchPositive() {
		return pitchPositive;
	}
	
	public void setPitchPositive(boolean pitchPositive) {
		this.pitchPositive = pitchPositive;
	}	
	
	private boolean pitchNegative;

	public boolean getPitchNegative() {
		return pitchNegative;
	}
	
	public void setPitchNegative(boolean pitchNegative) {
		this.pitchNegative = pitchNegative;
	}
	
	private boolean rollPositive;

	public boolean getRollPositive() {
		return rollPositive;
	}
	
	public void setRollPositive(boolean rollPositive) {
		this.rollPositive = rollPositive;
	}

	private boolean rollNegative;
	
	public boolean getRollNegative() {
		return rollNegative;
	}
	
	public void setRollNegative(boolean rollNegative) {
		this.rollNegative = rollNegative;
	}

	private boolean yawPositive;

	public boolean getYawPositive() {
		return yawPositive;
	}
	
	public void setYawPositive(boolean yawPositive) {
		this.yawPositive = yawPositive;
	}
	
	private boolean yawNegative;
	
	public boolean getYawNegative() {
		return yawNegative;
	}
	
	public void setYawNegative(boolean yawNegative) {
		this.yawNegative = yawNegative;
	}

	private boolean fire;

	public boolean getFire() {
		return fire;
	}

	public void setFire(boolean fire) {
		this.fire = fire;
	}

	private boolean jump;

	public boolean getJump() {
		return jump;
	}

	public void setJump(boolean jump) {
		this.jump = jump;
	}
	
	private float mouseX;
	
	public float getMouseX() {
		return mouseX;
	}
	
	public void setMouseX(float mouseX) {
		this.mouseX = mouseX;
	}
	
	private float mouseY;
	
	public float getMouseY() {
		return mouseY;
	}
	
	public void setMouseY(float mouseY) {
		this.mouseY = mouseY;
	}
	
	public AbstractInput() {
		
	}

	public void readExternal(IDataInput input) {
		moveForward = input.readBoolean();
		moveBackward = input.readBoolean();
		moveRight = input.readBoolean();
		moveLeft = input.readBoolean();
		moveUp = input.readBoolean();
		moveDown = input.readBoolean();
		pitchPositive = input.readBoolean();
		pitchNegative = input.readBoolean();		
		rollPositive = input.readBoolean();
		rollNegative = input.readBoolean();		
		yawPositive = input.readBoolean();
		yawNegative = input.readBoolean();		
		fire = input.readBoolean();
		jump = input.readBoolean();
		mouseX = input.readFloat();
		mouseY = input.readFloat();
	}

	public void writeExternal(IDataOutput output) {
		output.writeBoolean(moveForward);
		output.writeBoolean(moveBackward);
		output.writeBoolean(moveRight);
		output.writeBoolean(moveLeft);
		output.writeBoolean(moveUp);
		output.writeBoolean(moveDown);
		output.writeBoolean(pitchPositive);
		output.writeBoolean(pitchNegative);
		output.writeBoolean(rollPositive);
		output.writeBoolean(rollNegative);
		output.writeBoolean(yawPositive);
		output.writeBoolean(yawNegative);
		output.writeBoolean(fire);
		output.writeBoolean(jump);
		output.writeFloat(mouseX);
		output.writeFloat(mouseY);
	}

}
