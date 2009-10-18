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
package org.flashmonkey.java.ai.steering;

import org.flashmonkey.java.input.api.IInput;


/**
 * The steering behaviour is the base class for all dynamic
 * steering behaviours.
 */
abstract public class AbstractSteeringBehaviour {
	/**
     * The character who is moving.
     */
    protected Kinematic character;
    
    protected IInput input;

    /**
     * Works out the desired steering and writes it into the given
     * steering output structure.
     */
    abstract public void getSteering(SteeringOutput output);
    
    abstract public void getSteering(SteeringOutput output, IInput input);
    
    public void setCharacter(Kinematic character) {
    	this.character = character;
    }
    
    public Kinematic getCharacter() {
    	return character;
    }
    
    public void setInput(IInput input) {
    	this.input = input;
    }
    
    public IInput getInput() {
    	return input;
    }
}
