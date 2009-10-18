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
	 * A decision tree node is a base class for anything that makes a
	 * decision.
	 */
	public class DecisionTreeNode 
	{
		/**
		 * The make decision method carries out a decision making
		 * process and returns the new decision tree node that we've
		 * reached in the tree.
		 */
		public function makeDecision() : DecisionTreeNode
		{
			return null;	
		}
	}
}
