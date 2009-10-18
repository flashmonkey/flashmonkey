package org.flashmonkey.java.input.api;

import org.red5.io.amf3.IExternalizable;

public interface IInput extends IExternalizable {

	public boolean getMoveForward();
	
	public void setMoveForward(boolean forward);

	public boolean getMoveBackward();
	
	public void setMoveBackward(boolean backward);

	public boolean getMoveRight();
	
	public void setMoveRight(boolean right);

	public boolean getMoveLeft();
	
	public void setMoveLeft(boolean left);

	public boolean getMoveUp();
	
	public void setMoveUp(boolean up);

	public boolean getMoveDown();
	
	public void setMoveDown(boolean down);

	public boolean getPitchPositive();
	
	public void setPitchPositive(boolean pitchPositive);
	
	public boolean getPitchNegative();
	
	public void setPitchNegative(boolean pitchNegative);

	public boolean getRollPositive();
	
	public void setRollPositive(boolean rollPositive);

	public boolean getRollNegative();
	
	public void setRollNegative(boolean rollNegative);
	
	public boolean getYawPositive();
	
	public void setYawPositive(boolean yawPositive);
	
	public boolean getYawNegative();
	
	public void setYawNegative(boolean yawNegative);

	public boolean getFire();
	
	public void setFire(boolean fire);
	
	public boolean getJump();
	
	public void setJump(boolean jump);
	
	public float getMouseX();
	
	public void setMouseX(float mouseX);
	
	public float getMouseY();
	
	public void setMouseY(float mouseY);
}