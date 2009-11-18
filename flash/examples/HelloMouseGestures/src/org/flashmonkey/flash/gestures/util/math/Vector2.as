package org.flashmonkey.flash.gestures.util.math
{	
	import flash.display.Graphics;						

	public class Vector2 
	{
		private var __x : Number;

		private var __y : Number;

		private var __normal : Vector2;

		private var __len : Number;

		private var bInvalidLen : Boolean;

		private var bInvalidNormal : Boolean;
		
		//private var logger : XrayLog = new XrayLog();

		/**
		 * constructor
		 * initializes x and y, invalidates length and normal
		 * @param    x Number
		 * @param    y Number
		 */
		public function Vector2(x : Number = 0, y : Number = 0)
		{
			__x = x;
			__y = y;
			bInvalidLen = true;
			bInvalidNormal = true;
		}

		public function destroy() : void 
		{
			__x = 0;
			__y = 0;
			if (__normal) 
			{
				__normal.destroy( );
				__normal = null; 
			}
			__len = 0;
			bInvalidLen = false;
			bInvalidNormal = false;
		}

		/**
		 * Updates this vectors' x and y values
		 * @param    x Number
		 * @param    y Number
		 */
		public function setVector(x : Number, y : Number) : void
		{
			__x = x;
			__y = y;
			bInvalidLen = true;
			bInvalidNormal = true;
		}

		public function clone() : Vector2
		{
			return new Vector2( x, y );	
		}

		//////////////////////////// operators //////////////////////////
	    
		/**
		 * Calculates the dot product of this vector and vetor v
		 * @param    v Vector
		 * @return   returns a new vector
		 */
		public function dot(v : Vector2) : Number
		{
			return x * v.x + y * v.y;
		}

		/**
		 * Calculates the cross product of this vector and number n
		 * @param    n Number
		 * @return   returns a new vector
		 */
		public function cross(n : Number) : Vector2
		{
			return new Vector2( x * n, y * n );
		}

		/**
		 * Adds vector v to  this vector
		 * @param    v Vector
		 * @return   returns a new vector
		 */
		public function plus(v : Vector2) : Vector2
		{
			return new Vector2( x + v.x, y + v.y );
		}

		public function mult(val : Number) : Vector2
		{
			return new Vector2(x*val, y*val);
		}
		
		public function div(val : Number) : Vector2
		{
			return new Vector2(x/val, y/val);
		}		
		
		public function copy(val : Vector2) : void
		{
			x = val.x;
			y = val.y;
		}

		/**
		 * Substracts vector v from this vector
		 * @param    v Vector
		 * @return   returns a new vector
		 */
		public function minus(v : Vector2) : Vector2
		{
			return new Vector2( x - v.x, y - v.y );
		}

		/**
		 * Returns inverted vector
		 * @return   returns a new vector
		 */
		public function getInverted() : Vector2
		{
			return new Vector2( -x, -y );
		}

		/**
		 * Returns a normalized version of this vector
		 * @return returns a new vector or null
		 */
		public function getNormalized() : Vector2
		{
			if (this.len == 0)
			{
				return null;
			} 
			else 
			{
				return new Vector2( __x / len, __y / len );
			}
		}

		/**
		 * Inverts this vector
		 * @return   nothing
		 */
		public function invert() : void
		{
			__x *= -1;
			__y *= -1;
			bInvalidNormal = true;
		}

		/**
		 * Normalizes this vector
		 * @return   nothing
		 */
		public function normalize() : void 
		{
			if (len == 0)
			{
				__x = 0;
				__y = 0;
			} 
			else 
			{
				__x /= len;
				__y /= len;
			}
			
			bInvalidLen = true;
		}  

		public function getAngle(other : Vector2) : Number
		{
			return Math.atan2( other.y - y, other.x - x );
		}

		public function reflect(n : Vector2) : Vector2
		{
			var d : Number = this.dot( n );
			return new Vector2( this.x - 2 * d * n.x, this.y - 2 * d * n.y );	
		}

		//////////////////////////// setters //////////////////////////
		public function set x(n : Number) : void
		{
			__x = n;
			bInvalidLen = true;
			bInvalidNormal = true;
		}

		public function set y(n : Number) : void
		{
			__y = n;
			bInvalidLen = true;
			bInvalidNormal = true;
		}

		public function scale(s : Number) : void
		{
			x *= s;
			y *= s;
		}

		public function returnScale(s : Number) : Vector2
		{
			return new Vector2( x * s, y * s );	
		}

		public function set magnitude(s : Number) : void
		{
			normalize( );
			scale( s );	
		}

		public function zero() : void
		{
			x = 0; y = 0;
		}
		
		//////////////////////////// getters //////////////////////////
		public function get x() : Number
		{
			return __x;
		}

		public function get y() : Number
		{
			return __y;
		}

		public function get normal() : Vector2
		{
			if (bInvalidNormal) updateNormal( );
			return __normal;
		}

		public function get len() : Number
		{
			if (bInvalidLen) updateLen( );
			return __len;
		}

		//////////////////////////// misc public functions //////////////////////////
		public function toString() : String 
		{
			return "Vector(" + __x + ", " + __y + ")";
		}

		/**
		 * Draws the vector, useful when debugging
		 * @param    mc MovieClip to draw onto
		 * @param    px start point x coordinate
		 * @param    py start point y coordinate
		 * @param    scale optional scale
		 * @param    col optional color
		 */
		public function drawAt(graphics : Graphics, px : Number, py : Number, scale : Number = 1, col : Number = 0xFF0000) : void
		{			
			var ex : Number, ey : Number;
			ex = px + this.__x * scale;
			ey = py + this.__y * scale;
			graphics.lineStyle( 5, col, 100 );

			graphics.moveTo( px, py );
			graphics.lineTo( ex, ey );
			// draw arrow
			var tmpVector : Vector2 = new Vector2( px, py ).plus( this.getNormalized( ).cross( this.len * scale - 6 ) );
			var nVector : Vector2 = this.normal;
			nVector.normalize( );
			nVector = nVector.cross( 4 );
			tmpVector = tmpVector.plus( nVector );
			graphics.moveTo( tmpVector.x, tmpVector.y );
			graphics.lineTo( ex, ey );
			tmpVector = tmpVector.plus( nVector.cross( -2 ) );
			graphics.lineTo( tmpVector.x, tmpVector.y );
		}

		//////////////////////////// private functions //////////////////////////
		private function updateLen() : void
		{
			__len = Math.sqrt( __x * __x + __y * __y );
			bInvalidLen = false;
		}

		private function updateNormal() : void
		{
			__normal = new Vector2( -__y / len, __x / len );
			bInvalidNormal = false;
		}
	}
}