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
package org.flashmonkey.flash.ai.sm.markov 
{
	import org.flashmonkey.flash.ai.sm.Transition;

	/**
	 * Markov transitions consist of a matrix that is multiplied by
	 * the current state vector. They can also contain actions like a
	 * regular transition.
	 */
	public class MarkovTransition extends Transition
	{
		/**
		 * Returns the matrix associated with the transition. This
		 * will be multiplied by the state vector to get the new state
		 * vector.
		 *
		 * @return The matrix as a linear array in row-major order
		 * (i.e. its number of elements is the square of the size of
		 * the state vector. The matrix will be pre-multiplied with
		 * the state vector.
		 */
		public function getMatrix() : Array
		{
			return null;	
		}
	}
}
