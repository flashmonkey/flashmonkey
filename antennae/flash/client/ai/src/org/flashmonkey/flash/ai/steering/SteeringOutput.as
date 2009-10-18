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
package org.flashmonkey.flash.ai.steering
{
	import org.flashmonkey.flash.utils.math.Vector3f;
	
	import org.papervision3d.core.math.Quaternion;
		

	/**
	 * SteeringOutput is a movement requested by the steering system.
	 *
	 * It consists of linear and angular components. The components
	 * may be interpreted as forces and torques when output from a
	 * full dynamic steering behaviour, or as velocity and rotation
	 * when output from a kinematic steering behaviour. In the former
	 * case, neither force nor torque take account of mass, and so
	 * should be thought of as linear and angular acceleration.
	 * 
	 * @author Trevor
	 */
	public class SteeringOutput
	{
		/**
		 * The linear component of the steering action.
		 */
		public var linear : Vector3f;

		/**
		 * The angular component of the steering action.
		 */
		public var angular : Quaternion;

		/**
		 * Creates a new steering action with the given linear and
		 * angular changes.
		 *
		 * @param linear The initial linear change to give the
		 * SteeringOutput.
		 *
		 * @param angular The initial angular change to give the
		 * SteeringOutput.
		 */
		public function SteeringOutput(linear : Vector3f = null, angular : Quaternion = null)
		{
			this.linear = linear || new Vector3f( );
			this.angular = angular || new Quaternion( );
		}

		/**
		 * Zeros the linear and angular changes of this steering action.
		 */
		public function clear() : void
		{
			linear.zero();
			angular.x = 0; angular.y = 0; angular.z = 0; angular.w = 0;
		}

		/**
		 * Checks that the given steering action is equal to this.
		 * SteeringOutputs are equal if their linear and angular
		 * changes are equal.
		 */
		public function equals(other : SteeringOutput) : Boolean
		{
			return linear.equals( other.linear ) && angular == other.angular;
		}
	}
}
