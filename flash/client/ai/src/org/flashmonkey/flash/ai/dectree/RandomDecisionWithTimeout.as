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
	public class RandomDecisionWithTimeout extends RandomDecision 
	{
		/**
		 * Holds the frame number that the current decision was made
		 * on.
		 */
		public var firstDecisionFrame : int = 0;

		/**
		 * Holds the number of frames to wait before timing out the
		 * decision.
		 */
		public var timeOutDuration : int;

		/**
		 * Works out which branch to follow.
		 */
		override public function getBranch() : Boolean
		{
			var thisFrame : int = 0;
			//TimingData::get().frameNumber;

			// Check if the stored decision is either too old, or if we timed out.
			if (thisFrame > lastDecisionFrame + 1 || thisFrame > firstDecisionFrame + timeOutDuration) 
			{
				// Make a new decision
				lastDecision = RandomUtils.randomBoolean();

				// And record that it was just made
				firstDecisionFrame = thisFrame;
			}

			// Update the frame number
			lastDecisionFrame = thisFrame;

			// And return the stored value
			return lastDecision;	
		}
	}
}
