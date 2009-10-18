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
	import org.flashmonkey.flash.ai.steering.Kinematic;	

	/**
	 * Generates goals in the form of a kinematic (position,
	 * orientation, velocity and rotation) that can be sought by the
	 * steering system.  This class can be used as is, to specify the
	 * target, or it may be extended to provide more sophisticated
	 * targeting behaviour.  Targeters are intended to work only when
	 * installed in a SteerPipe class.
	 * 
	 * @author Trevor
	 */
	public class Targeter
	{
		/**
		 * Pointer to the SteerPipe class, where details about the actor and
		 * the goal are stored. This is set by the SteerPipe class when the
		 * targeter is installed.
		 */
		public var steering : SteeringPipeline;

		/**
		 * Pointer to the generated goal. This pointer is returned by
		 * the inline function getGoal.
		 */
		protected var goal : Kinematic;

		/**
		 * Creates a new targeter seeking the given goal.
		 */
		public function Targeter(g : Kinematic)
		{
			goal = g;
		}

		/**
		 * Gets the goal to the given kinematic.
		 */
		public function setGoal(g : Kinematic) : void
		{
			goal = g;
		}

		/**
		 * Gets the current goal for this targeter. For efficiency,
		 * this method is inline and cannot be overloaded. The pointer
		 * stored in this class can be set when the targeter receives
		 * execution time (in the normal manner, through its run
		 * function), or by calling setGoal explicitly.
		 *
		 * @returns The current goal, always the pointer stored in the
		 * goal member.
		 */
		public function getGoal() : Kinematic
		{
			return goal;
		}

		/**
		 * Returns the kinematick of the agent's actor.
		 */
		public function getActor() : Kinematic
		{
			if (!steering) return null;
			return steering.getActor();
		}

		/**
		 * Runs the targeter. The default implementation does nothing,
		 * because the goal is assumed to be explicit.
		 */
		public function run() : void
		{
		}
	}
}
