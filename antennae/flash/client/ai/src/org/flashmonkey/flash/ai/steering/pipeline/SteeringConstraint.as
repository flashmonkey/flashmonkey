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

	/**
	 * Constrains what the steering system can do in order to achieve
     * its goals. It is provided with the actor and goal (or subgoal,
     * if it has been decomposed), and can register a corrective
     * action that should be taken to avoid violating the constraint.
     * Constraints are intended to work only when installed in a
     * SteerPipe class.
     * 
     * @author Trevor
     */
	public class SteeringConstraint
	{
        /**
         * Pointer to the SteerPipe class, where details about the
         * actor and the goal are stored. This is set by the SteerPipe
         * class when the constraint is added to it.
         */
        public var steering:SteeringPipeline;

        /**
         * Steering constraints can be held in a list. This points to
         * the next item in the list.
         */
        public var next:SteeringConstraint;

        /**
         * True if the constraint is or is about about to be
         * violated. In such case the time member gives the time
         * remaining until the violation occurs and suggestedGoal
         * specifies the suggested evasive action.
         */
        public var violated : Boolean;

        /**
         * The suggested goal to head for to avoid violating this
         * constraint.  Subclasses should write to this variable each
         * time they receive their processing budget (through the run
         * function in the normal way).
         */
        public var suggestedGoal:Kinematic;

        /**
         * Time left until the constaint is violated, if no corrective
         * action is taken. If no constraint is detected then this
         * should be set to FLT_MAX or any value greater than
         * lookAheadTime. The constraint resolution algorithm in the
         * SteerPipe class picks the constraint with the highest
         * priority, then the lowest time.  Subclasses should write to
         * this variable each time this they receives their processing
         * budget (through the run function in the normal way).
         */
        public var time:Number;

        /**
         * The priority of this constraint. The constraint resolution
         * algorithm in the SteerPipe class picks the constraint with
         * the highest priority, then the lowest time (see above). The
         * default priority is zero.
         */
        public var priority:Number;

        /**
         * If this parameter is true then the constraint checks for
         * collisions in two stages: first with agent's path projected
         * along current velocity, up to the apex of the turning arc,
         * and second from the apex to the current goal. If the
         * parameter is false then the constraint checks for
         * collisions between the current position and the goal.  The
         * default value is true.
         */
        public var inertial:Boolean;

        /**
         * Creates a new constraint.
         */
        public function SteeringConstraint()
        {
        	super();
        }
        
        public function initialise():void
        {
        	violated = false;
            priority = 0; 
            inertial = true;
        }

        /**
         * Runs the constraint.
         */
        public function run():void
        {
        }
	}
}
