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
package org.flashmonkey.flash.ai.steering.pipeline.constraints 
{
	import org.flashmonkey.flash.ai.collision.ICollisionDetector;
	import org.flashmonkey.flash.ai.steering.Kinematic;
	import org.flashmonkey.flash.ai.steering.pipeline.SteeringConstraint;
	import org.flashmonkey.flash.utils.math.Vector3f;	

	/**
	 * @author Trevor
	 */
	public class AvoidWallsConstraint extends SteeringConstraint 
	{
		protected var _collisionDetector : ICollisionDetector;

		/**
		 * Function calculating the suggested goal when a collision is
		 * detected.
		 *
		 * @param actor The position and course from which
		 * collisions were probed.
		 *
		 * The result is written directly to the suggestedGoal member
		 * variable.  The time member variable is not altered. The
		 * caller must set it to the appropriate value before calling
		 * this method.
		 */
		protected function calcResolution(actor : Kinematic) : void
		{
		}

		/**
		 * This flag indicates whether or not to perform 3d collision
		 * resolution.  It defaults to true.
		 */
		public var use3dRestitution : Boolean;

		/**
		 * Distance from the wall that the constraint will try to keep
		 * at.  Default value is 1.
		 */
		public var safetyMargin : Number;

		/**
		 * The distance by which the tip of the collision vector
		 * (normal to the wall) is shifted along the wall to produce
		 * the correction vector.
		 */
		public var shift : Number;

		/**
		 * The absolute velocity of the suggested goal. If this value
		 * is negative then the current actor speed is used. Default
		 * value is -1.
		 */
		public var goalSpeed : Number;

		/**
		 * Collision point and normal vector returned by the collision
		 * detector.
		 */
		public var cp : Vector3f;

		public var cv : Vector3f;

		/**
		 * Constructor.
		 *
		 * @param d Pointer to an instance of CollisionDetector.
		 */
		public function AvoidWallsConstraint(collisionDetector : ICollisionDetector)
		{
			super( );
        	
			_collisionDetector = collisionDetector;                
		}

		override public function initialise() : void
		{
			use3dRestitution = true;
			safetyMargin = 1;
			shift = 1;
			goalSpeed = -1;
		}

		/**
		 * Set the collision detector currently in use by this constraint.
		 *
		 * @param cd Pointer to the collision detector to use.
		 */
		public function set collisionDetector(cd : ICollisionDetector):void
		{
			_collisionDetector = cd;
		}

		/**
		 * Runs the constraint.
		 */
		override public function run() : void
		{
		}
	}
}
