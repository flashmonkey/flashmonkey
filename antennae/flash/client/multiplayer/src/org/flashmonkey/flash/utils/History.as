/* --------------------------------------------------------------------------------------
 * PaperWorld3D - building better worlds
 * --------------------------------------------------------------------------------------
 * Real-Time Multi-User Application Framework for the Flash Platform.
 * --------------------------------------------------------------------------------------
 * Copyright (C) 2008 Trevor Burton [worldofpaper@googlemail.com]
 * --------------------------------------------------------------------------------------
 * 
 * This library is free software; you can redistribute it and/or modify it under the 
 * terms of the GNU Lesser General Public License as published by the Free Software 
 * Foundation; either version 2.1 of the License, or (at your option) any later version.
 *
 * This library is distributed in the hope that it will be useful, but WITHOUT ANY 
 * WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A 
 * PARTICULAR PURPOSE. See the GNU Lesser General Public License for more details.
 *
 * You should have received a copy of the GNU Lesser General Public License along with 
 * this library; if not, write to the Free Software Foundation, Inc., 59 Temple Place, 
 * Suite 330, Boston, MA 02111-1307 USA 
 * 
 * -------------------------------------------------------------------------------------- */
package org.flashmonkey.flash.utils
{
	import org.flashmonkey.flash.api.IInput;
	import org.flashmonkey.flash.api.IState;
	import org.flashmonkey.flash.api.multiplayer.ISynchronisedAvatar;
	
	import de.polygonal.ds.Iterator;
	import de.polygonal.ds.SLinkedList;
	
	import org.as3commons.logging.ILogger;
	import org.as3commons.logging.LoggerFactory;

	/**
	 * @author Trevor Burton [worldofpaper@googlemail.com]
	 */
	public class History
	{
		private static var logger:ILogger = LoggerFactory.getLogger("Paperworld");
				
		public var moves : SLinkedList = new CircularBuffer();

		public var importantMoves : SLinkedList = new CircularBuffer();

		public function History()
		{
			super( );
		}

		public function destroy() : void
		{
		}

		public function add(move : Move) : void
		{	
			// determine if important move
			var important : Boolean = true;

			if (moves.size > 0)
			{
				var previous : Move = moves.head.data;

				important = move.input.notEquals( previous.input );
			}
	
			if (important)
			{
	            importantMoves.prepend( move );
	  		}
	
			// add move to history
			moves.prepend( move );
		}

		public function correction(avatar : ISynchronisedAvatar, t : int, state : IState, input : IInput) : void
		{
			// discard out of date important moves 
			/*if (importantMoves.oldest( ))
			{
			while (importantMoves.oldest( ).time < t && !importantMoves.empty( ))
			importantMoves.remove( );
			}*/

			while (moves.size > 0 && Move(moves.tail.data).time < t)
			{
           		moves.removeHead();
   			}
			
			if (moves.size == 0)
			{
	            return;
	  		}
			trace("size " + moves.size);
			// compare correction state with move history state
			if (state.notEquals( Move(moves.tail.data).state ))
			{				
				//trace("states not equal");
				// discard corrected move
				moves.removeHead();
	
				// save current scene data
				var	savedInput : IInput = avatar.input.clone( );
	
				// rewind to correction and replay moves
				avatar.time = t;
				avatar.input = input;

				avatar.snap( state );

				avatar.replaying = true;
				
				var iterator:Iterator = moves.getIterator();
				
				while (iterator.hasNext())
				{
					var next : Move = Move(iterator.next());
					trace("updating at " + next.time);
					while (avatar.time < next.time)
					{
						avatar.update();
					}
					
					avatar.input = next.input;
					next.state = avatar.state;
				}
	
				/*var i : int = moves.tail;

				while (i != moves.head)
				{
					var next : Move = Move( moves.moves[i] );

					if (next)
					{						
						while (avatar.time < moves.moves[i].time)
						{
							avatar.update( );
						}
					
						avatar.input = moves.moves[i].input;
						moves.moves[i].state = avatar.state;
					}
					
					i++;
					if (i > 1000) i = 0;
				}*/

				//syncObject.update( );

				avatar.replaying = false;
	
				// restore saved input
				avatar.input = savedInput;
			}
		}

		public function importantMoveArray(array : Array) : void
		{
			array = importantMoves.toArray();
		}
	}
}
