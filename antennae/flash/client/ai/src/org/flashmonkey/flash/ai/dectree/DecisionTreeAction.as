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
package org.flashmonkey.flash.ai.dectree 
{

	/**
	 * @author Trevor
	 */
	public class DecisionTreeAction extends DecisionTreeNode
	{
		/**
		 * Makes the decision - in  this case there is no decision, so
		 * this method returns the action back again..
		 */
		override public function makeDecision() : DecisionTreeNode
		{
			return this;
		}
	}
}
