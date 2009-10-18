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
	import org.flashmonkey.flash.utils.math.Vector3f;	

	/**
	 * The steering system, uses a targeter, an actuator and an
	 * optional set of decomposers and constraints, to create steering
	 * outputs to guide an agent to its goal. See the user guide for a
	 * detailed discussion of the steering algorithm.
	 * 
	 * @author Trevor
	 */
	public class SteeringPipeline
	{
		/**
		 * The targeter used to generate the top level goal.
		 */
		protected var targeter : Targeter;

		/**
		 * True if the targeter was created and should be destroyed by
		 * this instance.
		 */
		protected var localTargeter : Boolean;

		/**
		 * The actor that is doing the steering.
		 */
		protected var actor : Kinematic;

		/**
		 * True if the actor was created by the constructor and should
		 * be destroyed by this instance.
		 */
		protected var localActor : Boolean;

		/**
		 * The actuator used for generating output
		 */
		protected var actuator : Actuator;

		/**
		 * True if the actuator was created by the constructor and
		 * should be destroyed by this instance.
		 */
		protected var localActuator : Boolean;

		/**
		 * A list of decomposers.
		 */
		protected var decomposers : Decomposer;

		/**
		 * A list of constraints.
		 */
		protected var constraints : SteeringConstraint;

		/**
		 * The current speed.
		 *
		 * The current speed, squared speed and orientation vector of
		 * the actor are recalculated at the beginning
		 * of each invocation of the run method, so that subcomponents
		 * do not need to perform the same calculations. If a subclass
		 * overrides the run method it must compute these values as
		 * well, as many standard constraints depend on them being up
		 * to date. The x and y components of the orientation vector
		 * are cosine and sine of the actor's orientation
		 * respectively; the z component is always zero.
		 */
		protected var speed : Number;

		/**
		 * The current speed squared.
		 *
		 * The current speed, squared speed and orientation vector of
		 * the actor are recalculated at the beginning
		 * of each invocation of the run method, so that subcomponents
		 * do not need to perform the same calculations. If a subclass
		 * overrides the run method it must compute these values as
		 * well, as many standard constraints depend on them being up
		 * to date. The x and y components of the orientation vector
		 * are cosine and sine of the actor's orientation
		 * respectively; the z component is always zero.
		 */
		protected var speed2 : Number;

		/**
		 * The current orientation vector.
		 *
		 * The current speed, squared speed and orientation vector of
		 * the actor are recalculated at the beginning
		 * of each invocation of the run method, so that subcomponents
		 * do not need to perform the same calculations. If a subclass
		 * overrides the run method it must compute these values as
		 * well, as many standard constraints depend on them being up
		 * to date. The x and y components of the orientation vector
		 * are cosine and sine of the actor's orientation
		 * respectively; the z component is always zero.
		 */
		protected var orientation : Vector3f;

		/**
		 * Called when constraints could not be resolved after a
		 * number of passes through the list. The maximum number of
		 * passes is specified by the relaxationSteps member
		 * variable. If in the last pass at least one constraint still
		 * triggers then this method is called as a special measure to
		 * resolve the deadlock. The default action is to do nothing,
		 * but the client application may for instance invoke a
		 * planner here.
		 */
		protected function constraintDeadlock() : void
		{
		}

		/**
		 * The current goal or subgoal being sought.
		 */
		public var currentGoal : Kinematic;

		/**
		 * The maximum number of passes through the constraint list.
		 * See the constraintDeadlock() method for more details.  The
		 * default value is 1.
		 */
		public var relaxationSteps : int;

		/**
		 * Creates a new steering system. If no targeter is given then
		 * the default targeter will create its own target at the
		 * origin, which will never change.
		 *
		 * @param targeter Pointer to a Targeter object generating
		 * targets for this steering object. If equal to NULL, a
		 * default Targeter is created.
		 *
		 * @param actor Pointer to a Kinematic object describing the
		 * agent being controlled. If equal to NULL, a default actor
		 * object is created.
		 *
		 * @param actuator Pointer to an Actuator object which
		 * generates output forces. If equal to NULL, a default
		 * inertial actuator is created.
		 */
		public function SteeringPipeline(targeter : Targeter = null, actor : Kinematic = null,
            actuator : Actuator = null)
		{
			super();
			
			setActor(actor);
			setTargeter(targeter);
			setActuator(actuator);
		}

		public function initialise() : void
		{
			localTargeter = false; 
			localActor = false;
			localActuator = false;
			relaxationSteps = 1;	
		}

		/**
		 * Destroys the steering system, along with any non-local
		 * components.
		 */
		public function destroy() : void
		{
		}

		/**
		 * Sets the actor to be the given kinematic. If the given
		 * kinematic is null or no kinematic is given, it creates a
		 * new, local, kinematic.  If the given kinematic is non null,
		 * it is considered non-local.
		 */
		public function setActor(a : Kinematic = null) : void
		{
			if (localActor) actor = null;

			if (a)
			{
				actor = a;
				localActor = false;
			}
	        else
			{
				actor = new Kinematic();
				localActor = true;
			}
			if (localTargeter) setTargeter(null);
		}

		/**
		 * Gets the current actor.
		 */
		public function getActor() : Kinematic
		{
			return actor;
		}

		/**
		 * Returns the current speed of the actor.
		 */
		public function getSpeed() : Number
		{
			return speed;
		}

		/**
		 * Returns the current squared speed of the actor.
		 */
		public function getSpeed2() : Number
		{
			return speed2;
		}

		/**
		 * Returns the current orientation of the actor as a
		 * normalised vector in the XY plane, i.e. x =
		 * cos(orientation), y = sin(orientation), and z = 0.
		 */
		public function getOrientation() : Vector3f
		{
			return orientation;
		}

		/**
		 * Sets the targeter used to generate top level goals. If no
		 * targeter is given, or the targeter is null, then a new
		 * targeter is created, otherwise the given targeter is
		 * considered to be non-local.
		 */
		public function setTargeter(t : Targeter = null) : void
		{
			if (localTargeter) targeter = null;
        
			if (t)
			{
				targeter = t;
				localTargeter = false;
			}
	        else
			{
				targeter = new Targeter(actor);
				localTargeter = true;
			}
	        
			targeter.steering = this;
		}

		public function getTargeter() : Targeter
		{
			return targeter;
		}

		/**
		 * Changes the current actuator.
		 */
		public function setActuator(a : Actuator = null) : void
		{
			if (localActuator) actuator = null;
			
			if (a)
			{
				actuator = a;
				localActuator = false;
			}
	        else
			{
				actuator = new Actuator();
				localActuator = true;
			}
			actuator.steering = this;
		}

		/**
		 * Returns the current actuator.
		 */
		public function getActuator() : Actuator
		{
			return actuator;
		}

		/**
		 * Adds the given decomposer to the steering pipeline.
		 */
		public function addDecomposer(d : Decomposer) : void
		{
			d.next = decomposers;
			decomposers = d;
			d.steering = this;
		}

		/**
		 * Adds the given constraint to the steering pipeline.
		 */
		public function addConstraint(c : SteeringConstraint) : void
		{
			c.next = constraints;
			constraints = c;
			c.steering = this;
		}

		/**
		 * Runs the steering system. When this function returns, the
		 * steering output can be retrieved from getSteeringOutput (or
		 * by holding a pointer to the steer structure in which it is
		 * written).
		 */
		public function run() : void
		{
			var v : Vector3f = actor.velocity;
			var speed2 : Number = v.lengthSquared();
			var speed : Number = Math.sqrt(speed2);
			orientation.x = Math.cos(actor.orientation);
			orientation.y = Math.sin(actor.orientation);
	
			targeter.run();
			currentGoal = targeter.getGoal();
	
			// run decomposers
			var decomp : Decomposer = decomposers;
			while (decomp)
			{
				decomp.run();
				decomp = decomp.next;
			}
	
			// Constraint satisfaction algorithm. Works by gradually expanding the
			// "no-go" angle in front of the actor.
			var leftGoal : Kinematic;
			var rightGoal : Kinematic = actor;
			var previousGoal : Kinematic = currentGoal;
	        
			var leftSine : Number = 0;
			var rightSine : Number = 0; 
			var currentSine : Number = 0;
			var priority : Number = 0;
	        
			while (true)
			{
				var violation : Boolean = false;
				var refinement : Boolean = false;
	            
				var constraint : SteeringConstraint = constraints;
	            
				while (constraint)
				{
					if (constraint.priority < priority) continue;
	                
					constraint.violated = false;
					constraint.run();
	                
					if (constraint.violated)
					{
						var sg : Kinematic = constraint.suggestedGoal;
						var w : Vector3f/* = Vector3f.vectorBetween(actor.position, sg.position)*/;
						var normFactor : Number = Math.sqrt((v.x * v.x + v.y * v.y) * (w.x * w.x + w.y * w.y));
						var sine : Number;
						var cosine : Number;
	                   	
						if (normFactor) 
						{
							sine = (v.x * w.y - v.y * w.x) / normFactor;
							cosine = (v.x * w.x + v.y * w.y) / normFactor;
						} 
	                    else 
						{
							sine = cosine = 0;
						}
	
						if (cosine < 0)
						{   
							// make the sine monotonic
							if (sine > 0) 
							{
								sine += 2 * (1 - sine);
							} 
	                        else 
							{
								sine -= 2 * (1 + sine);
							}
						}
	
						if (constraint.priority > priority)
						{   
							// ignore earlier constraints
							leftGoal.clear(); 
							rightGoal = actor;
							leftSine = rightSine = currentSine = 0;
							priority = constraint.priority;
						}
	
						if (sine > leftSine) 
						{
							leftSine = sine; 
							leftGoal = sg; 
							refinement = true;
						} 
	                    else if (sine < rightSine) 
						{
							rightSine = sine; 
							rightGoal = sg; 
							refinement = true;
						}
						violation = true;
					}
	
					constraint = constraint.next;
				}
				if (!violation) break;
	            
				if (refinement)
				{
					// Choose the smaller of the two no go angles for the
					// next pass.
					if (!rightSine || leftSine && leftSine < -rightSine)
					{
						currentGoal = leftGoal; 
						currentSine = leftSine;
					}
	                else
					{
						currentGoal = rightGoal; 
						currentSine = rightSine;
					}
					previousGoal = currentGoal;
					continue;
				}
	
				// If the goal hasn't changed some constraint must be
				// firing even though its suggested goal has already been
				// taken into account.
				if (currentGoal == previousGoal) break;
	
				// This side didn't yield a workable solution. Try the
				// other.  But first check if we haven't done that
				// already.
				if (-currentSine > leftSine || -currentSine < rightSine)
				{
					constraintDeadlock();
					break;
				}
	
				if (currentSine == leftSine)
				{
					currentGoal = rightGoal; 
					currentSine = rightSine;
				}
	            else
				{
					currentGoal = leftGoal; 
					currentSine = leftSine;
				}
			}
			actuator.run();
		}
	}
}
