package org.flashmonkey.java.behaviour.api;

import org.flashmonkey.java.input.api.IInput;
import org.flashmonkey.java.core.objects.BasicState;

/**
 * Represents an Avatar's 'behaviour'.
 * 
 * An implementation of the IBehaviour interface can look at the current Input for the 
 * avatar it's associated with and affect the avatar's state appropriately. So, for instance,
 * it can react to key presses by moving the avatar forward, backward, strafing, rotating etc.
 * 
 * @author Trevor Burton [trevor@flashmonkey.org]
 *
 */
public interface IBehaviour {

	/**
	 * Allows an avatar's state property to be manipulated dependant on the current state
	 * of it's associated input and it's current time stream.
	 * 
	 * @param time The time stream for the avatar this behaviour is associated with.
	 * @param input The current state of the input for the avatar this behaviour is associated with.
	 * @param state The state object for the avatar this behaviour is associated with.
	 */
	public void update(int time, IInput input, BasicState state);
}
