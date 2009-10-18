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
 * Compund actions are made up of sub-actions. This is a base
 * class that adds the sub-action management code that then has
 * sematics added in its sub-classes.
 */
public class ActionCompound extends Action {
	public Action subActions;

	/**
	 * Requests that the action delete itself and its children.
	 */
	@Override
	public void deleteList() {
		if (subActions != null)
			subActions.deleteList();
		super.deleteList();
	}

	/**
	 * Compound actions are compatible, only if all their components are
	 * compatible.
	 */
	@Override
	public boolean canDoBoth(Action action) {
		Action next = subActions;
		while (next != null) {
			if (!next.canDoBoth(action))
				return false;
			next = next.next;
		}
		return true;
	}
}
