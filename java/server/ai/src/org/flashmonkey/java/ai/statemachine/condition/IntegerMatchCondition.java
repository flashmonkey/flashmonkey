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
package org.flashmonkey.java.ai.statemachine.condition;

import org.flashmonkey.java.ai.statemachine.Condition;

public class IntegerMatchCondition implements Condition
{
	/**
	 * A pointer to the integer value we should try to match.
	 */
	public int	watch;
	
	/**
	 * The target value for the integer. If this is matched, then the condition
	 * will be true.
	 */
	public int	target;
	
	/**
	 * Checks if the target matches the watch value.
	 */
	public boolean test()
	{
		return watch == target;
	}
}
