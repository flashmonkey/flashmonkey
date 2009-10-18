/*
 * Part of the Artificial Intelligence for Games system.
 *
 * Copyright (c) Ian Millington 2003-2006. All Rights Reserved.
 *
 * This software is distributed under licence. Use of this software
 * implies agreement with all terms and conditions of the accompanying
 * software licence.
 * 
 * Java port - Trevor Burton [worldofpaper@googlemail.com]
 */
package org.flashmonkey.java.action;

/**
 * An action combination is a set of actions that can be performed
 * at the same time.
 */
public class ActionSequence extends ActionCompound {
	/**
     * Checks if this action can interrupt. The combination can
     * interrupt if the first action can.
     */
	@Override
    public boolean canInterrupt() {
		if (subActions != null) return subActions.canInterrupt();
        else return false;
    }

    /**
     * Returns true if all the sub-actions are done. Otherwise the
     * manager keeps scheduling the action.
     */
	@Override
    public boolean isComplete() {
		return (subActions == null);
    }

    /**
     * Called to make the action do its stuff. It calls all its
     * subactions.
     */
	@Override
    public void act() {
		// Check if we have anything to do
        if (subActions == null) return;

        // Run the first action in the list
        subActions.act();

        // Then consume it if its done
        if (subActions.isComplete()) {

           // Action temp = subActions;
            subActions = subActions.next;
            //delete temp;
        }
    }
}
