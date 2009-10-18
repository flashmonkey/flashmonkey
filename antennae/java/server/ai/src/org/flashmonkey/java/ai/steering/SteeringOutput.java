/*
 * Part of the Artificial Intelligence for Games system.
 *
 * Copyright (c) Ian Millington 2003-2006. All Rights Reserved.
 *
 * This software is distributed under licence. Use of this software
 * implies agreement with all terms and conditions of the accompanying
 * software licence.
 * 
 * Java port - Trevor Burton [worldofpaper@googlemail.com]
 */
package org.flashmonkey.java.ai.steering;

import com.jme.math.Quaternion;
import com.jme.math.Vector3f;


/**
 * SteeringOutput is a movement requested by the steering system.
 * 
 * It consists of linear and angular components. The components may be
 * interpreted as forces and torques when output from a full dynamic steering
 * behaviour, or as velocity and rotation when output from a kinematic steering
 * behaviour. In the former case, neither force nor torque take account of mass,
 * and so should be thought of as linear and angular acceleration.
 */
public class SteeringOutput {
	/**
	 * The linear component of the steering action.
	 */
	public Vector3f linear;

	/**
	 * The angular component of the steering action.
	 */
	public Quaternion angular;

	/**
	 * Creates a new steering action with zero linear and angular changes.
	 */
	public SteeringOutput() {
		linear = new Vector3f();
		angular = new Quaternion();
	}

	/**
	 * Creates a new steering action with the given linear and angular changes.
	 * 
	 * @param linear
	 *            The initial linear change to give the SteeringOutput.
	 * 
	 * @param angular
	 *            The initial angular change to give the SteeringOutput.
	 */
	public SteeringOutput(Vector3f linear, Quaternion angular) {
		this.linear = linear;
		this.angular = angular;
	}

	/**
	 * Zeros the linear and angular changes of this steering action.
	 */
	public void clear() {
		linear.zero();
		angular.set(0, 0, 0, 1);
	}

	/**
	 * Checks that the given steering action is equal to this. SteeringOutputs
	 * are equal if their linear and angular changes are equal.
	 */
	public boolean equals(SteeringOutput other) {
		return linear == other.linear && angular == other.angular;
	}

	/**
	 * Checks that the given steering action is unequal to this. SteeringOutputs
	 * are unequal if either their linear or angular changes are unequal.
	 */
	public boolean notEquals(SteeringOutput other) {
		return linear != other.linear || angular != other.angular;
	}
}
