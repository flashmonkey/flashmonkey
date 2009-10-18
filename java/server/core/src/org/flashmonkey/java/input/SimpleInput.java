package org.flashmonkey.java.input;

import org.red5.io.amf3.IDataInput;
import org.red5.io.amf3.IDataOutput;

public class SimpleInput extends AbstractInput {

	private boolean moveForward;

	@Override
	public boolean getMoveForward() {
		return moveForward;
	}
	
	@Override
	public void setMoveForward(boolean forward) {
		this.moveForward = forward;
	}
	
	private boolean moveBackward;
	
	@Override
	public boolean getMoveBackward() {
		return moveBackward;
	}
	
	@Override
	public void setMoveBackward(boolean backward) {
		this.moveBackward = backward;
	}
	
	private boolean moveLeft;

	@Override
	public boolean getMoveLeft() {
		return moveLeft;
	}
	
	@Override
	public void setMoveLeft(boolean left) {
		this.moveLeft = left;
	}
	
	private boolean moveRight;

	@Override
	public boolean getMoveRight() {
		return moveRight;
	}
	
	@Override
	public void setMoveRight(boolean right) {
		this.moveRight = right;
	}
	
	private boolean moveUp;

	@Override
	public boolean getMoveUp() {
		return moveUp;
	}
	
	@Override
	public void setMoveUp(boolean up) {
		this.moveUp = up;
	}
	
	private boolean moveDown;

	@Override
	public boolean getMoveDown() {
		return moveDown;
	}
	
	@Override
	public void setMoveDown(boolean down) {
		this.moveDown = down;
	}
	
	private boolean pitchPositive;

	@Override
	public boolean getPitchPositive() {
		return pitchPositive;
	}
	
	@Override
	public void setPitchPositive(boolean pitchPositive) {
		this.pitchPositive = pitchPositive;
	}	
	
	private boolean pitchNegative;

	@Override
	public boolean getPitchNegative() {
		return pitchNegative;
	}
	
	@Override
	public void setPitchNegative(boolean pitchNegative) {
		this.pitchNegative = pitchNegative;
	}
	
	private boolean rollPositive;

	@Override
	public boolean getRollPositive() {
		return rollPositive;
	}
	
	@Override
	public void setRollPositive(boolean rollPositive) {
		this.rollPositive = rollPositive;
	}

	private boolean rollNegative;
	
	@Override
	public boolean getRollNegative() {
		return rollNegative;
	}
	
	@Override
	public void setRollNegative(boolean rollNegative) {
		this.rollNegative = rollNegative;
	}

	private boolean yawPositive;

	@Override
	public boolean getYawPositive() {
		return yawPositive;
	}

	@Override
	public void setYawPositive(boolean yawPositive) {
		this.yawPositive = yawPositive;
	}
	
	private boolean yawNegative;
	
	@Override
	public boolean getYawNegative() {
		return yawNegative;
	}
	
	@Override
	public void setYawNegative(boolean yawNegative) {
		this.yawNegative = yawNegative;
	}

	private boolean fire;

	@Override
	public boolean getFire() {
		return fire;
	}

	@Override
	public void setFire(boolean fire) {
		this.fire = fire;
	}

	private boolean jump;

	@Override
	public boolean getJump() {
		return jump;
	}

	@Override
	public void setJump(boolean jump) {
		this.jump = jump;
	}
	
	private float mouseX;
	
	@Override
	public float getMouseX() {
		return mouseX;
	}
	
	@Override
	public void setMouseX(float mouseX) {
		this.mouseX = mouseX;
	}
	
	private float mouseY;
	
	@Override
	public float getMouseY() {
		return mouseY;
	}
	
	@Override
	public void setMouseY(float mouseY) {
		this.mouseY = mouseY;
	}
	
	public SimpleInput() {
		
	}
	
	@Override
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

	@Override
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
