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
package org.flashmonkey.java.ai.collision;

import org.flashmonkey.java.ai.steering.Kinematic;

import com.jme.math.Vector3f;

/**
 * This class is an interface to a collision detector. It should be overridden
 * to implement a specific collision detector. A function needing a collision
 * detector should create an instance of this interface.
 */
public interface CollisionDetector {
	/**
	 * Interface to the collision detection engine. The user must provide it
	 * when instantiating some of the behaviours.
	 * 
	 * @param current
	 *            The current kinematic state of the agent
	 * @param target
	 *            The agent's target
	 * @param collisionPoint
	 *            A pointer to a structure into which the coordinates of the
	 *            collision point should be entered.
	 * @param collisionNormal
	 *            A pointer to a structure into which the vector normal to the
	 *            collision surface should be entered.
	 * 
	 * @return False if no collision is detected.
	 */
	public boolean detectCollisions(Kinematic current, Kinematic target,
			Vector3f collisionPoint, Vector3f collisionNormal);
}
