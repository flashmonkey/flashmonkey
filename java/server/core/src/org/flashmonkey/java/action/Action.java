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
 * The action class is the base class for any request the AI makes
 * of the game. In some cases the AI is simple enough for this to
 * be uneccesary (in steering behaviours for example, the steering
 * output is often directly applied). In decision making, however,
 * it is more important.
 */
public class Action {
	/**
     * The relative priority of this action. This allows actions
     * to preempt others.
     */
    public int priority;

    /**
     * Actions naturally come in sequences, so their are
     * implemented as a single linked list by default.
     */
    public Action next;
    
	/**
     * The action class is the base class for any request the AI makes
     * of the game. In some cases the AI is simple enough for this to
     * be unneccesary (in steering behaviours for example, the steering
     * output is often directly applied). In decision making, however,
     * it is more important.
     */
    public Action() {
    	
    }

    /**
     * Returns the last action in the list of actions.
     */
    public Action getLast() {
    	 // If we're at the end, then end
        if (next == null) return this;

        // Otherwise find the end iteratively
        Action thisAction = this;
        Action nextAction = next;
        while(nextAction != null) {
            thisAction = nextAction;
            nextAction = nextAction.next;
        }

        // The final element is in thisAction, so return it
        return thisAction;
    }

    /**
     * Checks if this action can be interrupt others. By default
     * no actions can be interrupt.
     */
    public boolean canInterrupt() {
    	return false;
    }

    /**
     * Asks the action to check if it be performed at the same
     * time as the given action. This relationship may not be
     * reflexible: both actions in a pair are asked, and things
     * only progress if both agree. By default an action cannot be
     * done with any other.
     */
    public boolean canDoBoth(Action other) {
    	return false;
    }

    /**
     * Returns true if the action is done. Otherwise the manager
     * keeps scheduling the action. The default implementation is
     * always done.
     */
    public boolean isComplete() {
    	return false;
    }

    /**
     * Requests that the action delete itself and its children.
     */
    public void deleteList() {
    	
    }

    /**
     * Called to make the action do its stuff. This depends on the
     * type of action, and the default implementation does
     * nothing.
     */
    public void act() {
    	// Does nothing.
    }
}
