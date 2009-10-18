package org.flashmonkey.java.behaviour;

import org.flashmonkey.java.behaviour.api.IBehaviour;
import org.flashmonkey.java.core.objects.BasicState;
import org.flashmonkey.java.input.api.IInput;

/**
 * NullBehaviour simple implements the IBehaviour interface - it's update() method is 
 * empty so will not affect an avatar when it's set as the avatar's behaviour.
 * 
 * @author Trevor Burton [trevor@flashmonkey.org]
 *
 */
public class NullBehaviour implements IBehaviour {

	/**
	 * @inheritDoc
	 * 
	 * Does nothing!
	 */
	public void update(int time, IInput input, BasicState state) {}
}
