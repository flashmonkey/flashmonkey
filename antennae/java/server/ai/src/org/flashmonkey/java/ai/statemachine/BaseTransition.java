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
package org.flashmonkey.java.ai.statemachine;

import org.flashmonkey.java.action.Action;


/**
 * The base transition is used for any kind of state machine. It doesn't force a
 * representation for the states or their transitions, but does give values for
 * the actions to be carried out and the triggering.
 */
public class BaseTransition {
	/**
	 * Points to the next transition in the sequence. Transitions are arranged
	 * in a singly linked list.
	 */
	public BaseTransition next;

	/**
	 * The transition needs to decide if it can be triggered or not. This will
	 * depend on the sub-class of transition we're dealing with.
	 */
	public boolean isTriggered() {
		return false;
	}

	/**
	 * The transition can also optionally return a list of actions that need to
	 * be performed during the transition.
	 * 
	 * Note that this method should return one or more newly created action
	 * instances, and the caller of this method should be responsible for the
	 * deletion. In the default implementation, it returns nothing.
	 */
	public Action getActions() {
		return null;
	}

}
