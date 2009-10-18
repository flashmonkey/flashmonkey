package org.flashmonkey.flash.utils.math
{
	import org.flashmonkey.flash.utils.IRegisteredClass;
	
	import flash.utils.IDataInput;
	import flash.utils.IDataOutput;
	import flash.utils.IExternalizable;
	
	import org.as3commons.logging.ILogger;
	import org.as3commons.logging.LoggerFactory;
	
	/**
	 * <code>Quaternion</code> defines a single example of a more general class of
	 * hypercomplex numbers. Quaternions extends a rotation in three dimensions to a
	 * rotation in four dimensions. This avoids "gimbal lock" and allows for smooth
	 * continuous rotation.
	 * 
	 * <code>Quaternion</code> is defined by four floating point numbers: {x y z
	 * w}.
	 * 
	 * @author Mark Powell
	 * @author Joshua Slack
	 */
	public class Quaternion implements IExternalizable, IRegisteredClass
	{
	    private static var log:ILogger = LoggerFactory.getLogger("Quaternion");
		
		public static const HALF_PI:Number = Math.PI * 0.5;
		
	    public var x:Number;
	    public var y:Number;
	    public var z:Number;
	    public var w:Number;
	
	    /**
	     * Constructor instantiates a new <code>Quaternion</code> object
	     * initializing all values to zero, except w which is initialized to 1.
	     *
	     */
	    public function Quaternion(...args) {
	    	switch (args.length)
	    	{
	    		case 0:
	    			x = 0;
			        y = 0;
			        z = 0;
			        w = 1;
			        break;
			       
			    case 1:
			    	if (args[0] is Array)
			     	{
			     		//fromAngles(args[0] as Array);
			     	}
			     	else if (args[0] is Quaternion)
			     	{
			     		var q:Quaternion = args[0] as Quaternion;
			     		x = q.x;
			     		y = q.y;
			     		z = q.z;
			     		w = q.w
			     	}
			     	break;
			     
			     case 3:
			     	var q1:Quaternion = args[0] as Quaternion;
			     	var q2:Quaternion = args[1] as Quaternion;
			     	var interp:Number = Number(args[2]);
			     	//slerp(q1, q2, interp);
			     	break;
			     	
			     case 4:
			     	x = Number(args[0]);
			     	y = Number(args[1]);
			     	z = Number(args[2]);
			     	w = Number(args[3]);
			     	break;
			     	
			     default:
			     	break;
	    	}
	    }
		
	    /**
	     * sets the data in a <code>Quaternion</code> object from the given list
	     * of parameters.
	     *
	     * @param x
	     *            the x value of the quaternion.
	     * @param y
	     *            the y value of the quaternion.
	     * @param z
	     *            the z value of the quaternion.
	     * @param w
	     *            the w value of the quaternion.
	     */
	    public function setComponents(x:Number, y:Number, z:Number, w:Number):void {
	        this.x = x;
	        this.y = y;
	        this.z = z;
	        this.w = w;
	    }
	
	    /**
	     * Sets the data in this <code>Quaternion</code> object to be equal to the
	     * passed <code>Quaternion</code> object. The values are copied producing
	     * a new object.
	     *
	     * @param q
	     *            The Quaternion to copy values from.
	     * @return this for chaining
	     */
	    public function setQuaternion(q:Quaternion):Quaternion {
	        this.x = q.x;
	        this.y = q.y;
	        this.z = q.z;
	        this.w = q.w;
	        return this;
	    }
		
	    /**
	     * Sets this Quaternion to {0, 0, 0, 1}.  Same as calling set(0,0,0,1).
	     */
	    public function loadIdentity():void {
	        x = y = z = 0;
	        w = 1;
	    }
	    
	    /**
	     * @return true if this Quaternion is {0,0,0,1}
	     */
	    public function isIdentity():Boolean {
	        if (x == 0 && y == 0 && z == 0 && w == 1) 
	            return true;
	        else
	            return false;
	    }
	    
	    /**
	     * <code>fromAngles</code> builds a quaternion from the Euler rotation
	     * angles (y,r,p).
	     *
	     * @param angles
	     *            the Euler angles of rotation (in radians).
	     */
	    public function fromAnglesArray(angles:Array):Quaternion {
	        if (angles.length != 3)
	            throw new Error(
	                    "Angles array must have three elements");
	
	        return fromAngles(angles[0], angles[1], angles[2]);
	    }
	
		/**
		 * <code>fromAngles</code> builds a Quaternion from the Euler rotation
		 * angles (y,r,p). Note that we are applying in order: roll, pitch, yaw but
		 * we've ordered them in x, y, and z for convenience.
		 * See: http://www.euclideanspace.com/maths/geometry/rotations/conversions/eulerToQuaternion/index.htm
		 * 
		 * @param yaw
		 *            the Euler yaw of rotation (in radians). (aka Bank, often rot
		 *            around x)
		 * @param roll
		 *            the Euler roll of rotation (in radians). (aka Heading, often
		 *            rot around y)
		 * @param pitch
		 *            the Euler pitch of rotation (in radians). (aka Attitude, often
		 *            rot around z)
		 */
	    public function fromAngles(yaw:Number, roll:Number, pitch:Number):Quaternion {
	        var angle:Number;
	        var sinRoll:Number;
	        var sinPitch:Number;
	        var sinYaw:Number;
	        var cosRoll:Number;
	        var cosPitch:Number;
	        var cosYaw:Number;
	        angle = pitch * 0.5;
	        sinPitch = Math.sin(angle);
	        cosPitch = Math.cos(angle);
	        angle = roll * 0.5;
	        sinRoll = Math.sin(angle);
	        cosRoll = Math.cos(angle);
	        angle = yaw * 0.5;
	        sinYaw = Math.sin(angle);
	        cosYaw = Math.cos(angle);
	
	        // variables used to reduce multiplication calls.
	        var cosRollXcosPitch:Number = cosRoll * cosPitch;
	        var sinRollXsinPitch:Number = sinRoll * sinPitch;
	        var cosRollXsinPitch:Number = cosRoll * sinPitch;
	        var sinRollXcosPitch:Number = sinRoll * cosPitch;
	        
	        w = (cosRollXcosPitch * cosYaw - sinRollXsinPitch * sinYaw);
	        x = (cosRollXcosPitch * sinYaw + sinRollXsinPitch * cosYaw);
	        y = (sinRollXcosPitch * cosYaw + cosRollXsinPitch * sinYaw);
	        z = (cosRollXsinPitch * cosYaw - sinRollXcosPitch * sinYaw);
	        
	        normalise();
	        return this;
	    }
	    
	    /**
		 * <code>toAngles</code> returns this quaternion converted to Euler
		 * rotation angles (yaw,roll,pitch).<br/>
		 * See http://www.euclideanspace.com/maths/geometry/rotations/conversions/quaternionToEuler/index.htm
		 * 
		 * @param angles
		 *            the float[] in which the angles should be stored, or null if
		 *            you want a new float[] to be created
		 * @return the float[] in which the angles are stored.
		 */
		public function toAngles(angles:Array):Array {
			if (angles == null)
				angles = new Array(3);
			else if (angles.length != 3)
				throw new Error("Angles array must have three elements");
	
			var sqw:Number = w * w;
			var sqx:Number = x * x;
			var sqy:Number = y * y;
			var sqz:Number = z * z;
			var unit:Number = sqx + sqy + sqz + sqw; // if normalized is one, otherwise
												// is correction factor
			var test:Number = x * y + z * w;
			if (test > 0.499 * unit) { // singularity at north pole
				angles[1] = 2 * Math.atan2(x, w);
				angles[2] = HALF_PI;
				angles[0] = 0;
			} else if (test < -0.499 * unit) { // singularity at south pole
				angles[1] = -2 * Math.atan2(x, w);
				angles[2] = -HALF_PI;
				angles[0] = 0;
			} else {
				angles[1] = Math.atan2(2 * y * w - 2 * x * z, sqx - sqy - sqz + sqw); // roll or heading 
				angles[2] = Math.asin(2 * test / unit); // pitch or attitude
				angles[0] = Math.atan2(2 * x * w - 2 * y * z, -sqx + sqy - sqz + sqw); // yaw or bank
			}
			return angles;
		}
	
	    /**
		 * 
		 * <code>fromRotationMatrix</code> generates a quaternion from a supplied
		 * matrix. This matrix is assumed to be a rotational matrix.
		 * 
		 * @param matrix
		 *            the matrix that defines the rotation.
		 */
	    public function fromRotationMatrix(matrix:Matrix3f):Quaternion {
	        return fromRotationMatrixComponents(matrix.m00, matrix.m01, matrix.m02, matrix.m10,
	                matrix.m11, matrix.m12, matrix.m20, matrix.m21, matrix.m22);
	    }
	    
	    public function fromRotationMatrixComponents(m00:Number, m01:Number, m02:Number,
	            m10:Number, m11:Number, m12:Number,
	            m20:Number, m21:Number, m22:Number):Quaternion {
	        // Use the Graphics Gems code, from 
	        // ftp://ftp.cis.upenn.edu/pub/graphics/shoemake/quatut.ps.Z
	        // *NOT* the "Matrix and Quaternions FAQ", which has errors!
	        
	        // the trace is the sum of the diagonal elements; see
	        // http://mathworld.wolfram.com/MatrixTrace.html
	        var t:Number = m00 + m11 + m22;
			var s:Number;
			
	        // we protect the division by s by ensuring that s>=1
	        if (t >= 0) { // |w| >= .5
	            s = Math.sqrt(t+1); // |s|>=1 ...
	            w = 0.5 * s;
	            s = 0.5 / s;                 // so this division isn't bad
	            x = (m21 - m12) * s;
	            y = (m02 - m20) * s;
	            z = (m10 - m01) * s;
	        } else if ((m00 > m11) && (m00 > m22)) {
	            s = Math
	                    .sqrt(1.0 + m00 - m11 - m22); // |s|>=1
	            x = s * 0.5; // |x| >= .5
	            s = 0.5 / s;
	            y = (m10 + m01) * s;
	            z = (m02 + m20) * s;
	            w = (m21 - m12) * s;
	        } else if (m11 > m22) {
	            s = Math
	                    .sqrt(1.0 + m11 - m00 - m22); // |s|>=1
	            y = s * 0.5; // |y| >= .5
	            s = 0.5 / s;
	            x = (m10 + m01) * s;
	            z = (m21 + m12) * s;
	            w = (m02 - m20) * s;
	        } else {
	            s = Math
	                    .sqrt(1.0 + m22 - m00 - m11); // |s|>=1
	            z = s * 0.5; // |z| >= .5
	            s = 0.5 / s;
	            x = (m02 + m20) * s;
	            y = (m21 + m12) * s;
	            w = (m10 - m01) * s;
	        }
	        
	        return this;
	    }
	
	    /**
	     * <code>toRotationMatrix</code> converts this quaternion to a rotational
	     * matrix. The result is stored in result.
	     * 
	     * @param result
	     *            The Matrix3f to store the result in.
	     * @return the rotation matrix representation of this quaternion.
	     */
	    public function toRotationMatrix3(result:Matrix3f = null):Matrix3f {
			if (result == null) result = new Matrix3f();
	        var norm:Number = norm();
	        // we explicitly test norm against one here, saving a division
	        // at the cost of a test and branch.  Is it worth it?
	        var s:Number = (norm==1) ? 2 : (norm > 0) ? 2/norm : 0;
	        
	        // compute xs/ys/zs first to save 6 multiplications, since xs/ys/zs
	        // will be used 2-4 times each.
	        var xs:Number      = x * s;
	        var ys:Number      = y * s;
	        var zs:Number      = z * s;
	        var xx:Number      = x * xs;
	        var xy:Number      = x * ys;
	        var xz:Number      = x * zs;
	        var xw:Number      = w * xs;
	        var yy:Number      = y * ys;
	        var yz:Number      = y * zs;
	        var yw:Number      = w * ys;
	        var zz:Number      = z * zs;
	        var zw:Number      = w * zs;
	
	        // using s=2/norm (instead of 1/norm) saves 9 multiplications by 2 here
	        result.m00  = 1 - ( yy + zz );
	        result.m01  =     ( xy - zw );
	        result.m02  =     ( xz + yw );
	        result.m10  =     ( xy + zw );
	        result.m11  = 1 - ( xx + zz );
	        result.m12  =     ( yz - xw );
	        result.m20  =     ( xz - yw );
	        result.m21  =     ( yz + xw );
	        result.m22  = 1 - ( xx + yy );
	
	        return result;
	    }
	
	    /**
	     * <code>toRotationMatrix</code> converts this quaternion to a rotational
	     * matrix. The result is stored in result. 4th row and 4th column values are
	     * untouched. Note: the result is created from a normalized version of this quat.
	     * 
	     * @param result
	     *            The Matrix4f to store the result in.
	     * @return the rotation matrix representation of this quaternion.
	     */
	    public function toRotationMatrix4(result:Matrix4f):Matrix4f {
	
	        var norm:Number = norm();
	        // we explicitly test norm against one here, saving a division
	        // at the cost of a test and branch.  Is it worth it?
	        var s:Number = (norm==1) ? 2 : (norm > 0) ? 2/norm : 0;
	        
	        // compute xs/ys/zs first to save 6 multiplications, since xs/ys/zs
	        // will be used 2-4 times each.
	        var xs:Number      = x * s;
	        var ys:Number      = y * s;
	        var zs:Number      = z * s;
	        var xx:Number      = x * xs;
	        var xy:Number      = x * ys;
	        var xz:Number      = x * zs;
	        var xw:Number      = w * xs;
	        var yy:Number      = y * ys;
	        var yz:Number      = y * zs;
	        var yw:Number      = w * ys;
	        var zz:Number      = z * zs;
	        var zw:Number      = w * zs;
	
	        // using s=2/norm (instead of 1/norm) saves 9 multiplications by 2 here
	        result.m00  = 1 - ( yy + zz );
	        result.m01  =     ( xy - zw );
	        result.m02  =     ( xz + yw );
	        result.m10  =     ( xy + zw );
	        result.m11  = 1 - ( xx + zz );
	        result.m12  =     ( yz - xw );
	        result.m20  =     ( xz - yw );
	        result.m21  =     ( yz + xw );
	        result.m22  = 1 - ( xx + yy );
	
	        return result;
	    }
	
	    /**
	     * <code>getRotationColumn</code> returns one of three columns specified
	     * by the parameter. This column is returned as a <code>Vector3f</code>
	     * object.  The value is retrieved as if this quaternion was first normalized.
	     *
	     * @param i
	     *            the column to retrieve. Must be between 0 and 2.
	     * @param store
	     *            the vector object to store the result in. if null, a new one
	     *            is created.
	     * @return the column specified by the index.
	     */
	    public function getRotationColumn(i:int, store:Vector3f = null):Vector3f {
	        if (store == null)
	            store = new Vector3f();
	
	        var norm:Number = norm();
	        if (norm != 1.0) {
	            norm = Math.sqrt(1/norm);
	        }
	        
	        var xx:Number      = x * x * norm;
	        var xy:Number      = x * y * norm;
	        var xz:Number      = x * z * norm;
	        var xw:Number      = x * w * norm;
	        var yy:Number      = y * y * norm;
	        var yz:Number      = y * z * norm;
	        var yw:Number      = y * w * norm;
	        var zz:Number      = z * z * norm;
	        var zw:Number      = z * w * norm;
	        
	        switch (i) {
	            case 0:
	                store.x  = 1 - 2 * ( yy + zz );
	                store.y  =     2 * ( xy + zw );
	                store.z  =     2 * ( xz - yw );
	                break;
	            case 1:
	                store.x  =     2 * ( xy - zw );
	                store.y  = 1 - 2 * ( xx + zz );
	                store.z  =     2 * ( yz + xw );
	                break;
	            case 2:
	                store.x  =     2 * ( xz + yw );
	                store.y  =     2 * ( yz - xw );
	                store.z  = 1 - 2 * ( xx + yy );
	                break;
	            default:
	                log.warn("Invalid column index.");
	                throw new Error("Invalid column index. " + i);
	        }
	
	        return store;
	    }
	
	    /**
	     * <code>fromAngleAxis</code> sets this quaternion to the values specified
	     * by an angle and an axis of rotation. This method creates an object, so
	     * use fromAngleNormalAxis if your axis is already normalized.
	     *
	     * @param angle
	     *            the angle to rotate (in radians).
	     * @param axis
	     *            the axis of rotation.
	     * @return this quaternion
	     */
	    public function fromAngleAxis(angle:Number, axis:Vector3f):Quaternion {
	        var normAxis:Vector3f = axis.normalise();
	        fromAngleNormalAxis(angle, normAxis);
	        return this;
	    }
	
	    /**
	     * <code>fromAngleNormalAxis</code> sets this quaternion to the values
	     * specified by an angle and a normalized axis of rotation.
	     *
	     * @param angle
	     *            the angle to rotate (in radians).
	     * @param axis
	     *            the axis of rotation (already normalized).
	     */
	    public function fromAngleNormalAxis(angle:Number, axis:Vector3f):Quaternion {
	    	if (axis.x == 0 && axis.y == 0 && axis.z == 0) {
	    		loadIdentity();
	    	} else {
		        var halfAngle:Number = 0.5 * angle;
		        var sin:Number = Math.sin(halfAngle);
		        w = Math.cos(halfAngle);
		        x = sin * axis.x;
		        y = sin * axis.y;
		        z = sin * axis.z;
	    	}
	        return this;
	    }
	
	    /**
	     * <code>toAngleAxis</code> sets a given angle and axis to that
	     * represented by the current quaternion. The values are stored as
	     * following: The axis is provided as a parameter and built by the method,
	     * the angle is returned as a float.
	     *
	     * @param axisStore
	     *            the object we'll store the computed axis in.
	     * @return the angle of rotation in radians.
	     */
	    public function toAngleAxis(axisStore:Vector3f = null):Number {
	        var sqrLength:Number = x * x + y * y + z * z;
	        var angle:Number;
	        if (sqrLength == 0.0) {
	            angle = 0.0;
	            if (axisStore != null) {
	                axisStore.x = 1.0;
	                axisStore.y = 0.0;
	                axisStore.z = 0.0;
	            }
	        } else {
	            angle = (2.0 * Math.acos(w));
	            if (axisStore != null) {
	                var invLength:Number = (1.0 / Math.sqrt(sqrLength));
	                axisStore.x = x * invLength;
	                axisStore.y = y * invLength;
	                axisStore.z = z * invLength;
	            }
	        }
	
	        return angle;
	    }
	
	    /**
	     * <code>slerp</code> sets this quaternion's value as an interpolation
	     * between two other quaternions.
	     *
	     * @param q1
	     *            the first quaternion.
	     * @param q2
	     *            the second quaternion.
	     * @param t
	     *            the amount to interpolate between the two quaternions.
	     */
	    public function slerpFromTo(q1:Quaternion, q2:Quaternion, t:Number):Quaternion {
	        // Create a local quaternion to store the interpolated quaternion
	        if (q1.x == q2.x && q1.y == q2.y && q1.z == q2.z && q1.w == q2.w) {
	            setQuaternion(q1);
	            return this;
	        }
	
	        var result:Number = (q1.x * q2.x) + (q1.y * q2.y) + (q1.z * q2.z)
	                + (q1.w * q2.w);
	
	        if (result < 0.0) {
	            // Negate the second quaternion and the result of the dot product
	            q2.x = -q2.x;
	            q2.y = -q2.y;
	            q2.z = -q2.z;
	            q2.w = -q2.w;
	            result = -result;
	        }
	
	        // Set the first and second scale for the interpolation
	        var scale0:Number = 1 - t;
	        var scale1:Number = t;
	
	        // Check if the angle between the 2 quaternions was big enough to
	        // warrant such calculations
	        if ((1 - result) > 0.1) {// Get the angle between the 2 quaternions,
	            // and then store the sin() of that angle
	            var theta:Number = Math.acos(result);
	            var invSinTheta:Number = 1 / Math.sin(theta);
	
	            // Calculate the scale for q1 and q2, according to the angle and
	            // it's sine value
	            scale0 = Math.sin((1 - t) * theta) * invSinTheta;
	            scale1 = Math.sin((t * theta)) * invSinTheta;
	        }
	
	        // Calculate the x, y, z and w values for the quaternion by using a
	        // special
	        // form of linear interpolation for quaternions.
	        this.x = (scale0 * q1.x) + (scale1 * q2.x);
	        this.y = (scale0 * q1.y) + (scale1 * q2.y);
	        this.z = (scale0 * q1.z) + (scale1 * q2.z);
	        this.w = (scale0 * q1.w) + (scale1 * q2.w);
	
	        // Return the interpolated quaternion
	        return this;
	    }
	
	    /**
	     * Sets the values of this quaternion to the slerp from itself to q2 by
	     * changeAmnt
	     *
	     * @param q2
	     *            Final interpolation value
	     * @param changeAmnt
	     *            The amount diffrence
	     */
	    public function slerpTo(q2:Quaternion, changeAmnt:Number):void {
	        if (this.x == q2.x && this.y == q2.y && this.z == q2.z
	                && this.w == q2.w) {
	            return;
	        }
	
	        var result:Number = (this.x * q2.x) + (this.y * q2.y) + (this.z * q2.z)
	                + (this.w * q2.w);
	
	        if (result < 0.0) {
	            // Negate the second quaternion and the result of the dot product
	            q2.x = -q2.x;
	            q2.y = -q2.y;
	            q2.z = -q2.z;
	            q2.w = -q2.w;
	            result = -result;
	        }
	
	        // Set the first and second scale for the interpolation
	        var scale0:Number = 1 - changeAmnt;
	        var scale1:Number = changeAmnt;
	
	        // Check if the angle between the 2 quaternions was big enough to
	        // warrant such calculations
	        if ((1 - result) > 0.1) {
	            // Get the angle between the 2 quaternions, and then store the sin()
	            // of that angle
	            var theta:Number = Math.acos(result);
	            var invSinTheta:Number = 1 / Math.sin(theta);
	
	            // Calculate the scale for q1 and q2, according to the angle and
	            // it's sine value
	            scale0 = Math.sin((1 - changeAmnt) * theta) * invSinTheta;
	            scale1 = Math.sin((changeAmnt * theta)) * invSinTheta;
	        }
	
	        // Calculate the x, y, z and w values for the quaternion by using a
	        // special
	        // form of linear interpolation for quaternions.
	        this.x = (scale0 * this.x) + (scale1 * q2.x);
	        this.y = (scale0 * this.y) + (scale1 * q2.y);
	        this.z = (scale0 * this.z) + (scale1 * q2.z);
	        this.w = (scale0 * this.w) + (scale1 * q2.w);
	    }
	
	    /**
	     * <code>add</code> adds the values of this quaternion to those of the
	     * parameter quaternion. The result is returned as a new quaternion.
	     *
	     * @param q
	     *            the quaternion to add to this.
	     * @return the new quaternion.
	     */
	    public function add(q:Quaternion):Quaternion {
	        return new Quaternion(x + q.x, y + q.y, z + q.z, w + q.w);
	    }
	
	    /**
	     * <code>add</code> adds the values of this quaternion to those of the
	     * parameter quaternion. The result is stored in this Quaternion.
	     *
	     * @param q
	     *            the quaternion to add to this.
	     * @return This Quaternion after addition.
	     */
	    public function addLocal(q:Quaternion):Quaternion {
	        this.x += q.x;
	        this.y += q.y;
	        this.z += q.z;
	        this.w += q.w;
	        return this;
	    }
	
	    /**
	     * <code>subtract</code> subtracts the values of the parameter quaternion
	     * from those of this quaternion. The result is returned as a new
	     * quaternion.
	     *
	     * @param q
	     *            the quaternion to subtract from this.
	     * @return the new quaternion.
	     */
	    public function subtract(q:Quaternion):Quaternion {
	        return new Quaternion(x - q.x, y - q.y, z - q.z, w - q.w);
	    }
	
		/**
		 * <code>subtract</code> subtracts the values of the parameter quaternion
		 * from those of this quaternion. The result is stored in this Quaternion.
		 *
		 * @param q
		 *            the quaternion to subtract from this.
		 * @return This Quaternion after subtraction.
		 */
		public function subtractLocal(q:Quaternion):Quaternion {
			this.x -= q.x;
			this.y -= q.y;
			this.z -= q.z;
			this.w -= q.w;
			return this;
		}
	
	    /**
	     * <code>mult</code> multiplies this quaternion by a parameter quaternion.
	     * The result is returned as a new quaternion. It should be noted that
	     * quaternion multiplication is not cummulative so q * p != p * q.
	     *
	     * It IS safe for q and res to be the same object.
	     *
	     * @param q
	     *            the quaternion to multiply this quaternion by.
	     * @param res
	     *            the quaternion to store the result in.
	     * @return the new quaternion.
	     */
	    public function mult(q:Quaternion, res:Quaternion = null):Quaternion {
	        if (res == null)
	            res = new Quaternion();
	        var qw:Number = q.w;
	        var qx:Number = q.x;
	        var qy:Number = q.y;
	        var qz:Number = q.z;
	        res.x = x * qw + y * qz - z * qy + w * qx;
	        res.y = -x * qz + y * qw + z * qx + w * qy;
	        res.z = x * qy - y * qx + z * qw + w * qz;
	        res.w = -x * qx - y * qy - z * qz + w * qw;
	        return res;
	    }
	
	    /**
	     * <code>apply</code> multiplies this quaternion by a parameter matrix
	     * internally.
	     *
	     * @param matrix
	     *            the matrix to apply to this quaternion.
	     */
	    public function apply(matrix:Matrix3f):void {
	        var oldX:Number = x;
	        var oldY:Number = y;
	        var oldZ:Number = z;
	        var oldW:Number = w;
	        fromRotationMatrix(matrix);
	        var tempX:Number = x;
	        var tempY:Number = y;
	        var tempZ:Number = z;
	        var tempW:Number = w;
	
	        x = oldX * tempW + oldY * tempZ - oldZ * tempY + oldW * tempX;
	        y = -oldX * tempZ + oldY * tempW + oldZ * tempX + oldW * tempY;
	        z = oldX * tempY - oldY * tempX + oldZ * tempW + oldW * tempZ;
	        w = -oldX * tempX - oldY * tempY - oldZ * tempZ + oldW * tempW;
	    }
	
	    /**
	     *
	     * <code>fromAxes</code> creates a <code>Quaternion</code> that
	     * represents the coordinate system defined by three axes. These axes are
	     * assumed to be orthogonal and no error checking is applied. Thus, the user
	     * must insure that the three axes being provided indeed represents a proper
	     * right handed coordinate system.
	     *
	     * @param axis
	     *            the array containing the three vectors representing the
	     *            coordinate system.
	     */
	    public function fromAxesArray(axis:Array):Quaternion {
	        if (axis.length != 3)
	            throw new Error(
	                    "Axis array must have three elements");
	        return fromAxes(axis[0], axis[1], axis[2]);
	    }
	
	    /**
	     *
	     * <code>fromAxes</code> creates a <code>Quaternion</code> that
	     * represents the coordinate system defined by three axes. These axes are
	     * assumed to be orthogonal and no error checking is applied. Thus, the user
	     * must insure that the three axes being provided indeed represents a proper
	     * right handed coordinate system.
	     *
	     * @param xAxis vector representing the x-axis of the coordinate system.
	     * @param yAxis vector representing the y-axis of the coordinate system.
	     * @param zAxis vector representing the z-axis of the coordinate system.
	     */
	    public function fromAxes(xAxis:Vector3f, yAxis:Vector3f, zAxis:Vector3f):Quaternion {
	        return fromRotationMatrixComponents(xAxis.x, yAxis.x, zAxis.x, xAxis.y, yAxis.y,
	                zAxis.y, xAxis.z, yAxis.z, zAxis.z);
	    }
	
	    /**
	     *
	     * <code>toAxes</code> takes in an array of three vectors. Each vector
	     * corresponds to an axis of the coordinate system defined by the quaternion
	     * rotation.
	     *
	     * @param axis
	     *            the array of vectors to be filled.
	     */
	    public function toAxes(axis:Array):void {
	        var tempMat:Matrix3f = toRotationMatrix3();
	        axis[0] = tempMat.getColumn(0, axis[0]);
	        axis[1] = tempMat.getColumn(1, axis[1]);
	        axis[2] = tempMat.getColumn(2, axis[2]);
	    }
	
	    /**
	     * <code>mult</code> multiplies this quaternion by a parameter vector. The
	     * result is stored in the supplied vector
	     *
	     * @param v
	     *            the vector to multiply this quaternion by.
	     * @return v
	     */
	    public function multLocalVector(v:Vector3f):Vector3f {
	        var tempX:Number;
	        var tempY:Number;
	        tempX = w * w * v.x + 2 * y * w * v.z - 2 * z * w * v.y + x * x * v.x
	                + 2 * y * x * v.y + 2 * z * x * v.z - z * z * v.x - y * y * v.x;
	        tempY = 2 * x * y * v.x + y * y * v.y + 2 * z * y * v.z + 2 * w * z
	                * v.x - z * z * v.y + w * w * v.y - 2 * x * w * v.z - x * x
	                * v.y;
	        v.z = 2 * x * z * v.x + 2 * y * z * v.y + z * z * v.z - 2 * w * y * v.x
	                - y * y * v.z + 2 * w * x * v.y - x * x * v.z + w * w * v.z;
	        v.x = tempX;
	        v.y = tempY;
	        return v;
	    }
	
	    /**
	     * Multiplies this Quaternion by the supplied quaternion. The result is
	     * stored in this Quaternion, which is also returned for chaining. Similar
	     * to this *= q.
	     *
	     * @param q
	     *            The Quaternion to multiply this one by.
	     * @return This Quaternion, after multiplication.
	     */
	    public function multLocalQuaternion(q:Quaternion):Quaternion {
	        var x1:Number = x * q.w + y * q.z - z * q.y + w * q.x;
	        var y1:Number = -x * q.z + y * q.w + z * q.x + w * q.y;
	        var z1:Number = x * q.y - y * q.x + z * q.w + w * q.z;
	        w = -x * q.x - y * q.y - z * q.z + w * q.w;
	        x = x1;
	        y = y1;
	        z = z1;
	        return this;
	    }
	
	    /**
	     * Multiplies this Quaternion by the supplied quaternion. The result is
	     * stored in this Quaternion, which is also returned for chaining. Similar
	     * to this *= q.
	     *
	     * @param qx -
	     *            quat x value
	     * @param qy -
	     *            quat y value
	     * @param qz -
	     *            quat z value
	     * @param qw -
	     *            quat w value
	     *
	     * @return This Quaternion, after multiplication.
	     */
	    public function multLocalComponents(qx:Number, qy:Number, qz:Number, qw:Number):Quaternion {
	        var x1:Number = x * qw + y * qz - z * qy + w * qx;
	        var y1:Number = -x * qz + y * qw + z * qx + w * qy;
	        var z1:Number = x * qy - y * qx + z * qw + w * qz;
	        w = -x * qx - y * qy - z * qz + w * qw;
	        x = x1;
	        y = y1;
	        z = z1;
	        return this;
	    }
	
	    /**
	     * <code>mult</code> multiplies this quaternion by a parameter vector. The
	     * result is returned as a new vector.
	     * 
	     * @param v
	     *            the vector to multiply this quaternion by.
	     * @param store
	     *            the vector to store the result in. It IS safe for v and store
	     *            to be the same object.
	     * @return the result vector.
	     */
	    public function multVector(v:Vector3f, store:Vector3f = null):Vector3f {
	        if (store == null)
	            store = new Vector3f();
	        if (v.x == 0 && v.y == 0 && v.z == 0) {
	            store.setComponents(0, 0, 0);
	        } else {
	            var vx:Number = v.x;
	            var vy:Number = v.y; 
	            var vz:Number = v.z;
	            store.x = w * w * vx + 2 * y * w * vz - 2 * z * w * vy + x * x
	                    * vx + 2 * y * x * vy + 2 * z * x * vz - z * z * vx - y
	                    * y * vx;
	            store.y = 2 * x * y * vx + y * y * vy + 2 * z * y * vz + 2 * w
	                    * z * vx - z * z * vy + w * w * vy - 2 * x * w * vz - x
	                    * x * vy;
	            store.z = 2 * x * z * vx + 2 * y * z * vy + z * z * vz - 2 * w
	                    * y * vx - y * y * vz + 2 * w * x * vy - x * x * vz + w
	                    * w * vz;
	        }
	        return store;
	    }
	
	    /**
	     * <code>mult</code> multiplies this quaternion by a parameter scalar. The
	     * result is returned as a new quaternion.
	     *
	     * @param scalar
	     *            the quaternion to multiply this quaternion by.
	     * @return the new quaternion.
	     */
	    public function multScalar(scalar:Number):Quaternion {
	        return new Quaternion(scalar * x, scalar * y, scalar * z, scalar * w);
	    }
	
	    /**
	     * <code>mult</code> multiplies this quaternion by a parameter scalar. The
	     * result is stored locally.
	     *
	     * @param scalar
	     *            the quaternion to multiply this quaternion by.
	     * @return this.
	     */
	    public function multLocalScalar(scalar:Number):Quaternion {
	        w *= scalar;
	        x *= scalar;
	        y *= scalar;
	        z *= scalar;
	        return this;
	    }
	
	    /**
	     * <code>dot</code> calculates and returns the dot product of this
	     * quaternion with that of the parameter quaternion.
	     *
	     * @param q
	     *            the quaternion to calculate the dot product of.
	     * @return the dot product of this and the parameter quaternion.
	     */
	    public function dot(q:Quaternion):Number {
	        return w * q.w + x * q.x + y * q.y + z * q.z;
	    }
	
	    /**
	     * <code>norm</code> returns the norm of this quaternion. This is the dot
	     * product of this quaternion with itself.
	     *
	     * @return the norm of the quaternion.
	     */
	    public function norm():Number {
	        return w * w + x * x + y * y + z * z;
	    }
	
	    /**
	     * <code>normalize</code> normalizes the current <code>Quaternion</code>
	     */
	    public function normalise():void {
	        var n:Number = Math.sqrt(1 / norm());
	        x *= n;
	        y *= n;
	        z *= n;
	        w *= n;
	    }
	
	    /**
	     * <code>inverse</code> returns the inverse of this quaternion as a new
	     * quaternion. If this quaternion does not have an inverse (if its normal is
	     * 0 or less), then null is returned.
	     *
	     * @return the inverse of this quaternion or null if the inverse does not
	     *         exist.
	     */
	    public function inverse():Quaternion {
	        var norm:Number = norm();
	        if (norm > 0.0) {
	            var invNorm:Number = 1.0 / norm;
	            return new Quaternion(-x * invNorm, -y * invNorm, -z * invNorm, w
	                    * invNorm);
	        } 
	        // return an invalid result to flag the error
	        return null;        
	    }
	
	    /**
	     * <code>inverse</code> calculates the inverse of this quaternion and
	     * returns this quaternion after it is calculated. If this quaternion does
	     * not have an inverse (if it's norma is 0 or less), nothing happens
	     *
	     * @return the inverse of this quaternion
	     */
	    public function inverseLocal():Quaternion {
	        var norm:Number = norm();
	        if (norm > 0.0) {
	            var invNorm:Number = 1.0 / norm;
	            x *= -invNorm;
	            y *= -invNorm;
	            z *= -invNorm;
	            w *= invNorm;
	        }
	        return this;
	    }
	
	    /**
	     * <code>negate</code> inverts the values of the quaternion.
	     *
	     */
	    public function negate():void {
	        x *= -1;
	        y *= -1;
	        z *= -1;
	        w *= -1;
	    }
	
	    /**
	     *
	     * <code>toString</code> creates the string representation of this
	     * <code>Quaternion</code>. The values of the quaternion are displace (x,
	     * y, z, w), in the following manner: <br>
	     * com.jme.math.Quaternion: [x=1" y=2 z=3 w=1]
	     *
	     * @return the string representation of this object.
	     * @see java.lang.Object#toString()
	     */
	    public function toString():String {
	        return "com.jme.math.Quaternion: [x=" + x + " y=" + y + " z=" + z
	                + " w=" + w + "]";
	    }
	
	    /**
	     * <code>equals</code> determines if two quaternions are logically equal,
	     * that is, if the values of (x, y, z, w) are the same for both quaternions.
	     *
	     * @param o
	     *            the object to compare for equality
	     * @return true if they are equal, false otherwise.
	     */
	    public function equals(comp:Quaternion):Boolean {	
	        if (this == comp) {
	            return true;
	        }
	
	        if (x != comp.x) return false;
	        if (y != comp.y) return false;
	        if (z != comp.z) return false;
	        if (w != comp.w) return false;
	        return true;
	    }
	
	    /**
	     * 
	     * <code>hashCode</code> returns the hash code value as an integer and is
	     * supported for the benefit of hashing based collection classes such as
	     * Hashtable, HashMap, HashSet etc.
	     * 
	     * @return the hashcode for this instance of Quaternion.
	     * @see java.lang.Object#hashCode()
	     *//*
	    public int hashCode() {
	        int hash = 37;
	        hash = 37 * hash + Float.floatToIntBits(x);
	        hash = 37 * hash + Float.floatToIntBits(y);
	        hash = 37 * hash + Float.floatToIntBits(z);
	        hash = 37 * hash + Float.floatToIntBits(w);
	        return hash;
	
	    }*/
	
	    private static var tmpYaxis:Vector3f = new Vector3f();
	    private static var tmpZaxis:Vector3f = new Vector3f();
	    private static var tmpXaxis:Vector3f = new Vector3f();
	
	    /**
	     * <code>lookAt</code> is a convienence method for auto-setting the
	     * quaternion based on a direction and an up vector. It computes
	     * the rotation to transform the z-axis to point into 'direction'
	     * and the y-axis to 'up'.
	     *
	     * @param direction
	     *            where to look at in terms of local coordinates
	     * @param up
	     *            a vector indicating the local up direction.
	     *            (typically {0, 1, 0} in jME.)
	     */
	    public function lookAt(direction:Vector3f, up:Vector3f ):void {
	        tmpZaxis.set( direction ).normaliseLocal();
	        tmpXaxis.set( up ).crossLocal( direction ).normaliseLocal();
	        tmpYaxis.set( direction ).crossLocal( tmpXaxis ).normaliseLocal();
	        fromAxes( tmpXaxis, tmpYaxis, tmpZaxis );
	    }
	
	    /**
	     * FIXME: This seems to have singularity type issues with angle == 0, possibly others such as PI.
	     * @param store
	     *            A Quaternion to store our result in. If null, a new one is
	     *            created.
	     * @return The store quaternion (or a new Quaterion, if store is null) that
	     *         describes a rotation that would point you in the exact opposite
	     *         direction of this Quaternion.
	     */
	    public function opposite(store:Quaternion):Quaternion {
	        if (store == null)
	            store = new Quaternion();
	        
	        var axis:Vector3f = new Vector3f();
	        var angle:Number = toAngleAxis(axis);
	
	        store.fromAngleAxis(Math.PI + angle, axis);
	        return store;
	    }
	
	    /**
	     * @return This Quaternion, altered to describe a rotation that would point
	     *         you in the exact opposite direction of where it is pointing
	     *         currently.
	     */
	    public function oppositeLocal():Quaternion {
	        return opposite(this);
	    }

	    public function clone():Quaternion {
	        return new Quaternion(this);
	    }
	    
	    public function writeExternal(output:IDataOutput):void
		{
			output.writeFloat(x);
			output.writeFloat(y);
			output.writeFloat(z);
			output.writeFloat(w);
		}

		public function readExternal(input:IDataInput):void
		{			
			x = input.readFloat();
			y = input.readFloat();
			z = input.readFloat();
			w = input.readFloat();
		}
		
		public function get aliasName():String 
		{
			return "";
		}
	}
}