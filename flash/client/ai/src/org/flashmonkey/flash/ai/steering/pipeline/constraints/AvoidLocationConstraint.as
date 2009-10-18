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
	public class AvoidLocationConstraint extends AvoidAgentConstraint 
	{
		/**
		 * See AvoidAgentConstraint::calcResolution().
		 */
		override protected function calcResolution(actor : Kinematic, margin : Number,
                                    tOffset : Number = 0) : void
		{
			var currentGoal : Kinematic = steering.currentGoal;
			suggestedGoal.position = agent.position;
			suggestedGoal.position.subtractLocal( actor.position );

			// Place the suggested goal opposite the prediction w.r.t. our path.
			suggestedGoal.position = suggestedGoal.position.cross( actor.velocity );
			if (suggestedGoal.position.isZero( ))
            suggestedGoal.position = SteeringUtils.getNormal( actor.velocity );
			suggestedGoal.position = suggestedGoal.position.cross( actor.velocity );
			suggestedGoal.position.setMagnitude( margin );
			suggestedGoal.position.addLocal( agent.position );
			suggestedGoal.velocity = suggestedGoal.position;
			suggestedGoal.velocity.subtractLocal( actor.position );
			suggestedGoal.velocity.setMagnitude( steering.getActuator( ).maxSpeed );
			suggestedGoal.orientation = Math.atan2( suggestedGoal.velocity.y, suggestedGoal.velocity.x );
		}

		/**
		 * Constructor.
		 */
		public function AvoidLocationConstraint(location : Kinematic = null)
		{
			super( location );
		}

		/**
		 * Runs the constraint.
		 */
		override public function run() : void
		{			
			var pt1 : Kinematic;
			var pt2 : Kinematic;
       
			var actor : Kinematic = steering.getActor( );
			var currentGoal : Kinematic = steering.currentGoal;
			var a2p : Vector3f = agent.position; 
			a2p.subtractLocal( actor.position );
			var margin : Number = Math.abs( a2p.length() - safetyMargin ) * distanceScale + safetyMargin;
			var location : Kinematic = new Kinematic( agent.position );
			if (inertial)
			{
				var tOffset : Number = SteeringUtils.wayPoint( pt1, pt2, steering );
				time = SteeringUtils.timeToAgent( actor, location, margin );
				if (time < tOffset)
				{
					violated = true;
					calcResolution( actor, safetyMargin );
				}
	            else
				{
					time = SteeringUtils.timeToAgent( pt1, location, margin );
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
				pt1 = actor;
				pt1.velocity = currentGoal.position;
				pt1.velocity.subtractLocal( pt1.position );
				pt1.velocity.setMagnitude( steering.getSpeed( ) );
				time = SteeringUtils.timeToAgent( pt1, location, margin );
				if (time < pt1.position.distance( steering.currentGoal.position ) / steering.getSpeed( ))
				{
					violated = true;
					calcResolution( pt1, margin );
				}
			}
		}
	}
}
