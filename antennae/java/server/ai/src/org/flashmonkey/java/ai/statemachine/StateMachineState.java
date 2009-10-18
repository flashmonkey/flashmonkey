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

abstract public class StateMachineState
{
	/**
	 * Returns the first in a sequence of actions that should be performed while
	 * the character is in this state.
	 * 
	 * Note that this method should return one or more newly created action
	 * instances, and the caller of this method should be responsible for the
	 * deletion. In the default implementation, it returns nothing.
	 */
	abstract public Action getActions();
	
	/**
	 * Returns the sequence of actions to perform when arriving in this state.
	 * 
	 * Note that this method should return one or more newly created action
	 * instances, and the caller of this method should be responsible for the
	 * deletion. In the default implementation, it returns nothing.
	 */
	abstract public Action getEntryActions();
	
	/**
	 * Returns the sequence of actions to perform when leaving this state.
	 * 
	 * Note that this method should return one or more newly created action
	 * instances, and the caller of this method should be responsible for the
	 * deletion. In the default implementation, it returns nothing.
	 */
	abstract public Action getExitActions();
	
	/**
	 * The first in the sequence of transitions that can leave this state.
	 */
	public Transition	firstTransition;
}
