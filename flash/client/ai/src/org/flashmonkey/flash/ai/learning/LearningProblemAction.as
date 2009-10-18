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
package org.flashmonkey.flash.ai.learning 
{
	import org.flashmonkey.flash.core.action.Action;	
	
	/**
	 * An action moves between states of the problem. In our case we
	 * have an aicore::Action instance on board, but in your
	 * application it would be better to customise this class.
	 */
	public class LearningProblemAction
	{
		/** Holds the index number of this action. */
		public var index : int;

		/**
		 * An action that corresponds to this problem action. This
		 * could be used to actually cause a character to perform the
		 * real world correlate of this problem-specific action.
		 */
		public var action : Action;

		/**
		 * Actions can be returned as a linked list - this points to
		 * the next item in the list.
		 */
		public var next : LearningProblemAction;

		/**
		 * Retrieves the number of actions in the list.
		 */
		public function getCount() : int
		{
			if (!next) return 1;
        	else return next.getCount() + 1;	
		}

		/**
		 * Retrieves the action at the given position in the list
		 * (this item being at zero). If the position is beyond the
		 * end of the list then the end item is returned.
		 */
		public function getAtPositionInList(pos : int) : LearningProblemAction
		{
			if (pos <= 0 || !next) return this;
        	else return next.getAtPositionInList(pos - 1);	
		}

		public function destroy() : void
		{
			index = NaN;
			action.destroy();
			next.destroy();	
		}
	}
}
