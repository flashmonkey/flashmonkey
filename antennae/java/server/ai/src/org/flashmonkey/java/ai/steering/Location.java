package org.flashmonkey.java.ai.steering;

import com.jme.math.Quaternion;
import com.jme.math.Vector3f;

public class Location {

	/**
	 * The position in 3 space.
	 */
	public Vector3f position;

	/**
	 * The orientation, as a euler angle in radians around the positive y axis
	 * (i.e. up) from the positive z axis.
	 */
	public Quaternion orientation;

	/**
	 * Creates a location with the given position and orientation.
	 */
	public Location(Vector3f position, Quaternion orientation) {
		this.position = position;
		this.orientation = orientation;
	}

	public Location() {
		position = new Vector3f();
		orientation = new Quaternion();
	}

	/**
	 * Assignment operator.
	 */
	public void copy(Location other) {
		position = other.position;
		orientation = other.orientation;
	}

	/**
	 * Zeros the position and orientation.
	 */
	public void clear() {
		position.zero();
		orientation.set(0, 0, 0, 1);
	}

	/**
	 * Checks that the given location is equal to this. Locations are equal if
	 * their positions and orientations are equal.
	 */
	public boolean equals(Location other) {
		return position.equals(other.position)
				&& orientation == other.orientation;
	}

	/**
	 * Perfoms a forward Euler integration of the Kinematic for the given
	 * duration, applying the given steering velocity and rotation.
	 * 
	 * \note All of the integrate methods in this class are designed to provide
	 * a simple mechanism for updating position. They are not a substitute for a
	 * full physics engine that can correctly resolve collisions and
	 * constraints.
	 * 
	 * @param steer
	 *            The velocity to apply over the integration.
	 * 
	 * @param duration
	 *            The number of simulation seconds to integrate over.
	 */
	public void integrate(SteeringOutput steer, double duration) {
	}

	/**
	 * Sets the orientation of this location so it points along the given
	 * velocity vector.
	 */
	public void setOrientationFromVelocity(Vector3f velocity) {
		// If we haven't got any velocity, then we can do nothing.
		if (velocity.lengthSquared() > 0) {
			orientation.w = (float) Math.atan2(velocity.x, velocity.z);
		}
	}

	/**
	 * Returns a unit vector in the direction of the current orientation.
	 */
	public Vector3f getOrientationAsVector() {
		return new Vector3f((float) Math.sin(orientation.w), 0.0f, (float) Math
				.cos(orientation.w));
	}

}
