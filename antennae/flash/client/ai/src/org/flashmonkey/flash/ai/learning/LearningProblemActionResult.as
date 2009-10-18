/*
 * Part of the Artificial Intelligence for Games system.
 *
 * Copyright (c) Ian Millington 2003-2006. All Rights Reserved.
 *
 * This software is distributed under licence. Use of this software
 * implies agreement with all terms and conditions of the accompanying
 * software licence.
 * 
 * Actionscript port - Trevor Burton [worldofpaper@googlemail.com]
 */
package org.flashmonkey.flash.ai.learning 
{

	/**
	 * This is the result of taking an action - a new world state, and
	 * a reward.
	 */
	public class LearningProblemActionResult 
	{
		public var state : LearningProblemState;

		public var reward : Number;
	}
}
