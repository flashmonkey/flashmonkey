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
	/**
	 * Various utility methods kept here for convenience. 
	 * 
	 * @author Trevor Burton [worldofpaper@googlemail.com]
	 */
	public class Utilities 
	{
		/**
		 * Is the supplied object defined?
		 */
		public static function isDefined(v : *) : Boolean
		{
			return v != null && v != undefined;
		}

		/**
		 * Test whether the supplied value is an even number.
		 */
		public static function isEvenNumber(n : Number) : Boolean
		{
			return 0 == (n % 2);
		}	

		/**
		 * Test whether the supplied value is an odd number.
		 */
		public static function isOddNumber(n : Number) : Boolean
		{
			return 1 == (n % 2);
		}

		/**
		 * Mask the number field data so it is of constant length.
		 */
		public static function maskNumberData(numberData : Number, maskLength : Number, maskValue : String) : String
		{
			var remaining : Number = maskLength - numberData.toString( ).length;
			
			if (remaining > 0)
			{
				var mask : String = "";
				
				for (var i : Number = 0; i < remaining ; i++)
				{
					mask += maskValue;
				}
				
				return (mask + numberData);
			}
	
			return numberData.toString( );
		}	

		/**
		 * Time stamp.
		 */
		public static function getTimeStamp() : String
		{
			// Construct a new date object.
			var currentDate : Date = new Date( );
			
			/// Get and mask individual fields.
			var hours : String = maskNumberData( currentDate.getHours( ), 2, "0" );
			var minutes : String = maskNumberData( currentDate.getMinutes( ), 2, "0" );
			var seconds : String = maskNumberData( currentDate.getSeconds( ), 2, "0" );
			var milliseconds : String = maskNumberData( currentDate.getMilliseconds( ), 3, "0" );
			
			// Return the masked data.
			return hours + ":" + minutes + ":" + seconds + ":" + milliseconds;
		}	
	}	
}
