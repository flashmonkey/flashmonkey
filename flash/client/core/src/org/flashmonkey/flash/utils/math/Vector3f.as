package org.flashmonkey.flash.utils.math
{
	import flash.utils.IDataInput;
	import flash.utils.IDataOutput;
	import flash.utils.IExternalizable;
	
	import org.as3commons.logging.ILogger;
	import org.as3commons.logging.LoggerFactory;
	
	/**
	 * <code>Vector3f</code> defines a Vector for a three float value tuple.
	 * <code>Vector3f</code> can represent any three dimensional value, such as a
	 * vertex, a normal, etc. Utility methods are also included to aid in
	 * mathematical calculations.
	 *
	 * @author Mark Powell
	 * @author Joshua Slack
	 */
	public class Vector3f implements IExternalizable
	{
	    private static var log:ILogger = LoggerFactory.getLogger("Vector3f");
	
		public static var ZERO:Vector3f = new Vector3f(0, 0, 0);
	
		public static var UNIT_X:Vector3f = new Vector3f(1, 0, 0);
		public static var UNIT_Y:Vector3f = new Vector3f(0, 1, 0);
	    public static var UNIT_Z:Vector3f = new Vector3f(0, 0, 1);
	    public static var UNIT_XYZ:Vector3f = new Vector3f(1, 1, 1);
	    
		/**
	     * the x value of the vector.
	     */
	    public var x:Number;
	
	    /**
	     * the y value of the vector.
	     */
	    public var y:Number;
	
	    /**
	     * the z value of the vector.
	     */
	    public var z:Number;
	
	    /**
	     * Constructor instantiates a new <code>Vector3f</code> with provides
	     * values.
	     *
	     * @param x
	     *            the x value of the vector.
	     * @param y
	     *            the y value of the vector.
	     * @param z
	     *            the z value of the vector.
	     */
	    public function Vector3f(x:Number = 0.0, y:Number = 0.0, z:Number = 0.0) {
	        this.x = x;
	        this.y = y;
	        this.z = z;
	    }
	
	    /**
	     * Constructor instantiates a new <code>Vector3f</code> that is a copy
	     * of the provided vector
	     * @param copy The Vector3f to copy
	     */
	    public function copyFrom(copy:Vector3f):void {
	        set(copy);
	    }
	
	    /**
	     * <code>set</code> sets the x,y,z values of the vector based on passed
	     * parameters.
	     *
	     * @param x
	     *            the x value of the vector.
	     * @param y
	     *            the y value of the vector.
	     * @param z
	     *            the z value of the vector.
	     * @return this vector
	     */
	    public function setComponents(x:Number, y:Number, z:Number):Vector3f {
	        this.x = x;
	        this.y = y;
	        this.z = z;
	        
	        return this;
	    }
	
	    /**
	     * <code>set</code> sets the x,y,z values of the vector by copying the
	     * supplied vector.
	     *
	     * @param vect
	     *            the vector to copy.
	     * @return this vector
	     */
	    public function set(vect:Vector3f):Vector3f {
	        this.x = vect.x;
	        this.y = vect.y;
	        this.z = vect.z;
	        return this;
	    }
	
	    /**
	     *
	     * <code>add</code> adds the values of a provided vector storing the
	     * values in the supplied vector.
	     *
	     * @param vec
	     *            the vector to add to this
	     * @param result
	     *            the vector to store the result in
	     * @return result returns the supplied result vector.
	     */
	    public function add(vec:Vector3f, result:Vector3f = null):Vector3f {
	        if (null == vec) {
	            log.warn("Provided vector is null, null returned.");
	            return null;
	        }
	        
	        if (result == null)
	        {
	        	result = new Vector3f();
	        }
	        
	        result.x = x + vec.x;
	        result.y = y + vec.y;
	        result.z = z + vec.z;
	        
	        return result;
	    }
	
	    /**
	     * <code>addLocal</code> adds a provided vector to this vector internally,
	     * and returns a handle to this vector for easy chaining of calls. If the
	     * provided vector is null, null is returned.
	     *
	     * @param vec
	     *            the vector to add to this vector.
	     * @return this
	     */
	    public function addLocal(vec:Vector3f):Vector3f {
	        if (null == vec) {
	            log.warn("Provided vector is null, null returned.");
	            return null;
	        }
	        x += vec.x;
	        y += vec.y;
	        z += vec.z;
	        return this;
	    }
	
	    /**
	     *
	     * <code>add</code> adds the provided values to this vector, creating a
	     * new vector that is then returned.
	     *
	     * @param addX
	     *            the x value to add.
	     * @param addY
	     *            the y value to add.
	     * @param addZ
	     *            the z value to add.
	     * @return the result vector.
	     */
	    public function addComponents(addX:Number, addY:Number, addZ:Number):Vector3f {
	        return new Vector3f(x + addX, y + addY, z + addZ);
	    }
	
	    /**
	     * <code>addLocal</code> adds the provided values to this vector
	     * internally, and returns a handle to this vector for easy chaining of
	     * calls.
	     *
	     * @param addX
	     *            value to add to x
	     * @param addY
	     *            value to add to y
	     * @param addZ
	     *            value to add to z
	     * @return this
	     */
	    public function addLocalComponents(addX:Number, addY:Number, addZ:Number):Vector3f {
	        x += addX;
	        y += addY;
	        z += addZ;
	        return this;
	    }
	
	    /**
	     *
	     * <code>scaleAdd</code> multiplies the given vector by a scalar then adds
	     * the given vector.
	     *
	     * @param scalar
	     *            the value to multiply this vector by.
	     * @param mult
	     *            the value to multiply the scalar by
	     * @param add
	     *            the value to add
	     */
	    public function scaleAdd(scalar:Number, add:Vector3f, mult:Vector3f = null ):void {
	    	if (mult == null)
	    	{
	    		mult = this;
	    	}
	    	
	        this.x = mult.x * scalar + add.x;
	        this.y = mult.y * scalar + add.y;
	        this.z = mult.z * scalar + add.z;
	    }
	
	    /**
	     *
	     * <code>dot</code> calculates the dot product of this vector with a
	     * provided vector. If the provided vector is null, 0 is returned.
	     *
	     * @param vec
	     *            the vector to dot with this vector.
	     * @return the resultant dot product of this vector and a given vector.
	     */
	    public function dot(vec:Vector3f):Number {
	        if (null == vec) {
	            log.warn("Provided vector is null, 0 returned.");
	            return 0;
	        }
	        return x * vec.x + y * vec.y + z * vec.z;
	    }
	
	    /**
	     * <code>cross</code> calculates the cross product of this vector with a
	     * parameter vector v.  The result is stored in <code>result</code>
	     *
	     * @param v
	     *            the vector to take the cross product of with this.
	     * @param result
	     *            the vector to store the cross product result.
	     * @return result, after recieving the cross product vector.
	     */
	    public function cross(other:Vector3f, result:Vector3f = null):Vector3f {
	        if (result == null) 
	        {
	        	result = new Vector3f();
	        }
	        
	        var resX:Number = ((y * other.z) - (z * other.y)); 
	        var resY:Number = ((z * other.x) - (x * other.z));
	        var resZ:Number = ((x * other.y) - (y * other.x));
	        result.setComponents(resX, resY, resZ);
	        return result;
	    }
	
	    /**
	     * <code>crossLocal</code> calculates the cross product of this vector
	     * with a parameter vector v.
	     *
	     * @param v
	     *            the vector to take the cross product of with this.
	     * @return this.
	     */
	    public function crossLocal(other:Vector3f):Vector3f {
	        var tempx:Number = ( y * other.z ) - ( z * other.y );
	        var tempy:Number = ( z * other.x ) - ( x * other.z );
	        z = (x * other.y) - (y * other.x);
	        x = tempx;
	        y = tempy;
	        return this;
	    }
	
	    /**
	     * <code>length</code> calculates the magnitude of this vector.
	     *
	     * @return the length or magnitude of the vector.
	     */
	    public function length():Number {
	        return Math.sqrt(lengthSquared());
	    }
	
	    /**
	     * <code>lengthSquared</code> calculates the squared value of the
	     * magnitude of the vector.
	     *
	     * @return the magnitude squared of the vector.
	     */
	    public function lengthSquared():Number {
	        return x * x + y * y + z * z;
	    }
	
	    /**
	     * <code>distanceSquared</code> calculates the distance squared between
	     * this vector and vector v.
	     *
	     * @param v the second vector to determine the distance squared.
	     * @return the distance squared between the two vectors.
	     */
	    public function distanceSquared(v:Vector3f):Number {
	        var dx:Number = x - v.x;
	        var dy:Number = y - v.y;
	        var dz:Number = z - v.z;
	        return (dx * dx + dy * dy + dz * dz);
	    }
	
	    /**
	     * <code>distance</code> calculates the distance between this vector and
	     * vector v.
	     *
	     * @param v the second vector to determine the distance.
	     * @return the distance between the two vectors.
	     */
	    public function distance(v:Vector3f):Number {
	        return Math.sqrt(distanceSquared(v));
	    }
	
	    /**
	     *
	     * <code>mult</code> multiplies this vector by a scalar. The resultant
	     * vector is supplied as the second parameter and returned.
	     *
	     * @param scalar the scalar to multiply this vector by.
	     * @param product the product to store the result in.
	     * @return product
	     */
	    public function multScalar(scalar:Number, product:Vector3f = null):Vector3f {
	        if (null == product) {
	            product = new Vector3f();
	        }
	
	        product.x = x * scalar;
	        product.y = y * scalar;
	        product.z = z * scalar;
	        
	        return product;
	    }
	
	    /**
	     * <code>multLocal</code> multiplies this vector by a scalar internally,
	     * and returns a handle to this vector for easy chaining of calls.
	     *
	     * @param scalar
	     *            the value to multiply this vector by.
	     * @return this
	     */
	    public function multLocalScalar(scalar:Number):Vector3f {
	        x *= scalar;
	        y *= scalar;
	        z *= scalar;
	        return this;
	    }
	
	    /**
	     * <code>multLocal</code> multiplies a provided vector to this vector
	     * internally, and returns a handle to this vector for easy chaining of
	     * calls. If the provided vector is null, null is returned.
	     *
	     * @param vec
	     *            the vector to mult to this vector.
	     * @return this
	     */
	    public function multLocalVector(vec:Vector3f):Vector3f {
	        if (null == vec) {
	            log.warn("Provided vector is null, null returned.");
	            return null;
	        }
	        x *= vec.x;
	        y *= vec.y;
	        z *= vec.z;
	        return this;
	    }
	
	
	    /**
	     * <code>multLocal</code> multiplies a provided vector to this vector
	     * internally, and returns a handle to this vector for easy chaining of
	     * calls. If the provided vector is null, null is returned.
	     *
	     * @param vec
	     *            the vector to mult to this vector.
	     * @return this
	     */
	    public function multVector(vec:Vector3f, store:Vector3f = null):Vector3f {
	        if (null == vec) {
	            log.warn("Provided vector is null, null returned.");
	            return null;
	        }
	        if (store == null) store = new Vector3f();
	        return store.setComponents(x * vec.x, y * vec.y, z * vec.z);
	    }	
	
	    /**
	     * <code>divide</code> divides the values of this vector by a scalar and
	     * returns the result. The values of this vector remain untouched.
	     *
	     * @param scalar
	     *            the value to divide this vectors attributes by.
	     * @return the result <code>Vector</code>.
	     */
	    public function divideScalar(scalar:Number):Vector3f {
	        scalar = 1/scalar;
	        return new Vector3f(x * scalar, y * scalar, z * scalar);
	    }
	
	    /**
	     * <code>divideLocal</code> divides this vector by a scalar internally,
	     * and returns a handle to this vector for easy chaining of calls. Dividing
	     * by zero will result in an exception.
	     *
	     * @param scalar
	     *            the value to divides this vector by.
	     * @return this
	     */
	    public function divideLocalScalar(scalar:Number):Vector3f {
	        scalar = 1/scalar;
	        x *= scalar;
	        y *= scalar;
	        z *= scalar;
	        return this;
	    }
	
	
	    /**
	     * <code>divide</code> divides the values of this vector by a scalar and
	     * returns the result. The values of this vector remain untouched.
	     *
	     * @param scalar
	     *            the value to divide this vectors attributes by.
	     * @return the result <code>Vector</code>.
	     */
	    public function divideVector(vec:Vector3f):Vector3f {
	        return new Vector3f(x / vec.x, y / vec.y, z / vec.z);
	    }
	
	    /**
	     * <code>divideLocal</code> divides this vector by a scalar internally,
	     * and returns a handle to this vector for easy chaining of calls. Dividing
	     * by zero will result in an exception.
	     *
	     * @param scalar
	     *            the value to divides this vector by.
	     * @return this
	     */
	    public function divideLocalVector(vec:Vector3f):Vector3f {
	        x /= vec.x;
	        y /= vec.y;
	        z /= vec.z;
	        return this;
	    }
	
	    /**
	     *
	     * <code>negate</code> returns the negative of this vector. All values are
	     * negated and set to a new vector.
	     *
	     * @return the negated vector.
	     */
	    public function negate():Vector3f {
	        return new Vector3f(-x, -y, -z);
	    }
	
	    /**
	     *
	     * <code>negateLocal</code> negates the internal values of this vector.
	     *
	     * @return this.
	     */
	    public function negateLocal():Vector3f {
	        x = -x;
	        y = -y;
	        z = -z;
	        return this;
	    }
	
	    /**
	     * <code>subtractLocal</code> subtracts a provided vector to this vector
	     * internally, and returns a handle to this vector for easy chaining of
	     * calls. If the provided vector is null, null is returned.
	     *
	     * @param vec
	     *            the vector to subtract
	     * @return this
	     */
	    public function subtractLocal(vec:Vector3f):Vector3f {
	        if (null == vec) {
	            log.warn("Provided vector is null, null returned.");
	            return null;
	        }
	        x -= vec.x;
	        y -= vec.y;
	        z -= vec.z;
	        return this;
	    }
	
	    /**
	     *
	     * <code>subtract</code>
	     *
	     * @param vec
	     *            the vector to subtract from this
	     * @param result
	     *            the vector to store the result in
	     * @return result
	     */
	    public function subtract(vec:Vector3f, result:Vector3f):Vector3f {
	        if(result == null) {
	            result = new Vector3f();
	        }
	        result.x = x - vec.x;
	        result.y = y - vec.y;
	        result.z = z - vec.z;
	        return result;
	    }
	
	    /**
	     *
	     * <code>subtract</code> subtracts the provided values from this vector,
	     * creating a new vector that is then returned.
	     *
	     * @param subtractX
	     *            the x value to subtract.
	     * @param subtractY
	     *            the y value to subtract.
	     * @param subtractZ
	     *            the z value to subtract.
	     * @return the result vector.
	     */
	    public function subtractComponents(subtractX:Number, subtractY:Number, subtractZ:Number):Vector3f {
	        return new Vector3f(x - subtractX, y - subtractY, z - subtractZ);
	    }
	
	    /**
	     * <code>subtractLocal</code> subtracts the provided values from this vector
	     * internally, and returns a handle to this vector for easy chaining of
	     * calls.
	     *
	     * @param subtractX
	     *            the x value to subtract.
	     * @param subtractY
	     *            the y value to subtract.
	     * @param subtractZ
	     *            the z value to subtract.
	     * @return this
	     */
	    public function subtractLocalComponents(subtractX:Number, subtractY:Number, subtractZ:Number):Vector3f {
	        x -= subtractX;
	        y -= subtractY;
	        z -= subtractZ;
	        return this;
	    }
	
	    /**
	     * <code>normalize</code> returns the unit vector of this vector.
	     *
	     * @return unit vector of this vector.
	     */
	    public function normalise():Vector3f {
	        var length:Number = length();
	        if (length != 0) {
	            return divideScalar(length);
	        }
	        
	        return divideScalar(1);        
	    }
	
	    /**
	     * <code>normalizeLocal</code> makes this vector into a unit vector of
	     * itself.
	     *
	     * @return this.
	     */
	    public function normaliseLocal():Vector3f {
	        var length:Number = length();
	        if (length != 0) {
	            return divideLocalScalar(length);
	        }
	        
	        return this;        
	    }
	
	    /**
	     * <code>zero</code> resets this vector's data to zero internally.
	     */
	    public function zero():void {
	        x = y = z = 0;
	    }
	
	    /**
	     * <code>angleBetween</code> returns (in radians) the angle between two vectors.
	     * It is assumed that both this vector and the given vector are unit vectors (iow, normalized).
	     * 
	     * @param otherVector a unit vector to find the angle against
	     * @return the angle in radians.
	     */
	    public function angleBetween(otherVector:Vector3f):Number {
	        var dotProduct:Number = dot(otherVector);
	        var angle:Number = Math.acos(dotProduct);
	        return angle;
	    }
	    
	    /**
	     * Sets this vector to the interpolation by changeAmnt from this to the finalVec
	     * this=(1-changeAmnt)*this + changeAmnt * finalVec
	     * @param finalVec The final vector to interpolate towards
	     * @param changeAmnt An amount between 0.0 - 1.0 representing a precentage
	     *  change from this towards finalVec
	     */
	    public function interpolate(finalVec:Vector3f, changeAmnt:Number, beginVec:Vector3f):void {
	    	if (beginVec == null) beginVec = this;
	        this.x=(1-changeAmnt)*beginVec.x + changeAmnt*finalVec.x;
	        this.y=(1-changeAmnt)*beginVec.y + changeAmnt*finalVec.y;
	        this.z=(1-changeAmnt)*beginVec.z + changeAmnt*finalVec.z;
	    }
	
	    /**
	     * Check a vector... if it is null or its floats are NaN or infinite,
	     * return false.  Else return true.
	     * @param vector the vector to check
	     * @return true or false as stated above.
	     */
	    public static function isValidVector(vector:Vector3f):Boolean {
	      if (vector == null) return false;
	      if (isNaN(vector.x) ||
	          isNaN(vector.y) ||
	          isNaN(vector.z)) return false;
	      return true;
	    }
	
	    public static function generateOrthonormalBasis(u:Vector3f, v:Vector3f, w:Vector3f):void {
	        w.normaliseLocal();
	        generateComplementBasis(u, v, w);
	    }
	
	    public static function generateComplementBasis(u:Vector3f, v:Vector3f,
	            w:Vector3f):void {
	        var fInvLength:Number;
	
	        if (Math.abs(w.x) >= Math.abs(w.y)) {
	            // w.x or w.z is the largest magnitude component, swap them
	            fInvLength = 1.0 / Math.sqrt(w.x * w.x + w.z * w.z);
	            u.x = -w.z * fInvLength;
	            u.y = 0.0;
	            u.z = +w.x * fInvLength;
	            v.x = w.y * u.z;
	            v.y = w.z * u.x - w.x * u.z;
	            v.z = -w.y * u.x;
	        } else {
	            // w.y or w.z is the largest magnitude component, swap them
	            fInvLength = 1.0 / Math.sqrt(w.y * w.y + w.z * w.z);
	            u.x = 0.0;
	            u.y = +w.z * fInvLength;
	            u.z = -w.y * fInvLength;
	            v.x = w.y * u.z - w.z * u.y;
	            v.y = -w.x * u.z;
	            v.z = w.x * u.y;
	        }
	    }
	
	    public function clone():Vector3f {
	        return new Vector3f(x, y, z);
	    }
	
	    /**
	     * Saves this Vector3f into the given float[] object.
	     * 
	     * @param floats
	     *            The float[] to take this Vector3f. If null, a new float[3] is
	     *            created.
	     * @return The array, with X, Y, Z float values in that order
	     */
	    public function toArray(floats:Array):Array {
	        if (floats == null) {
	            floats = new Array();
	        }
	        floats[0] = x;
	        floats[1] = y;
	        floats[2] = z;
	        return floats;
	    }
	
	    /**
	     * are these two vectors the same? they are is they both have the same x,y,
	     * and z values.
	     *
	     * @param o
	     *            the object to compare for equality
	     * @return true if they are equal
	     */
	    public function equals(o:Object):Boolean {
	        if (!(o is Vector3f)) { return false; }
	
	        if (this == o) { return true; }
	
	        var comp:Vector3f = Vector3f(o);
	        if (x != comp.x) return false;
	        if (y != comp.y) return false;
	        if (z != comp.z) return false;
	        return true;
	    }
	
	    /**
	     * <code>hashCode</code> returns a unique code for this vector object based
	     * on it's values. If two vectors are logically equivalent, they will return
	     * the same hash code value.
	     * @return the hash code value of this vector.
	     */
	    public function hashCode():int {
	        var hash:int = 37;
	        //hash += 37 * hash + Float.floatToIntBits(x);
	       // hash += 37 * hash + Float.floatToIntBits(y);
	       // hash += 37 * hash + Float.floatToIntBits(z);
	        return hash;
	    }
	
	    /**
	     * <code>toString</code> returns the string representation of this vector.
	     * The format is:
	     *
	     * org.jme.math.Vector3f [X=XX.XXXX, Y=YY.YYYY, Z=ZZ.ZZZZ]
	     *
	     * @return the string representation of this vector.
	     */
	    public function toString():String {
	        return "com.jme.math.Vector3f [X=" + x + ", Y=" + y + ", Z=" + z + "]";
	    }
	
	    public function getX():Number {
	        return x;
	    }
	
	    public function setX(x:Number):void {
	        this.x = x;
	    }
	
	    public function getY():Number {
	        return y;
	    }
	
	    public function setY(y:Number):void {
	        this.y = y;
	    }
	
	    public function getZ():Number {
	        return z;
	    }
	
	    public function setZ(z:Number):void {
	        this.z = z;
	    }
	    
	    /**
	     * @param index
	     * @return x value if index == 0, y value if index == 1 or z value if index ==
	     *         2
	     * @throws IllegalArgumentException
	     *             if index is not one of 0, 1, 2.
	     */
	    public function get(index:int):Number {
	        switch (index) {
	            case 0:
	                return x;
	            case 1:
	                return y;
	            case 2:
	                return z;
	        }
	        
	        return 0;
	    }
	    
	    /**
	     * @param index
	     *            which field index in this vector to set.
	     * @param value
	     *            to set to one of x, y or z.
	     * @throws IllegalArgumentException
	     *             if index is not one of 0, 1, 2.
	     */
	    public function setComponent(index:int, value:Number):void {
	        switch (index) {
	            case 0:
	                x = value;
	                return;
	            case 1:
	                y = value;
	                return;
	            case 2:
	                z = value;
	                return;
	        }
	    }
	    
	    public function isZero():Boolean
	    {
	   		return false;
	    }
	    
	   	public function setMagnitude(mag:Number):void 
	   	{
	   		
	   	}
	   	
	   	public function writeExternal(output:IDataOutput):void
		{
			trace(x + " " + y + " " + z);
			
			output.writeFloat(x);
			output.writeFloat(y);
			output.writeFloat(z);
		}

		public function readExternal(input:IDataInput):void
		{			
			x = input.readFloat();
			y = input.readFloat();
			z = input.readFloat();
		}
	}

}