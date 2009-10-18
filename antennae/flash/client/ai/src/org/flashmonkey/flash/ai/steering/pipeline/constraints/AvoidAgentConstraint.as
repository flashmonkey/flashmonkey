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
	import org.flashmonkey.flash.ai.steering.Kinematic;
	import org.flashmonkey.flash.ai.steering.pipeline.SteeringConstraint;
	import org.flashmonkey.flash.ai.steering.pipeline.SteeringUtils;
	import org.flashmonkey.flash.utils.math.Vector3f;	

	/**
	 * @author Trevor
	 */
	public class AvoidAgentConstraint extends SteeringConstraint 
	{
		/**
		 * The safetyMargin is increased by distance to agent scaled by
		 * this parameter, i.e. the actual margin used by the constraint
		 * is safetyMargin + |d - safetyMargin| * distanceScale.  The
		 * default value is 0.
		 */
		public var distanceScale : Number = .5;

		/**
		 * When it comes to generating the suggested goal, the margin
		 * adjusted by the distanceScale is scaled again by avoidScale.
		 */
		public var avoidScale : Number = 2;

		/**
		 * Function calculating the suggested goal when a collision is
		 * detected.
		 *
		 * @param actor The position and course from which collisions
		 * were probed.
		 *
		 * @param margin The current safety margin (can be different
		 * from safetyMargin)
		 *
		 * @param tOffset The time offset by which the actor has been
		 * moved before probing.
		 *
		 * The result is written directly to the suggestedGoal member
		 * variable.  The time member variable is not altered. The
		 * caller must set it to the appropriate value before calling
		 * this method.
		 */
		protected function calcResolution(actor : Kinematic, margin : Number,
                                    tOffset : Number = 0) : void
		{
			// Predator's position at nearest approach time
			var prediction : Vector3f = agent.velocity; 
			prediction.multLocalScalar( time );
			prediction.addLocal( agent.position );
			suggestedGoal.position = prediction;
			suggestedGoal.position.subtractLocal( actor.position );
	
			// If prediction is behind, place suggested goal on other side of us.
			if (suggestedGoal.position.dot( actor.velocity ) < 0) 
			{
				suggestedGoal.position.multLocalScalar( -1 );
			} 
			else 
			{
				// Otherwise place suggested goal on other side of our path.
				var sgl : Number = suggestedGoal.position.length();
				suggestedGoal.position = suggestedGoal.position.cross( actor.velocity );
				var sina : Number = suggestedGoal.position.length() / steering.getSpeed( ) / sgl;
	
				// But, if prediction is roughly ahead, turn right.
				if (Math.abs( sina ) < .1)
				{
					suggestedGoal.position = SteeringUtils.getNormal( actor.velocity );
				}
	            else 
				{
					suggestedGoal.position = suggestedGoal.position.cross( actor.velocity );
				}
			}
	
			suggestedGoal.position.setMagnitude( margin );
			suggestedGoal.position.addLocal( prediction );
			suggestedGoal.velocity = suggestedGoal.position;
			suggestedGoal.velocity.subtractLocal( actor.position );
			suggestedGoal.velocity.setMagnitude( steering.getActuator( ).maxSpeed );
			suggestedGoal.orientation = Math.atan2( suggestedGoal.velocity.y, suggestedGoal.velocity.x );
		}

		/**
		 * The agent being avoided. Can be changed freely at runtime.
		 */
		public var agent : Kinematic;

		/**
		 * The minimum distance from the location that the constraint
		 * will tolerate. This parameter can be changed freely at
		 * runtime. The default value is 1.
		 */
		public var safetyMargin : Number;

		/**
		 * Creates a new avoid agent constraint to avoid the given
		 * kinematic.
		 */
		public function AvoidAgentConstraint(agent : Kinematic = null)
		{
			super( );
        	
			this.agent = agent;                
		}

		override public function initialise() : void
		{
			super.initialise( );
        	
			safetyMargin = 1;
		}

		/**
		 * Runs the constraint.
		 */
		override public function run() : void
		{
			var actor : Kinematic = steering.getActor( );
	       
			var pt1 : Kinematic;
			var pt2 : Kinematic;
	       
			if (inertial)
			{
				var tOffset : Number = SteeringUtils.wayPoint( pt1, pt2, steering );
				time = SteeringUtils.timeToAgent( actor, agent, safetyMargin );
				if (time < tOffset)
				{
					violated = true;
					calcResolution( actor, safetyMargin );
				}
	            else
				{   					// Move the agent forward by tOffset
					var pseudoAgent : Kinematic = new Kinematic( agent.velocity, NaN, agent.velocity );
					pseudoAgent.position.multLocalScalar( tOffset );
					pseudoAgent.position.addLocal( agent.position );
					time = SteeringUtils.timeToAgent( pt1, pseudoAgent, safetyMargin );
					if (time < pt1.position.distance( steering.currentGoal.position ) / steering.getSpeed( ))
					{
						violated = true;
						time += tOffset;
						calcResolution( pt1, safetyMargin, tOffset );
					}
				}
			}
	        else
			{
				var currentGoal : Kinematic = steering.currentGoal;
				pt1 = actor;
				pt1.velocity = currentGoal.position;
				pt1.velocity.subtractLocal( pt1.position );
				pt1.velocity.setMagnitude( steering.getSpeed( ) );
				time = SteeringUtils.timeToAgent( pt1, agent, safetyMargin );
				if (time < pt1.position.distance( steering.currentGoal.position ) / steering.getSpeed( ))
				{
					violated = true;
					calcResolution( pt1, safetyMargin );
				}
			}
		}
	}
}
