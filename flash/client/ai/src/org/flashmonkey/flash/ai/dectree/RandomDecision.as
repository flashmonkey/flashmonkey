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
	import org.flashmonkey.flash.utils.number.RandomUtils;
		
	
	/**
	 * This class represents a stable random decision. As long as the
	 * decision is reached at each frame, the decision will be made
	 * the same way each time. Otherwise the decision will be made at
	 * random.
	 */
	public class RandomDecision extends Decision 
	{
		/**
		 * Holds the last decision that was made.
		 */
		public var lastDecision : Boolean = false;

		/**
		 * Holds the number of the last frame at which the decision
		 * was made.
		 */
		public var lastDecisionFrame : int = 0;

		/**
		 * Works out which branch to follow.
		 */
		override public function getBranch() : Boolean
		{
			var thisFrame : int = 0;
			//TimingData::get().frameNumber;

			// If we didn't get here last time, then things may change
			if (thisFrame > lastDecisionFrame + 1) 
			{
				lastDecision = RandomUtils.randomBoolean();
			}

			// In any case, store the frame number
			lastDecisionFrame = thisFrame;

			// And return the stored value
			return lastDecision;	
		}
	}
}
