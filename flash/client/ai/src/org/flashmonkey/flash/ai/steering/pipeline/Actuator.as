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
package org.flashmonkey.flash.ai.steering.pipeline 
{
	import org.flashmonkey.flash.ai.steering.Kinematic;
	import org.flashmonkey.flash.ai.steering.SteeringOutput;
	import org.flashmonkey.flash.utils.math.Vector3f;	

	/**
	 * Actuators generate forcess and torques that are required to
	 * achieve the current goal state from the current actor
	 * state. The default behaviour is to generate forces to move
	 * towards the goal and align the orientation with the goal
	 * kinematic, as well as adjust the target speed to match the goal
	 * kinematic. The goal velocity direction is ignored.
	 * 
	 * @author Trevor
	 */
	public class Actuator
	{
		/**
		 * Pointer to the SteerPipe class, where details about the
		 * actor and the goal are stored. This is set by the SteerPipe
		 * class when the actuator is added to it.
		 */
		public var steering : SteeringPipeline;

		/**
		 * The steering output which the actuator updates.
		 */
		protected var _steer : SteeringOutput;

		/**
		 * True if the steering output was created and should be
		 * destroyed by this instance.
		 */
		public var localSteer : Boolean;

		/**
		 * The maximum acceleration (as output in the steer member)
		 * that an agent is allowed to apply. Default is 1 distance
		 * unit per second per second.  It assumes the agent has a
		 * mass of 1 unit.
		 */
		public var maxAcceleration : Number;

		/**
		 * The maximum speed the agent is allowed to do.
		 * The default value is 1;
		 */
		public var maxSpeed : Number;

		/**
		 * The maximum angular acceleration (as output in the steer
		 * member) that an agent is allowed to apply. Default is 1
		 * radian per second per second.  It assumes the agent has a
		 * moment of inertia of 1 unit.
		 */
		public var maxAngular : Number;

		/**
		 * The maximum rotation the agent is allowed to do.
		 * The default value is 1;
		 */
		public var maxRotation : Number;

		/**
		 * Controls how aggressive the steering is at turning. The
		 * higher this value the sharper the turning will be. Allowed
		 * range [0, oo). Default value 1.
		 */
		public var angularSharpness : Number;

		/**
		 * Controls how aggressive the steering is. The higher this
		 * value the sharper the transition between accelerating and
		 * braking. Allowed range [0, oo). Default value 1.
		 */
		public var sharpness : Number;

		/**
		 * Creates a new actuator.
		 *
		 * @param steer Pointer to a steer object. If this is NULL
		 * then a default object will be created.
		 */
		public function Actuator(steer : SteeringOutput = null)
		{
			super( );
		}

		public function initialise() : void
		{
			localSteer = false; 
			maxAcceleration = 1;
			maxSpeed = 1; 
			maxAngular = 1; 
			maxRotation = 1;
			angularSharpness = 1;
			sharpness = 1;	
		}

		/**
		 * Sets the steer instance used to output steering actions to
		 * take. If the given steer is null or no steer is given, then
		 * a new local steer is used, otherwise the given steer is
		 * considered non-local.
		 */
		public function set steeringOutput(s : SteeringOutput) : void
		{
			if (localSteer) _steer;
        	
			if (s)
			{
				_steer = s;
				localSteer = false;
			}
	        else
			{
				_steer = new SteeringOutput( );
				localSteer = true;
			}	
		}

		/**
		 * Gets the current steering output.
		 */
		public function get steeringOutput() : SteeringOutput
		{
			return _steer;
		}

		/**
		 * Sets the steer force and torque to the values required to
		 * achieve the current goal.
		 */
		public function run() : void
		{
			var currentGoal : Kinematic = steering.currentGoal;
			var actor : Kinematic = steering.getActor( );
			// vector from current position to current goal
			var p2g : Vector3f = currentGoal.position; 
			p2g.subtractLocal( actor.position );
			var d2 : Number = p2g.lengthSquared();
			var maxAcceleration2 : Number = maxAcceleration * maxAcceleration;

			if (d2 > 0)
			{
				var d : Number = Math.sqrt( d2 );
				p2g.multLocalScalar( 1.0 / d ); 
				// p2g is now unit magnitude

				// vParallel and vNormal are component vectors of the
				// actor's velocity where vParallel is in the direction
				// from the actor towards the goal, and vNormal is normal
				// to vParallel.
				var vP : Number = actor.velocity.dot( p2g );
				var vParallel : Vector3f = p2g; 
				vParallel.multLocalScalar( vP );
				var vNormal : Vector3f = actor.velocity; 
				vNormal.subtractLocal( vParallel );

				// Apply centripetal linear equal to -vNormal
				_steer.linear = vNormal;
				_steer.linear.multLocalScalar( -1 );

				// Calculate the magnitude of propelling linear, after centripetal
				// linear is subtracted from maxAcceleration.
				var vN2 : Number = vNormal.lengthSquared();
				var fP2 : Number = maxAcceleration2 - vN2;

				// If the centripetal takes all our acceleration budget,
				// then just crop it.
				if (fP2 < 0) 
				{
					_steer.linear.multLocalScalar( maxAcceleration / Math.sqrt( vN2 ) );
				} 
				else 
				{
					// Calculate the braking/acceleration distance
					var gP : Number = currentGoal.velocity.dot( p2g );
					var brakingDistance : Number = (d * maxAcceleration * 2 + vP * vP - gP * gP) / maxAcceleration / 4;

					// apply a smoothing function around the speed summit
					p2g.multLocalScalar( SteeringUtils.squash( d - brakingDistance, Math.sqrt( fP2 ), sharpness ) );
					_steer.linear.addLocal( p2g );
				}
			}
        	else
			{   
				// if we are on target then adjust speed to match goal speed.
				_steer.linear = currentGoal.velocity;
				_steer.linear.subtractLocal( actor.velocity );
				var linear2 : Number = _steer.linear.lengthSquared();
				// If the linear is too big then crop it.
				if (linear2 > maxAcceleration2)
                _steer.linear.multLocalScalar( maxAcceleration / Math.sqrt( linear2 ) );
			}

			// Check if we are not breaking the speed limit
			if (steering.getSpeed( ) > maxSpeed)
			{
				var dp : Number = _steer.linear.dot( actor.velocity );
				if (dp > 0)
				{
					// remove the forward-pointing component of steer linear
					_steer.linear.subtractLocal( actor.velocity.multLocalScalar( (dp / steering.getSpeed2( )) ) );
				}
			}

			// Calculate the angle we need to turn to point us in the desired
			// direction.
			var dAngle : Number = SteeringUtils.smallestTurn( actor.orientation, currentGoal.orientation );

			// Calculate the angle we will turn through when accelerating to our
			// target rotation.
			var brakingAngle : Number = (Math.abs( dAngle ) * maxAngular * 2 + actor.rotation * actor.rotation - currentGoal.rotation * currentGoal.rotation) / maxAngular / 4;

			if(dAngle < 0) brakingAngle *= -1;

			// apply a smoothing function around the speed summit
			_steer.angular.w = SteeringUtils.squash( dAngle - brakingAngle, maxAngular, angularSharpness );

			// If we are rotating faster than we currently are allowed and
			// the new angular will make us accelerate even faster, then
			// set the angular to zero.
			if(Math.abs( actor.rotation ) >= maxRotation && actor.rotation * _steer.angular.w > 0)
			{
				_steer.angular.w = 0;
			}
		}
	}
}
