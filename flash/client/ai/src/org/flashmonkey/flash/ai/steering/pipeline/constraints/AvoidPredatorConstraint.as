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
	import org.flashmonkey.flash.ai.steering.pipeline.SteeringUtils;
	import org.flashmonkey.flash.utils.math.Vector3f;	

	/**
	 * @author Trevor
	 */
	public class AvoidPredatorConstraint extends AvoidAgentConstraint
	{
		/**
		 * See AvoidAgentConstraint::calcResolution().
		 */
		override protected function calcResolution(actor : Kinematic, margin : Number,
                                    tOffset : Number = 0) : void
		{
			var currentGoal : Kinematic = steering.currentGoal;

			// Predator's position at approach time
			var prediction : Vector3f = agent.velocity; 
			prediction.multLocalScalar( time );
			prediction.addLocal( agent.position );
			suggestedGoal.position = prediction;
			suggestedGoal.position.subtractLocal( actor.position );

			// If the prediction is in front of the actor then we place
			// the suggested goal opposite the prediction w.r.t. our path.
			if (suggestedGoal.position.dot( actor.velocity ) > 0)
			{
				suggestedGoal.position = suggestedGoal.position.cross( actor.velocity );
				if (suggestedGoal.position.isZero( ))
                suggestedGoal.position = SteeringUtils.getNormal( actor.velocity );
				suggestedGoal.position = suggestedGoal.position.cross( actor.velocity );
				suggestedGoal.position.setMagnitude( margin * avoidScale );
				suggestedGoal.position += prediction;
			}

        // Otherwise we place it on the opposite side to the actor's
        // prediction.
        else
			{
				suggestedGoal.position = actor.velocity;
				suggestedGoal.position.multLocalScalar( time - tOffset );
				suggestedGoal.position.addLocal( actor.position );
				suggestedGoal.position.subtractLocal( prediction );
				if (suggestedGoal.position.isZero( ))
                suggestedGoal.position = SteeringUtils.getNormal( agent.velocity );
				suggestedGoal.position.setMagnitude( margin * avoidScale );
				suggestedGoal.position.addLocal( prediction );
			}
			suggestedGoal.velocity = suggestedGoal.position;
			suggestedGoal.velocity.subtractLocal( actor.position );
			suggestedGoal.velocity.setMagnitude( steering.getActuator( ).maxSpeed );
			suggestedGoal.orientation = Math.atan2( suggestedGoal.velocity.y, suggestedGoal.velocity.x );
		}

		/**
		 * The time which the constraint should look ahead for
		 * violations.
		 *
		 * Any violation which happens further ahead than this time
		 * will be ignored. The default value is 1.
		 */
		public var lookAheadTime : Number;

		/**
		 * Creates a new constraint to avoid the given predator.
		 */
		public function AvoidPredatorConstraint(predator : Kinematic = null)
		{
			super( predator );
		}

		override public function initialise() : void
		{
			super.initialise( );
        	
			lookAheadTime = 1;
		}

		/**
		 * Runs the constraint.
		 */
		override public function run() : void
		{
			var actor : Kinematic = steering.getActor( );
			var a2p : Vector3f;// = Vector3.vectorBetween( actor.position, agent.position );
			var margin : Number = Math.abs( a2p.length() - safetyMargin ) * distanceScale + safetyMargin;

			var pt1 : Kinematic;
			var pt2 : Kinematic;
   
			pt1 = pt2 = actor;
			time = SteeringUtils.timeToAgent( agent, new Kinematic( actor.position ), margin );
			if (time < lookAheadTime)
			{
				violated = true;
				calcResolution( actor, margin );
				return;
			}
			if (inertial)
			{
				var tOffset : Number = SteeringUtils.wayPoint( pt1, pt2, steering );
				time = SteeringUtils.timeToAgent( actor, agent, margin );
				if (time < tOffset)
				{
					violated = true;
					calcResolution( actor, margin );
				}
            	else
				{   
					// Move the agent forward by tOffset
					var pseudoAgent : Kinematic = new Kinematic( agent.velocity, NaN, agent.velocity );
					pseudoAgent.position.multLocalScalar( tOffset );
					pseudoAgent.position.addLocal( agent.position );
					time = SteeringUtils.timeToAgent( pt1, pseudoAgent, margin );
					if (time < pt1.position.distance( steering.currentGoal.position ) / steering.getSpeed( ))
					{
						violated = true;
						time += tOffset;
						calcResolution( pt1, margin, tOffset );
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
				time = SteeringUtils.timeToAgent( pt1, agent, margin );
				if (time < pt1.position.distance( steering.currentGoal.position ) / steering.getSpeed( ))
				{
					violated = true;
					calcResolution( pt1, margin );
				}
			}
		}
	}
}
