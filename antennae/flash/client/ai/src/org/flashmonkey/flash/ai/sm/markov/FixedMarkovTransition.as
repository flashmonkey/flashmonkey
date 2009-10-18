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

	/**
	 * A markov transition with a fixed and explicit matrix.
	 */
	public class FixedMarkovTransition extends MarkovTransition 
	{
		/**
		 * The matrix associated with this transition.
		 */
		public var matrix : Array;
		
		/**
         * Returns the matrix defined in this instance.
         *
         * @return The matrix as a linear array in row-major order
         * (i.e. its number of elements is the square of the size of
         * the state vector. The matrix will be pre-multiplied with
         * the state vector.
         */
        override public function getMatrix():Array
        {
        	return matrix;	
        }
	}
}
