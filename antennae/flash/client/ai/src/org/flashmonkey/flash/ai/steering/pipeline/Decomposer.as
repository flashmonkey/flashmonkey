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
package org.flashmonkey.flash.ai.steering.pipeline 
{			

	/**
	 * @author Trevor
	 */
	public class Decomposer
	{
		/**
         * Pointer to the SteerPipe class, where details about the actor and
         * the goal are stored. This is set by the SteerPipe class when the
         * decomposer is installed.
         */
        public var steering : SteeringPipeline;

        /**
         * Decomposers can be structured in a list. This points to the
         * next item.
         */
        public var next : Decomposer;

        /**
         * Creates a new decomposer.
         */
        public function Decomposer()
        {
        }

        /**
         * Runs the decomposer.
         */
        public function run():void
        {
        }
	}
}
