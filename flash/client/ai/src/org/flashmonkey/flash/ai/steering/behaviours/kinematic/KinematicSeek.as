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
package org.flashmonkey.flash.ai.steering.behaviours.kinematic
{
	import org.flashmonkey.flash.ai.steering.SteeringOutput;		

	/**
	 * @author Trevor
	 */
	public class KinematicSeek extends TargetedKinematicMovement 
	{
		override public function getSteering(output : SteeringOutput) : void
		{
			// First work out the direction
			output.linear = target;
			output.linear.subtractLocal( character.position );

			// If there is no direction, do nothing
			if (output.linear.lengthSquared() > 0)
			{
				output.linear.normalise( );
				output.linear.multLocalScalar( maxSpeed );
			}
		}
	}
}
