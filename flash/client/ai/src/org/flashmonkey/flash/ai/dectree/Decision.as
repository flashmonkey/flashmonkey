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
	 * Other than actions, the tree is made up of decisions, which
	 * come up with some boolean result and choose a branch based on
	 * that.
	 */
	public class Decision extends DecisionTreeNode 
	{
		public var trueBranch : DecisionTreeNode;

		public var falseBranch : DecisionTreeNode;

		/**
		 * This method actually does the checking for the decision.
		 */
		public function getBranch() : Boolean
		{
			return false;	
		}

		/**
		 * This is where the decision tree algorithm is located: it
		 * recursively walks down the tree until it reaches the final
		 * item to return (which is an action).
		 */
		override public function makeDecision() : DecisionTreeNode
		{
			var branch : DecisionTreeNode;
			
			// Choose a branch based on the getBranch method
			if (getBranch()) 
			{
				// Make sure its not null before recursing.
				if (trueBranch)
	            	branch = trueBranch.makeDecision();
			} 
			else 
			{
				// Make sure its not null before recursing.
				if (falseBranch)
					branch = falseBranch.makeDecision();
			}	
			
			return branch;
		}
	}
}
