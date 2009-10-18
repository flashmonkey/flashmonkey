package org.flashmonkey.java.behaviour;

import java.util.ArrayList;

import org.flashmonkey.java.behaviour.api.IBehaviour;
import org.flashmonkey.java.core.objects.BasicState;
import org.flashmonkey.java.input.api.IInput;

/**
 * CompositeBehaviour allows you to create complex behaviours. By adding several behaviours to a 
 * list the CompositeBehaviour.update() method iterates over each of the behaviours and applies
 * the result to the state object passed.
 * 
 * @author Trevor Burton [trevor@flashmonkey.org]
 *
 */
public class CompositeBehaviour implements IBehaviour {

	/**
	 * The list of behaviours that make up this composition.
	 */
	private ArrayList<IBehaviour> behaviours = new ArrayList<IBehaviour>();
	
	/**
	 * Creates a new CompositeBehaviour.
	 */
	public CompositeBehaviour() {
		
	}
	
	/**
	 * Add a behaviour to the list.
	 * 
	 * @param behaviour
	 */
	public void addBehaviour(IBehaviour behaviour) {
		behaviours.add(behaviour);
	}
	
	/**
	 * @InheritDoc
	 * 
	 * Iterate over all the behaviours in our list and call update() on each.
	 */
	public void update(int time, IInput input, BasicState state) {
		for (IBehaviour behaviour : behaviours) {
			behaviour.update(time, input, state);
		}
	}

}
