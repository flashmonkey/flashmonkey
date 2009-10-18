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
	 * @author Trevor
	 */
	public class SteeringUtils 
	{
		public static var FLT_MAX : Number = 2000000;

		/**
		 * An inline function calculating the determinant of 3 column vectors.
		 */
		public static function det(v1 : Vector3f, v2 : Vector3f, v3 : Vector3f) : Number
		{
			return v1.x * v2.y * v3.z - v1.x * v3.y * v2.z - v2.x * v1.y * v3.z + v2.x * v3.y * v1.z + v3.x * v1.y * v2.z - v3.x * v2.y * v1.z;
		}

		/*
		 * Returns the distance of point p from line (g, v), where v is
		 * the orienting vector and g is a point on the line.
		 */
		public static function distanceFromLine(g : Vector3f, v : Vector3f, p : Vector3f) : Number
		{
			// Solution taken from http://mathworld.wolfram.com/
			var c : Vector3f = g; 
			c.subtractLocal( p );
			var t : Number = c.dot( v.divideScalar( v.lengthSquared() ) );
			var vt : Vector3f = v; 
			vt.multLocalScalar( t );
			c.addLocal( vt );
			return c.length();
		}

		/*
		 * Returns a vector perpendicular to the given vector. The rotation axis
		 * is arbitrary, i.e. it cannot be specified by the user.
		 */
		public static function getNormal(v : Vector3f, use3dRestitution : Boolean = true) : Vector3f
		{
			if (use3dRestitution)
			{
				if (!v.z) return new Vector3f( v.y, -v.x, 0 );
				if (!v.y) return new Vector3f( v.z, 0, -v.x );
				if (!v.x) return new Vector3f( 0, v.z, -v.y );
				return new Vector3f( -v.y * v.z * 2 / v.x, -v.z, -v.y );
			}
			return new Vector3f( v.y, -v.x, 0 );
		}

		/*
		Returns the point that:
		1. Lies on a plane perpendicular to line (g, v) and passing through
		point g.
		2. Lies in the same plane as the line and another point p.
		3. Lies at a distance r from point g.
		This routine is used during docking, when the actor is downstream
		from the goal.
		 */
		public static function getArchPoint(g : Vector3f, v : Vector3f,
	                                p : Vector3f, r : Number) : Vector3f
		{
			// The formula is:  g + d * r / |d|
			// where            d = v x c
			// where            c = (p - g) x v
			// where 'x' is the vector product
			var d : Vector3f; 
			var c : Vector3f = p; 
			c.subtractLocal( g ); 
			c = c.cross( v ); 
			if (c.isZero( )) d = getNormal( v );
	        else d = v.cross( c );
			d.multLocalScalar( r / d.length() );
			d.addLocal( g );
	
			return d;
		}

		/*
		 * Calculates the value of a custom squashing function. In order to avoid
		 * calculating the exponent function, we construct our squashing function
		 * by putting together two constant functions and a linear component in
		 * the middle.
		 * x is the value of the independent variable
		 * s is the squashing factor
		 * a is the tangent of the linear segment
		 * The function returns values between -s and +s, exluding +- s itself.
		 */
		public static function squash(x : Number, s : Number = 1, a : Number = 1) : Number
		{
			if (x > 0)
	            if (x < s / a) return a * x;
	            else return s;
	        else
	            if (x > -s / a) return a * x;
	            else return -s;
		}

		/*
		 * Finds the smallest angle we need to add to alpha
		 * to get the angle beta (or some 360^0 multiple of beta).
		 */
		public static function smallestTurn(alpha : Number, beta : Number) : Number
		{
			var M_2PI : Number = Math.PI * Math.PI;
			var f : Number = (beta - alpha) % M_2PI;
			if (f < -Math.PI) return f + M_2PI;
			if (f >= Math.PI) return f - M_2PI;
			return f;  
		}

		public static function intersection(k1 : Kinematic, k2 : Kinematic) : Vector3f
		{
			var v1 : Vector3f = k1.velocity;
			var v2 : Vector3f = k2.velocity;
	        
			v1.normalise( ); 
			v2.normalise( );
	        
			var v12 : Vector3f = v1; 
			v12 = v12.cross( v2 );
			var v12l : Number = v12.length();
			v12.multLocalScalar( 1 / v12l );
			var p : Vector3f;// = Vector3.vectorBetween( k1.position, k2.position );
			var t1 : Number = det( p, v2, v12 ) / v12l;
			var t2 : Number = det( p, v1, v12 ) / v12l;
			v1.multLocalScalar( t1 ); 
			v2.multLocalScalar( t2 );
			p = k1.position; 
			p += v1; 
			p += k2.position; 
			p += v2;
			p.multLocalScalar( 0.5 );
			return p;
		}

		public static function timeToAgent(actor : Kinematic, predator : Kinematic, safetyMargin : Number) : Number
		{
			var dp : Vector3f;// = Vector3.vectorBetween( actor.position, predator.position );
			var dv : Vector3f;// = Vector3.vectorBetween( predator.velocity, actor.velocity );
			var dp2 : Number = dp.lengthSquared();
			var dv2 : Number = dv.lengthSquared();
			var r2 : Number = safetyMargin * safetyMargin;
	        
			if (dv2 == 0)
	            if (dp2 < r2) return 0;
	            else return FLT_MAX;
			// Calculate the time of nearest approach
			var dpdv : Number = dp.dot( dv );
			var at : Number = dpdv / dv2;
			if (at <= 0)
	            if (dp2 < r2) return at;
	            else return FLT_MAX;
	
			if (dp2 <= r2) return 0;
	
			// Calculate the square of nearest the approach distance
			var dpdv2 : Number = dpdv * dpdv;
			var ad2 : Number = dp2 - dpdv2 / dv2;
			if (ad2 > r2) return FLT_MAX;
	
			// Actual time of collision
			if (r2 == 0) return at;
			var delta : Number = dpdv2 - dv2 * (dp2 - r2);
	
			// Numerical instability sometimes produces slightly negative deltas
			if (delta <= 0) return at;
			var t : Number = (dpdv - Math.sqrt( delta )) / dv2;
			//assert(t > 0);
			return t;
		}

		// Implementation based on quaternion algebra
		public static function rotate(p : Vector3f, cosa : Number, n : Vector3f) : void
		{
			//assert(n.magnitude() == 1);
			// Calculate quaternion q(cos(a/2), n * sin(a/2))
			var qr : Number = Math.sqrt( (1 + cosa) / 2 );
			var q : Vector3f = n; 
			q.multLocalScalar( Math.sqrt( (1 - cosa) / 2 ) );
			// calculate x = q * p
			var xr : Number = -q.x * p.x - q.y * p.y - q.z * p.z;
			var x : Vector3f = new Vector3f( qr * p.x + q.y * p.z - q.z * p.y, qr * p.y + q.z * p.x - q.x * p.z, qr * p.z + q.x * p.y - q.y * p.x );
			// calculate p = x * ~q, where ~q is the conjugate of q
			p.x = -xr * q.x + x.x * qr - x.y * q.z + x.z * q.y;
			p.y = -xr * q.y + x.y * qr - x.z * q.x + x.x * q.z;
			p.z = -xr * q.z + x.z * qr - x.x * q.y + x.y * q.x;
		}

		/**
		 * Approximates the turning arc by two linear sections for
		 * collision detection.  Returns the apex (midpoint) in the first
		 * argument, and if the agent is going too fast, the second
		 * argument is also filled with the projected end point.
		 *
		 * @param pt Pseudo target - Kinematic to write the apex of the
		 * turning arc.
		 *
		 * @param pg Pseudo goal - Kinematic to write the end point of the
		 * turning arc.
		 *
		 * @param steering the SteerPipe object which performs the
		 * calculation
		 *
		 * @returns the time after which the actor will theoretically
		 * reach the apex.
		 */
		static public function wayPoint(pt : Kinematic, pg : Kinematic, steering : SteeringPipeline) : Number
		{
			var a : Kinematic = steering.getActor( );
			var g : Kinematic = steering.currentGoal;
			var a2g : Vector3f;// = Vector3.vectorBetween( a.position, g.position );
			var stopTime : Number = 0;
        
			if (steering.getSpeed( ) && !a2g.isZero( ))
			{
				// Calculate component of actor's velocity perpendicular to a2g
				var vPara : Vector3f = a.velocity;
				vPara.multLocalScalar( vPara.dot( a2g.divideLocalScalar( steering.getSpeed( ) * a2g.length() ) ) );
				var vPerp : Vector3f;// = Vector3f.vectorBetween( vPara, a.velocity );

				// Calculate time required to reduce perpendicular
				// component of velocity to zero, assuming all
				// deceleration goes towards this.
				stopTime = vPerp.length() / steering.getActuator( ).maxAcceleration;

				// Calculate how far we will travel along actor's current
				// velocity vector in stopTime and hence set pseudoTarget
				// to this point.
				pt.position = a.velocity;
				pt.position.multLocalScalar( stopTime );
				pt.position += a.position;
			}
        	else 
			{
				pt.position = a.position;
			}
        	
			pt.velocity = g.position;
			pt.velocity.subtractLocal( pt.position );

			if (!pt.velocity.isZero( )) 			{
				pt.velocity.setMagnitude( steering.getSpeed( ) );
			}

			pg = g;
			return stopTime;
		}
	}
}
