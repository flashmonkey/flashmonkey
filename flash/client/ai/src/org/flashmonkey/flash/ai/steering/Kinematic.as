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
	 * Represents the position and movement of a character or other object.
	 *
	 * Kinematic extends location to add the first derivative of both
	 * position and orientation: velocity and rotation. Rotation
	 * consists of angular velocity about the positive z axis (the
	 * first derivative of orientation in the Location structure), this
	 * will be altered to be a full 3D angular velocity in due course.
	 * 
	 * @author Trevor
	 */
	public class Kinematic extends Location
	{
		/**
		 * The linear velocity.
		 */
		public var velocity : Vector3f;

		/**
		 * The angular velocity.
		 */
		public var rotation : Number;

		/**
		 * Creates a new Kinematic with the given position,
		 * orientation, velocity and rotational velocity.
		 *
		 * @param position The position of the Kinematic.
		 * @param orientation The orientation of the Kinematic.
		 * @param velocity The linear velocity of the Kinematic.
		 * @param rotation The angular velocity of the Kinematic.
		 */
		public function Kinematic(position : Vector3f = null, orientation : Number = 0,
                  velocity : Vector3f = null, rotation : Number = 0)
		{
			this.position = position;
			this.orientation = orientation;
			this.velocity = velocity;
			this.rotation = rotation;
		}

		/**
		 * Zeros the location and velocity of this Kinematic.
		 */
		override public function clear() : void
		{
			super.clear( );
            
			velocity.zero();
			rotation = 0.0;
		}

		/**
		 * Checks that the given Kinematic is equal to this.
		 * Kinematics are equal if their locations, velocities and
		 * rotations are equal.
		 */
		public function equalsK(other : Kinematic) : Boolean
		{
			//var o : Kinematic = Kinematic(other);
			return position.equals( other.position ) && orientation == other.orientation && velocity.equals( other.velocity ) && rotation == other.rotation;
		}

		/**
		 * Checks that the given Kinematic is less than this.  A
		 * Kinematic is less than another Kinematic if its position
		 * along the x-axis is less than that of the other Kinematic.
		 */
		public function lessThan(other : Kinematic) : Boolean
		{
			return position.x < other.position.x;
		}

		/**
		 * Sets the value of this Kinematic to the given location.
		 * The velocity components of the Kinematic are left
		 * unchanged.
		 *
		 * @param other The Location to set the Kinematic to.
		 */
		public function copyLocation(other : Location) : void
		{
			orientation = other.orientation;
			position.copyFrom( other.position );
		}

		/**
		 * Copies (by assignment) all the attributes of the given
		 * Kinematic.
		 *
		 * @param other Reference to Kinematic to copy.
		 */
		public function copyK(other : Kinematic) : void
		{
			orientation = other.orientation;
			position.copyFrom( other.position );
			velocity.copyFrom( other.velocity );
			rotation = other.rotation;
		}

		/**
		 * Modifies the value of this Kinematic by adding the given
		 * Kinematic.  Additions are performed by component.
		 */
		public function plusEquals(other : Kinematic) : void
		{
			position.addLocal( other.position );
			velocity.addLocal( other.velocity );
			rotation += other.rotation;
			orientation += other.orientation;
		}

		/**
		 * Modifies the value of this Kinematic by subtracting the
		 * given Kinematic.  Subtractions are performed by component.
		 */
		public function minusEquals(other : Kinematic) : void
		{
			position.subtractLocal( other.position );
			velocity.subtractLocal( other.velocity );
			rotation -= other.rotation;
			orientation -= other.orientation;
		}

		/**
		 * Scales the Kinematic by the given value.  All components
		 * are scaled, including rotations and orientations, this is
		 * normally not what you want. To scale only the linear
		 * components, use the *= operator on the position and
		 * velocity components individually.
		 *
		 * @param f The scaling factor.
		 */
		public function timesEquals(f : Number) : void
		{
			position.multLocalScalar(f)
			velocity.multLocalScalar( f );
			rotation *= f;
			orientation *= f;
		}

		/**
		 * Performs a forward Euler integration of the Kinematic for
		 * the given duration.  This applies the Kinematic's velocity
		 * and rotation to its position and orientation.
		 *
		 * \note All of the integrate methods in this class are
		 * designed to provide a simple mechanism for updating
		 * position. They are not a substitute for a full physics
		 * engine that can correctly resolve collisions and
		 * constraints.
		 *
		 * @param duration The number of simulation seconds to
		 * integrate over.
		 */
		// public function integrate(duration:Number):void
		// {
		// }

		/**
		 * Perfoms a forward Euler integration of the Kinematic for
		 * the given duration, applying the given acceleration.
		 * Because the integration is Euler, all the acceleration is
		 * applied to the velocity at the end of the time step.
		 *
		 * \note All of the integrate methods in this class are designed
		 * to provide a simple mechanism for updating position. They are
		 * not a substitute for a full physics engine that can correctly
		 * resolve collisions and constraints.
		 *
		 * @param steer The acceleration to apply over the
		 * integration.  
		 * @param duration The number of simulation
		 * seconds to integrate over.
		 */
		//void integrate(const SteeringOutput& steer, real duration);

		/**
		 * Perfoms a forward Euler integration of the Kinematic for
		 * the given duration, applying the given acceleration and
		 * drag.  Because the integration is Euler, all the
		 * acceleration is applied to the velocity at the end of the
		 * time step.
		 *
		 * \note All of the integrate methods in this class are designed
		 * to provide a simple mechanism for updating position. They are
		 * not a substitute for a full physics engine that can correctly
		 * resolve collisions and constraints.
		 *
		 * @param steer The acceleration to apply over the integration.
		 *
		 * @param drag The isotropic drag to apply to both velocity
		 * and rotation. This should be a value between 0 (complete
		 * drag) and 1 (no drag).
		 *
		 * @param duration The number of simulation seconds to
		 * integrate over.
		 */
		//void integrate(const SteeringOutput& steer,
		// real drag, real duration);

		/**
		 * Perfoms a forward Euler integration of the Kinematic for the given
		 * duration, applying the given acceleration and drag.
		 * Because the integration is Euler, all the acceleration is applied to
		 * the velocity at the end of the time step.
		 *
		 * \note All of the integrate methods in this class are designed
		 * to provide a simple mechanism for updating position. They are
		 * not a substitute for a full physics engine that can correctly
		 * resolve collisions and constraints.
		 *
		 * @param steer The acceleration to apply over the integration.
		 *
		 * @param drag The anisotropic drag to apply. The force
		 * component of the SteeringOutput is interpreted as linear drag
		 * coefficients in each direction, and torque component is
		 * interpreted as the rotational drag.
		 *
		 * @param duration The number of simulation seconds to
		 * integrate over.
		 */
		// void integrate(const SteeringOutput& steer,
		//const SteeringOutput& drag,
		//real duration);

		/**
		 * Trims the speed of the kinematic to be no more than that
		 * given.
		 */
		public function trimMaxSpeed(speed : Number) : void
		{
			if (velocity.length() > speed) 
			{
				velocity.normalise( );
				velocity.multLocalScalar( speed );
			}
		}

		/**
		 * Sets the orientation of this location so it points along
		 * its own velocity vector.
		 */
		override public function setOrientationFromVelocity(velocity : Vector3f) : void
		{
			// If we haven't got any velocity, then we can do nothing.
			if (velocity.lengthSquared() > 0) 
			{
				orientation = Math.atan2( velocity.x, velocity.z );
			}
		}
	}
}
