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
package org.flashmonkey.flash.ai.steering.behaviours 
{
	import org.flashmonkey.flash.ai.steering.SteeringBehaviour;
	import org.flashmonkey.flash.ai.steering.SteeringOutput;
	
	import org.papervision3d.core.math.Number3D;	

	/**
	 * @author Trevor
	 */
	public class Seek extends SteeringBehaviour 
	{
		/**
		 * The target may be any vector (i.e. it might be something
		 * that has no orientation, such as a point in space).
		 */
		public var target : Number3D;

		/**
		 * The maximum acceleration that can be used to reach the
		 * target.
		 */
		public var maxAcceleration : Number;

		/**
		 * Works out the desired steering and writes it into the given
		 * steering output structure.
		 */
		override public function getSteering(output : SteeringOutput) : void
		{
		}
	}
}
