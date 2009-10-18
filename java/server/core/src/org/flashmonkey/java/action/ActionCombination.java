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
public class ActionCombination extends ActionCompound {
	/**
     * Checks if this action can interrupt. The combination can
     * interrupt if any of its actions can.
     */
	@Override
	public boolean canInterrupt() {
		Action next = subActions;
		while (next != null) {
			if (next.canInterrupt())
				return true;
			next = next.next;
		}
		return false;
	}

    /**
     * Returns true if all the sub-actions is done. Otherwise the
     * manager keeps scheduling the action.
     */
	@Override
	public boolean isComplete() {
		Action next = subActions;
		while (next != null) {
			if (!next.isComplete())
				return false;
			next = next.next;
		}
		return true;
	}

    /**
     * Called to make the action do its stuff. It calls all its
     * subactions.
     */
	@Override
	public void act() {
		Action next = subActions;
		while (next != null) {
			if (!next.isComplete())
				next.act();
			next = next.next;
		}
	}
}
