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
package org.flashmonkey.java.ai.steering.behaviour;

import org.flashmonkey.java.ai.steering.AbstractSteeringBehaviour;
import org.flashmonkey.java.ai.steering.SteeringOutput;
import org.flashmonkey.java.input.api.IInput;

import com.jme.math.Vector3f;

/**
 * The seek steering behaviour takes a target and aims in the opposite direction
 * with maximum acceleration.
 */
public class Flee extends AbstractSteeringBehaviour
{
	/**
	 * The target may be any vector (i.e. it might be something that has no
	 * orientation, such as a point in space).
	 */
	public Vector3f	target;
	
	/**
	 * The maximum acceleration that can be used to reach the target.
	 */
	public float maxAcceleration;
	
	/**
	 * Works out the desired steering and writes it into the given steering
	 * output structure.
	 */
	public void getSteering(SteeringOutput output)
	{
		// First work out the direction
		output.linear = character.position;
		output.linear = output.linear.subtract(target);
		
		// If there is no direction, do nothing
		if (output.linear.lengthSquared() > 0)
		{
			output.linear.normalize();
			output.linear = output.linear.mult(maxAcceleration);
		}
	}

	@Override
	public void getSteering(SteeringOutput output, IInput input) {
		// TODO Auto-generated method stub
		
	}
}
