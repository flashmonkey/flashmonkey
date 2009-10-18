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

	/**
	 * @author Trevor
	 */
	public class Location
	{
		/**
		 * The position in 3 space.
		 */
		public var position : Vector3f;

		/**
		 * The orientation, as a euler angle in radians around the
		 * positive y axis (i.e. up) from the positive z axis.
		 */
		public var orientation : Number;

		/**
		 * Creates a location with the given position and orientation.
		 */
		public function Location(position : Vector3f = null, orientation : Number = NaN)
		{
			this.position = position;
			this.orientation = orientation;
		}

		/**
		 * Assignment operator.
		 */
		public function copy(other : Location) : void
		{						
			position = other.position;
			orientation = other.orientation;
		}

		/**
		 * Zeros the position and orientation.
		 */
		public function clear() : void
		{
			position.zero();
			orientation = 0.0;
		}

		/**
		 * Checks that the given location is equal to this. Locations
		 * are equal if their positions and orientations are equal.
		 */
		public function equals(other : Location) : Boolean
		{
			return position.equals( other.position ) && orientation == other.orientation;
		}

		/**
		 * Perfoms a forward Euler integration of the Kinematic for
		 * the given duration, applying the given steering velocity
		 * and rotation.
		 *
		 * \note All of the integrate methods in this class are designed
		 * to provide a simple mechanism for updating position. They are
		 * not a substitute for a full physics engine that can correctly
		 * resolve collisions and constraints.
		 *
		 * @param steer The velocity to apply over the integration.
		 *
		 * @param duration The number of simulation seconds to
		 * integrate over.
		 */
		public function integrate( steer : SteeringOutput, duration : Number) : void
		{
		}

		/**
		 * Sets the orientation of this location so it points along
		 * the given velocity vector.
		 */
		public function setOrientationFromVelocity(velocity : Vector3f) : void
		{
			// If we haven't got any velocity, then we can do nothing.
			if (velocity.lengthSquared() > 0) 
			{
				orientation = Math.atan2( velocity.x, velocity.z );
			}
		}

		/**
		 * Returns a unit vector in the direction of the current
		 * orientation.
		 */
		public function getOrientationAsVector() : Vector3f
		{
			return new Vector3f( Math.sin( orientation ), 0, Math.cos( orientation ) );
		}
	}
}
