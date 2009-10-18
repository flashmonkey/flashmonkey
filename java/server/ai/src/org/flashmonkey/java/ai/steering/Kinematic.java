package org.flashmonkey.java.ai.steering;

import com.jme.math.Quaternion;
import com.jme.math.Vector3f;

public class Kinematic extends Location 
{
	/**
	 * The linear velocity.
	 */
	public Vector3f velocity;

	/**
	 * The angular velocity.
	 */
	public double rotation;

	

	/**
	 * Creates a new Kinematic with the given position, orientation, velocity
	 * and rotational velocity.
	 * 
	 * @param position
	 *            The position of the Kinematic.
	 * @param orientation
	 *            The orientation of the Kinematic.
	 * @param velocity
	 *            The linear velocity of the Kinematic.
	 * @param rotation
	 *            The angular velocity of the Kinematic.
	 */
	public Kinematic(Vector3f position, Quaternion orientation,
			Vector3f velocity, double rotation) {
		super(position, orientation);

		this.velocity = velocity;
		this.rotation = rotation;
	}

	public Kinematic() {
		super();

		velocity = new Vector3f();
		rotation = 0.0;
	}

	/**
	 * Zeros the location and velocity of this Kinematic.
	 */
	public void clear() {
		super.clear();

		velocity.zero();
		rotation = 0.0;
	}

	/**
	 * Receive input from the client.
	 * 
	 * Check if this update is in order by checking the time stamp on it.
	 * 
	 * Update to current time using previous Input value.
	 * 
	 * Then update with this new Input value.
	 * 
	 * @param time
	 * @param input
	 */
	/*public void update(int time) {
		behaviour.update(time, this);
	}*/

	/**
	 * Checks that the given Kinematic is equal to this. Kinematics are equal if
	 * their locations, velocities and rotations are equal.
	 */
	public boolean equals(Kinematic other) {
		return position.equals(other.position)
				&& orientation == other.orientation
				&& velocity.equals(other.velocity)
				&& rotation == other.rotation;
	}

	/**
	 * Checks that the given Kinematic is less than this. A Kinematic is less
	 * than another Kinematic if its position along the x-axis is less than that
	 * of the other Kinematic.
	 */
	public boolean lessThan(Kinematic other) {
		return position.x < other.position.x;
	}

	/**
	 * Sets the value of this Kinematic to the given location. The velocity
	 * components of the Kinematic are left unchanged.
	 * 
	 * @param other
	 *            The Location to set the Kinematic to.
	 */
	public void copyLocation(Location other) {
		orientation = other.orientation;
		position = other.position.clone();
	}

	/**
	 * Copies (by assignment) all the attributes of the given Kinematic.
	 * 
	 * @param other
	 *            Reference to Kinematic to copy.
	 */
	public void copy(Kinematic other) {
		orientation = other.orientation;
		position = other.position.clone();
		velocity = other.velocity.clone();
		rotation = other.rotation;
	}

	/**
	 * Modifies the value of this Kinematic by adding the given Kinematic.
	 * Additions are performed by component.
	 */
	public void plusEquals(Kinematic other) {
		position = position.add(other.position);
		velocity = velocity.add(other.velocity);
		rotation += other.rotation;
		orientation = orientation.add(other.orientation);
	}

	/**
	 * Modifies the value of this Kinematic by subtracting the given Kinematic.
	 * Subtractions are performed by component.
	 */
	public void minusEquals(Kinematic other) {
		position = position.subtract(other.position);
		velocity = velocity.subtract(other.velocity);
		rotation -= other.rotation;
		orientation = orientation.subtract(other.orientation);
	}

	/**
	 * Scales the Kinematic by the given value. All components are scaled,
	 * including rotations and orientations, this is normally not what you want.
	 * To scale only the linear components, use the *= operator on the position
	 * and velocity components individually.
	 * 
	 * @param f
	 *            The scaling factor.
	 */
	public void timesEquals(float f) {
		position = position.mult(f);
		velocity = velocity.mult(f);
		rotation *= f;
		// orientation *= f;
	}

	/**
	 * Performs a forward Euler integration of the Kinematic for the given
	 * duration. This applies the Kinematic's velocity and rotation to its
	 * position and orientation.
	 * 
	 * \note All of the integrate methods in this class are designed to provide
	 * a simple mechanism for updating position. They are not a substitute for a
	 * full physics engine that can correctly resolve collisions and
	 * constraints.
	 * 
	 * @param duration
	 *            The number of simulation seconds to integrate over.
	 */
	// public function integrate(duration:Number):void
	// {
	// }
	/**
	 * Perfoms a forward Euler integration of the Kinematic for the given
	 * duration, applying the given acceleration. Because the integration is
	 * Euler, all the acceleration is applied to the velocity at the end of the
	 * time step.
	 * 
	 * \note All of the integrate methods in this class are designed to provide
	 * a simple mechanism for updating position. They are not a substitute for a
	 * full physics engine that can correctly resolve collisions and
	 * constraints.
	 * 
	 * @param steer
	 *            The acceleration to apply over the integration.
	 * @param duration
	 *            The number of simulation seconds to integrate over.
	 */
	// void integrate(const SteeringOutput& steer, real duration);
	/**
	 * Perfoms a forward Euler integration of the Kinematic for the given
	 * duration, applying the given acceleration and drag. Because the
	 * integration is Euler, all the acceleration is applied to the velocity at
	 * the end of the time step.
	 * 
	 * \note All of the integrate methods in this class are designed to provide
	 * a simple mechanism for updating position. They are not a substitute for a
	 * full physics engine that can correctly resolve collisions and
	 * constraints.
	 * 
	 * @param steer
	 *            The acceleration to apply over the integration.
	 * 
	 * @param drag
	 *            The isotropic drag to apply to both velocity and rotation.
	 *            This should be a value between 0 (complete drag) and 1 (no
	 *            drag).
	 * 
	 * @param duration
	 *            The number of simulation seconds to integrate over.
	 */
	// void integrate(const SteeringOutput& steer,
	// real drag, real duration);
	/**
	 * Perfoms a forward Euler integration of the Kinematic for the given
	 * duration, applying the given acceleration and drag. Because the
	 * integration is Euler, all the acceleration is applied to the velocity at
	 * the end of the time step.
	 * 
	 * \note All of the integrate methods in this class are designed to provide
	 * a simple mechanism for updating position. They are not a substitute for a
	 * full physics engine that can correctly resolve collisions and
	 * constraints.
	 * 
	 * @param steer
	 *            The acceleration to apply over the integration.
	 * 
	 * @param drag
	 *            The anisotropic drag to apply. The force component of the
	 *            SteeringOutput is interpreted as linear drag coefficients in
	 *            each direction, and torque component is interpreted as the
	 *            rotational drag.
	 * 
	 * @param duration
	 *            The number of simulation seconds to integrate over.
	 */
	// void integrate(const SteeringOutput& steer,
	// const SteeringOutput& drag,
	// real duration);
	/**
	 * Trims the speed of the kinematic to be no more than that given.
	 */
	public void trimMaxSpeed(float speed) {
		if (velocity.length() > speed) {
			velocity.normalize();
			velocity = velocity.mult(speed);
		}
	}

	/**
	 * Sets the orientation of this location so it points along its own velocity
	 * vector.
	 */
	public void setOrientationFromVelocity(Vector3f velocity) {
		// If we haven't got any velocity, then we can do nothing.
		if (velocity.lengthSquared() > 0) {
			orientation.w = (float) Math.atan2(velocity.x, velocity.z);
		}
	}

	/*public void setBehaviour(IAvatarBehaviour behaviour) {
		this.behaviour = behaviour;
	}*/
}
