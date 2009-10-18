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
package org.flashmonkey.flash.ai.sm 
{
	import org.flashmonkey.flash.core.action.Action;	
	
	/**
	 * The base transition is used for any kind of state machine. It
	 * doesn't force a representation for the states or their
	 * transitions, but does give values for the actions to be carried
	 * out and the triggering.
	 */
	public class BaseTransition 
	{
		/**
	     * Points to the next transition in the sequence. Transitions
	     * are arranged in a singly linked list.
	     */
	    public var next:BaseTransition;
	    
	    
	}
}
