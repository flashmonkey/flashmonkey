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
	import de.polygonal.ds.SLinkedList;
	import de.polygonal.ds.SListNode;
	
	import org.as3commons.logging.ILogger;
	import org.as3commons.logging.LoggerFactory;	

	/**
	 * @author Trevor Burton [worldofpaper@googlemail.com]
	 */
	public class CircularBuffer extends SLinkedList
	{
		private static var logger:ILogger = LoggerFactory.getLogger("Paperworld");

		private var _maxSize:int;

		public function CircularBuffer(size:int = 1000)
		{
			super( );
			
			_maxSize = size;
		}
		
		override public function append(obj:*):SListNode
		{
			var result:SListNode = super.append(obj);
			
			validateSize();
			
			return result;
		}
		
		private function validateSize():void 
		{
			while (size > _maxSize)
			{
				removeTail();
			}
		}
	}
}
