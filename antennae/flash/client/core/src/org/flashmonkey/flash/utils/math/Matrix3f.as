package org.flashmonkey.flash.utils.math
{
	import org.as3commons.logging.ILogger;
	import org.as3commons.logging.LoggerFactory;
	
	public class Matrix3f
	{
		private static var log:ILogger = LoggerFactory.getLogger("Matrix3f");
	
	    public var m00:Number
	    public var m01:Number;
	    public var m02:Number;
	    public var m10:Number; 
	    public var m11:Number; 
	    public var m12:Number;
	    public var m20:Number; 
	    public var m21:Number; 
	    public var m22:Number;
	
	    /**
	     * Constructor instantiates a new <code>Matrix3f</code> object. The
	     * initial values for the matrix is that of the identity matrix.
	     *  
	     */
	    public function Matrix3f(...args) {
	    	switch (args.length)
	    	{
	    		case 0:
	    			loadIdentity();
	    			break;
	    			
	    		case 1:
	    			if (args[0] is Matrix3f)
	    			{
	    				var other:Matrix3f = args[0] as Matrix3f;
	    				m00 = other.m00;
	        			m01 = other.m01;
				        m02 = other.m02;
				        m10 = other.m10;
				        m11 = other.m11;
				        m12 = other.m12;
				        m20 = other.m20;
				        m21 = other.m21;
				        m22 = other.m22;
	    			}
	    			break;
	    		
	    		case 9:
	    			m00 = Number(args[0]);
        			m01 = Number(args[0]);
			        m02 = Number(args[0]);
			        m10 = Number(args[0]);
			        m11 = Number(args[0]);
			        m12 = Number(args[0]);
			        m20 = Number(args[0]);
			        m21 = Number(args[0]);
			        m22 = Number(args[0]);
			        break;
			        
			    default:
			    	loadIdentity();
			    	break;
	    	}	        
	    }
	
	    /**
	     * <code>copy</code> transfers the contents of a given matrix to this
	     * matrix. If a null matrix is supplied, this matrix is set to the identity
	     * matrix.
	     * 
	     * @param matrix
	     *            the matrix to copy.
	     */
	    public function copy(matrix:Matrix3f):void {
	        if (null == matrix) {
	            loadIdentity();
	        } else {
	            m00 = matrix.m00;
	            m01 = matrix.m01;
	            m02 = matrix.m02;
	            m10 = matrix.m10;
	            m11 = matrix.m11;
	            m12 = matrix.m12;
	            m20 = matrix.m20;
	            m21 = matrix.m21;
	            m22 = matrix.m22;
	        }
	    }
	
	    /**
	     * <code>get</code> retrieves a value from the matrix at the given
	     * position. If the position is invalid a <code>JmeException</code> is
	     * thrown.
	     * 
	     * @param i
	     *            the row index.
	     * @param j
	     *            the colum index.
	     * @return the value at (i, j).
	     */
	    public function get(i:int, j:int):Number {
	        switch (i) {
	        case 0:
	            switch (j) {
	            case 0: return m00;
	            case 1: return m01;
	            case 2: return m02;
	            }
	        case 1:
	            switch (j) {
	            case 0: return m10;
	            case 1: return m11;
	            case 2: return m12;
	            }
	        case 2:
	            switch (j) {
	            case 0: return m20;
	            case 1: return m21;
	            case 2: return m22;
	            }
	        }
	
	        log.warn("Invalid matrix index.");
	        throw new Error("Invalid indices into matrix.");
	    }
	
	    /**
	     * <code>get(float[])</code> returns the matrix in row-major or column-major order.
	     *
	     * @param data
	     *      The array to return the data into. This array can be 9 or 16 floats in size.
	     *      Only the upper 3x3 are assigned to in the case of a 16 element array.
	     * @param rowMajor
	     *      True for row major storage in the array (translation in elements 3, 7, 11 for a 4x4),
	     *      false for column major (translation in elements 12, 13, 14 for a 4x4).
	     */
	    public function getFromArray(data:Array, rowMajor:Boolean):void {
	        if (data.length == 9) {
	            if (rowMajor) {
	                data[0] = m00;
	                data[1] = m01;
	                data[2] = m02;
	                data[3] = m10;
	                data[4] = m11;
	                data[5] = m12;
	                data[6] = m20;
	                data[7] = m21;
	                data[8] = m22;
	            }
	            else {
	                data[0] = m00;
	                data[1] = m10;
	                data[2] = m20;
	                data[3] = m01;
	                data[4] = m11;
	                data[5] = m21;
	                data[6] = m02;
	                data[7] = m12;
	                data[8] = m22;
	            }
	        }
	        else if (data.length == 16) {
	            if (rowMajor) {
	                data[0] = m00;
	                data[1] = m01;
	                data[2] = m02;
	                data[4] = m10;
	                data[5] = m11;
	                data[6] = m12;
	                data[8] = m20;
	                data[9] = m21;
	                data[10] = m22;
	            }
	            else {
	                data[0] = m00;
	                data[1] = m10;
	                data[2] = m20;
	                data[4] = m01;
	                data[5] = m11;
	                data[6] = m21;
	                data[8] = m02;
	                data[9] = m12;
	                data[10] = m22;
	            }
	        }
	        else {
	            throw new Error("Array size must be 9 or 16 in Matrix3f.get().");
	        }
	    }
		
	    /**
	     * <code>getColumn</code> returns one of three columns specified by the
	     * parameter. This column is returned as a <code>Vector3f</code> object.
	     * 
	     * @param i
	     *            the column to retrieve. Must be between 0 and 2.
	     * @param store
	     *            the vector object to store the result in. if null, a new one
	     *            is created.
	     * @return the column specified by the index.
	     */
	    public function getColumn(i:int, store:Vector3f = null):Vector3f {
	        if (store == null) store = new Vector3f();
	        switch (i) {
	        case 0:
	            store.x = m00;
	            store.y = m10;
	            store.z = m20;
	            break;
	        case 1:
	            store.x = m01;
	            store.y = m11;
	            store.z = m21;
	            break;
	        case 2:
	            store.x = m02;
	            store.y = m12;
	            store.z = m22;
	            break;
	        default:
	            log.warn("Invalid column index.");
	            throw new Error("Invalid column index. " + i);
	        }
	        return store;
	    }
	
	    /**
	     * <code>getRow</code> returns one of three rows as specified by the
	     * parameter. This row is returned as a <code>Vector3f</code> object.
	     * 
	     * @param i
	     *            the row to retrieve. Must be between 0 and 2.
	     * @param store
	     *            the vector object to store the result in. if null, a new one
	     *            is created.
	     * @return the row specified by the index.
	     */
	    public function getRow(i:int, store:Vector3f = null):Vector3f {
	        if (store == null) store = new Vector3f();
	        switch (i) {
	        case 0:
	            store.x = m00;
	            store.y = m01;
	            store.z = m02;
	            break;
	        case 1:
	            store.x = m10;
	            store.y = m11;
	            store.z = m12;
	            break;
	        case 2:
	            store.x = m20;
	            store.y = m21;
	            store.z = m22;
	            break;
	        default:
	            log.warn("Invalid row index.");
	            throw new Error("Invalid row index. " + i);
	        }
	        return store;
	    }
	
	    /**
	     * <code>toFloatBuffer</code> returns a FloatBuffer object that contains
	     * the matrix data.
	     * 
	     * @return matrix data as a FloatBuffer.
	     *//*
	    public FloatBuffer toFloatBuffer() {
	        FloatBuffer fb = BufferUtils.createFloatBuffer(9);
	
	        fb.put(m00).put(m01).put(m02);
	        fb.put(m10).put(m11).put(m12);
	        fb.put(m20).put(m21).put(m22);
	        fb.rewind();
	        return fb;
	    }*/
	
	    /**
	     * <code>fillFloatBuffer</code> fills a FloatBuffer object with the matrix
	     * data.
	     * 
	     * @param fb
	     *            the buffer to fill, starting at current position. Must have
	     *            room for 9 more floats.
	     * @return matrix data as a FloatBuffer. (position is advanced by 9 and any
	     *         limit set is not changed).
	     *//*
	    public FloatBuffer fillFloatBuffer(FloatBuffer fb) {
	        fb.put(m00).put(m01).put(m02);
	        fb.put(m10).put(m11).put(m12);
	        fb.put(m20).put(m21).put(m22);
	        return fb;
	    }*/
	
	    /**
	     * 
	     * <code>setColumn</code> sets a particular column of this matrix to that
	     * represented by the provided vector.
	     * 
	     * @param i
	     *            the column to set.
	     * @param column
	     *            the data to set.
	     */
	    public function setColumn(i:int, column:Vector3f):void {
	
	        if (column == null) {
	            log.warn("Column is null. Ignoring.");
	            return;
	        }
	        switch (i) {
	        case 0:
	            m00 = column.x;
	            m10 = column.y;
	            m20 = column.z;
	            break;
	        case 1:
	            m01 = column.x;
	            m11 = column.y;
	            m21 = column.z;
	            break;
	        case 2:
	            m02 = column.x;
	            m12 = column.y;
	            m22 = column.z;
	            break;
	        default:
	            log.warn("Invalid column index.");
	            throw new Error("Invalid column index. " + i);
	        }
	    }
	
	
	    /**
	     * 
	     * <code>setRow</code> sets a particular row of this matrix to that
	     * represented by the provided vector.
	     * 
	     * @param i
	     *            the row to set.
	     * @param row
	     *            the data to set.
	     */
	    public function setRow(i:int, row:Vector3f):void {
	
	        if (row == null) {
	            log.warn("Row is null. Ignoring.");
	            return;
	        }
	        switch (i) {
	        case 0:
	            m00 = row.x;
	            m01 = row.y;
	            m02 = row.z;
	            break;
	        case 1:
	            m10 = row.x;
	            m11 = row.y;
	            m12 = row.z;
	            break;
	        case 2:
	            m20 = row.x;
	            m21 = row.y;
	            m22 = row.z;
	            break;
	        default:
	            log.warn("Invalid row index.");
	            throw new Error("Invalid row index. " + i);
	        }
	    }
	
	    /**
	     * <code>set</code> places a given value into the matrix at the given
	     * position. If the position is invalid a <code>JmeException</code> is
	     * thrown.
	     * 
	     * @param i
	     *            the row index.
	     * @param j
	     *            the colum index.
	     * @param value
	     *            the value for (i, j).
	     */
	    public function set(i:int, j:int, value:Number):void {
	        switch (i) {
	        case 0:
	            switch (j) {
	            case 0: m00 = value; return;
	            case 1: m01 = value; return;
	            case 2: m02 = value; return;
	            }
	        case 1:
	            switch (j) {
	            case 0: m10 = value; return;
	            case 1: m11 = value; return;
	            case 2: m12 = value; return;
	            }
	        case 2:
	            switch (j) {
	            case 0: m20 = value; return;
	            case 1: m21 = value; return;
	            case 2: m22 = value; return;
	            }
	        }
	
	        log.warn("Invalid matrix index.");
	        throw new Error("Invalid indices into matrix.");
	    }
	
	    /**
	     * 
	     * <code>set</code> sets the values of the matrix to those supplied by the
	     * 3x3 two dimenion array.
	     * 
	     * @param matrix
	     *            the new values of the matrix.
	     * @throws JmeException
	     *             if the array is not of size 9.
	     */
	    public function setFromMatrix(matrix:Array):void {
	        if (matrix.length != 3 || matrix[0].length != 3) { throw new Error(
	        "Array must be of size 9."); }
	
	        m00 = matrix[0][0];
	        m01 = matrix[0][1];
	        m02 = matrix[0][2];
	        m10 = matrix[1][0];
	        m11 = matrix[1][1];
	        m12 = matrix[1][2];
	        m20 = matrix[2][0];
	        m21 = matrix[2][1];
	        m22 = matrix[2][2];
	    }
	
	    /**
	     * Recreate Matrix using the provided axis.
	     * 
	     * @param uAxis
	     *            Vector3f
	     * @param vAxis
	     *            Vector3f
	     * @param wAxis
	     *            Vector3f
	     */
	    public function fromAxes(uAxis:Vector3f, vAxis:Vector3f, wAxis:Vector3f):void {
	        m00 = uAxis.x;
	        m10 = uAxis.y;
	        m20 = uAxis.z;
	
	        m01 = vAxis.x;
	        m11 = vAxis.y;
	        m21 = vAxis.z;
	
	        m02 = wAxis.x;
	        m12 = wAxis.y;
	        m22 = wAxis.z;
	    }
	
	    	
	    /**
	     * <code>set</code> sets the values of this matrix from an array of
	     * values;
	     * 
	     * @param matrix
	     *            the matrix to set the value to.
	     * @param rowMajor
	     *            whether the incoming data is in row or column major order.
	     */
	    public function setFromArray(matrix:Array, rowMajor:Boolean = true):void {
	        if (matrix.length != 9) throw new Error(
	                "Array must be of size 9.");
	
	        if (rowMajor) {
		        m00 = matrix[0];
		        m01 = matrix[1];
		        m02 = matrix[2];
		        m10 = matrix[3];
		        m11 = matrix[4];
		        m12 = matrix[5];
		        m20 = matrix[6];
		        m21 = matrix[7];
		        m22 = matrix[8];
	        } else {
		        m00 = matrix[0];
		        m01 = matrix[3];
		        m02 = matrix[6];
		        m10 = matrix[1];
		        m11 = matrix[4];
		        m12 = matrix[7];
		        m20 = matrix[2];
		        m21 = matrix[5];
		        m22 = matrix[8];
	        }
	    }
	
	    /**
	     * 
	     * <code>set</code> defines the values of the matrix based on a supplied
	     * <code>Quaternion</code>. It should be noted that all previous values
	     * will be overridden.
	     * 
	     * @param quaternion
	     *            the quaternion to create a rotational matrix from.
	     */
	    public function setFromQuaternion(quaternion:Quaternion):void {
	        quaternion.toRotationMatrix3(this);
	    }
	
	    /**
	     * <code>loadIdentity</code> sets this matrix to the identity matrix.
	     * Where all values are zero except those along the diagonal which are one.
	     *  
	     */
	    public function loadIdentity():void {
	        m01 = m02 = m10 = m12 = m20 = m21 = 0;
	        m00 = m11 = m22 = 1;
	    }
	
	    /**
	     * @return true if this matrix is identity
	     */
	    public function isIdentity():Boolean {
	        return (m00 == 1 && m01 == 0 && m02 == 0) &&
	        (m10 == 0 && m11 == 1 && m12 == 0) &&
	        (m20 == 0 && m21 == 0 && m22 == 1);
	    }
	
	    /**
	     * <code>fromAngleAxis</code> sets this matrix4f to the values specified
	     * by an angle and an axis of rotation.  This method creates an object, so
	     * use fromAngleNormalAxis if your axis is already normalized.
	     * 
	     * @param angle
	     *            the angle to rotate (in radians).
	     * @param axis
	     *            the axis of rotation.
	     */
	    public function fromAngleAxis(angle:Number, axis:Vector3f):void {
	        var normAxis:Vector3f = axis.normalise();
        	fromAngleNormalAxis(angle, normAxis);
 	   }
	
 	   /**
 	    * <code>fromAngleNormalAxis</code> sets this matrix4f to the values
 	    * specified by an angle and a normalized axis of rotation.
 	    * 
 	    * @param angle
 	    *            the angle to rotate (in radians).
 	    * @param axis
 	    *            the axis of rotation (already normalized).
 	    */
 	   public function fromAngleNormalAxis(angle:Number, axis:Vector3f):void {
 	       var fCos:Number = Math.cos(angle);
 	       var fSin:Number = Math.sin(angle);
 	       var fOneMinusCos:Number = 1.0-fCos;
 	       var fX2:Number = axis.x*axis.x;
 	       var fY2:Number = axis.y*axis.y;
 	       var fZ2:Number = axis.z*axis.z;
 	       var fXYM:Number = axis.x*axis.y*fOneMinusCos;
 	       var fXZM:Number = axis.x*axis.z*fOneMinusCos;
 	       var fYZM:Number = axis.y*axis.z*fOneMinusCos;
 	       var fXSin:Number = axis.x*fSin;
 	       var fYSin:Number = axis.y*fSin;
 	       var fZSin:Number = axis.z*fSin;
 	       
 	       m00 = fX2*fOneMinusCos+fCos;
 	       m01 = fXYM-fZSin;
 	       m02 = fXZM+fYSin;
 	       m10 = fXYM+fZSin;
 	       m11 = fY2*fOneMinusCos+fCos;
 	       m12 = fYZM-fXSin;
 	       m20 = fXZM-fYSin;
 	       m21 = fYZM+fXSin;
 	       m22 = fZ2*fOneMinusCos+fCos;
 	   }
 	   	
 	   /**
 	    * <code>mult</code> multiplies this matrix by a given matrix. The result
 	    * matrix is returned as a new object.
 	    * 
 	    * @param mat
 	    *            the matrix to multiply this matrix by.
 	    * @param product
 	    *            the matrix to store the result in. if null, a new matrix3f is
 	    *            created.  It is safe for mat and product to be the same object.
 	    * @return a matrix3f object containing the result of this operation
 	    */
 	   public function multMatrix3(mat:Matrix3f, product:Matrix3f = null):Matrix3f {
 	       
 	       var temp00:Number;
 	       var temp01:Number;
 	       var temp02:Number;
 	       var temp10:Number;
 	       var temp11:Number;
 	       var temp12:Number;
 	       var temp20:Number;
 	       var temp21:Number;
 	       var temp22:Number;
 	       
 	       if (product == null) product = new Matrix3f();
 	       temp00 = m00 * mat.m00 + m01 * mat.m10 + m02 * mat.m20;
 	       temp01 = m00 * mat.m01 + m01 * mat.m11 + m02 * mat.m21;
 	       temp02 = m00 * mat.m02 + m01 * mat.m12 + m02 * mat.m22;
 	       temp10 = m10 * mat.m00 + m11 * mat.m10 + m12 * mat.m20;
 	       temp11 = m10 * mat.m01 + m11 * mat.m11 + m12 * mat.m21;
 	       temp12 = m10 * mat.m02 + m11 * mat.m12 + m12 * mat.m22;
 	       temp20 = m20 * mat.m00 + m21 * mat.m10 + m22 * mat.m20;
 	       temp21 = m20 * mat.m01 + m21 * mat.m11 + m22 * mat.m21;
 	       temp22 = m20 * mat.m02 + m21 * mat.m12 + m22 * mat.m22;
 	       
 	       product.m00 = temp00;
 	       product.m01 = temp01;
 	       product.m02 = temp02;
 	       product.m10 = temp10;
 	       product.m11 = temp11;
 	       product.m12 = temp12;
 	       product.m20 = temp20;
 	       product.m21 = temp21;
 	       product.m22 = temp22;
 	       
 	       return product;
 	   }
	
 	   /**
 	    * Multiplies this 3x3 matrix by the 1x3 Vector vec and stores the result in
 	    * product.
 	    * 
 	    * @param vec
 	    *            The Vector3f to multiply.
 	    * @param product
 	    *            The Vector3f to store the result, it is safe for this to be
 	    *            the same as vec.
 	    * @return The given product vector.
 	    */
 	   public function multVector(vec:Vector3f, product:Vector3f = null):Vector3f {
 	       
 	       if (null == product) {
 	           product = new Vector3f();
 	       }	
 	       var x:Number = vec.x;
 	       var y:Number = vec.y;
 	       var z:Number = vec.z;	
 	       product.x = m00 * x + m01 * y + m02 * z;
 	       product.y = m10 * x + m11 * y + m12 * z;
 	       product.z = m20 * x + m21 * y + m22 * z;
 	       
 	       return product;
 	   }
	
 	   /**
 	    * <code>multLocal</code> multiplies this matrix internally by 
 	    * a given float scale factor.
 	    * 
 	    * @param scale
 	    *            the value to scale by.
 	    * @return this Matrix3f
 	    */
 	   public function multLocalScalar(scale:Number):Matrix3f {
 	       m00 *= scale;
 	       m01 *= scale;
 	       m02 *= scale;
 	       m10 *= scale;
 	       m11 *= scale;
 	       m12 *= scale;
 	       m20 *= scale;
 	       m21 *= scale;
 	       m22 *= scale;
 	       
 	       return this;
 	   }
	
 	   /**
 	    * <code>multLocal</code> multiplies this matrix by a given
 	    * <code>Vector3f</code> object. The result vector is stored inside the
 	    * passed vector, then returned . If the given vector is null, null will be
 	    * returned.
 	    * 
 	    * @param vec
 	    *            the vector to multiply this matrix by.
 	    * @return The passed vector after multiplication
 	    */
 	   public function multLocalVector(vec:Vector3f):Vector3f {
 	       if (vec == null) return null;
 	       var x:Number = vec.x;
 	       var y:Number = vec.y;
 	       vec.x = m00 * x + m01 * y + m02 * vec.z;
 	       vec.y = m10 * x + m11 * y + m12 * vec.z;
 	       vec.z = m20 * x + m21 * y + m22 * vec.z;
 	       return vec;
 	   }
	
 	   /**
 	    * <code>mult</code> multiplies this matrix by a given matrix. The result
 	    * matrix is saved in the current matrix. If the given matrix is null,
 	    * nothing happens. The current matrix is returned. This is equivalent to
 	    * this*=mat
 	    * 
 	    * @param mat
 	    *            the matrix to multiply this matrix by.
 	    * @return This matrix, after the multiplication
 	    */
 	   public function multLocalMatrix3(mat:Matrix3f):Matrix3f {
 	       
 	       return multMatrix3(mat, this);
 	   }
	
 	   /**
 	    * Transposes this matrix in place. Returns this matrix for chaining
 	    * 
 	    * @return This matrix after transpose
 	    */
 	   public function transposeLocal():Matrix3f {
 	       var tmp:Array = [9];
 	       getFromArray(tmp, false);
 	       getFromArray(tmp, true);
 	       return this;
 	   }	
 	   /**
 	    * Inverts this matrix and stores it in the given store.
 	    * 
 	    * @return The store
 	    */
 	   public function invert(store:Matrix3f = null):Matrix3f {
 	       if (store == null) store = new Matrix3f();	
 	       var det:Number = determinant();
 	       if ( Math.abs(det) <= FastMath.FLT_EPSILON )
 	           return store.zero();	
 	       store.m00 = m11*m22 - m12*m21;
 	       store.m01 = m02*m21 - m01*m22;
 	       store.m02 = m01*m12 - m02*m11;
 	       store.m10 = m12*m20 - m10*m22;
 	       store.m11 = m00*m22 - m02*m20;
 	       store.m12 = m02*m10 - m00*m12;
 	       store.m20 = m10*m21 - m11*m20;
 	       store.m21 = m01*m20 - m00*m21;
 	       store.m22 = m00*m11 - m01*m10;	
 	       store.multLocalScalar(1/det);
 	       
 	       return store;
 	   }
	
 	   /**
 	    * Inverts this matrix locally.
 	    * 
 	    * @return this
 	    */
 	   public function invertLocal():Matrix3f {
 	       var det:Number = determinant();
 	       if ( Math.abs(det) <= FastMath.FLT_EPSILON )
 	           return zero();	
 	       var f00:Number = m11*m22 - m12*m21;
 	       var f01:Number = m02*m21 - m01*m22;
 	       var f02:Number = m01*m12 - m02*m11;
 	       var f10:Number = m12*m20 - m10*m22;
 	       var f11:Number = m00*m22 - m02*m20;
 	       var f12:Number = m02*m10 - m00*m12;
 	       var f20:Number = m10*m21 - m11*m20;
 	       var f21:Number = m01*m20 - m00*m21;
 	       var f22:Number = m00*m11 - m01*m10;
 	       
 	       m00 = f00;
 	       m01 = f01;
 	       m02 = f02;
 	       m10 = f10;
 	       m11 = f11;
 	       m12 = f12;
 	       m20 = f20;
 	       m21 = f21;
 	       m22 = f22;	
 	       multLocalScalar(1/det);
 	       
 	       return this;
 	   }
 	    	   
 	   /**
 	    * Places the adjoint of this matrix in store (creates store if null.)
 	    * 
 	    * @param store
 	    *            The matrix to store the result in.  If null, a new matrix is created.
 	    * @return store
 	    */
 	   public function adjoint(store:Matrix3f = null):Matrix3f {
 	       if (store == null) store = new Matrix3f();	
 	       store.m00 = m11*m22 - m12*m21;
 	       store.m01 = m02*m21 - m01*m22;
 	       store.m02 = m01*m12 - m02*m11;
 	       store.m10 = m12*m20 - m10*m22;
 	       store.m11 = m00*m22 - m02*m20;
 	       store.m12 = m02*m10 - m00*m12;
 	       store.m20 = m10*m21 - m11*m20;
 	       store.m21 = m01*m20 - m00*m21;
 	       store.m22 = m00*m11 - m01*m10;	
 	       return store;
 	   }
	
 	   /**
 	    * <code>determinant</code> generates the determinate of this matrix.
 	    * 
 	    * @return the determinate
 	    */
 	   public function determinant():Number {
 	       var fCo00:Number = m11*m22 - m12*m21;
 	       var fCo10:Number = m12*m20 - m10*m22;
 	       var fCo20:Number = m10*m21 - m11*m20;
 	       var fDet:Number = m00*fCo00 + m01*fCo10 + m02*fCo20;
 	       
 	       return fDet;
 	   }
	
 	   /**
 	    * Sets all of the values in this matrix to zero.
 	    * 
 	    * @return this matrix
 	    */
 	   public function zero():Matrix3f {
 	       m00 = m01 = m02 = m10 = m11 = m12 = m20 = m21 = m22 = 0.0;
 	       return this;
 	   }
	
 	   /**
 	    * <code>add</code> adds the values of a parameter matrix to this matrix.
 	    * 
 	    * @param mat
 	    *            the matrix to add to this.
 	    */
 	   public function add(mat:Matrix3f):void {
 	       m00 += mat.m00;
 	       m01 += mat.m01;
 	       m02 += mat.m02;
 	       m10 += mat.m10;
 	       m11 += mat.m11;
 	       m12 += mat.m12;
 	       m20 += mat.m20;
 	       m21 += mat.m21;
 	       m22 += mat.m22;
 	   }
	
 	   /**
 	    * <code>transpose</code> <b>locally</b> transposes this Matrix.
 	    * This is inconsistent with general value vs local semantics, but is
 	    * preserved for backwards compatibility. Use transposeNew() to transpose
 	    * to a new object (value).
 	    * 
 	    * @return this object for chaining.
 	    */
 	   public function transpose():Matrix3f {
 	       return transposeLocal();
 	   }
 	       
 	   /**
 	    * <code>transposeNew</code> returns a transposed version of this matrix.
 	    *
 	    * @return The new Matrix3f object.
 	    */
 	   public function transposeNew():Matrix3f {
 	       var ret:Matrix3f = new Matrix3f(m00, m10, m20, m01, m11, m21, m02, m12, m22);
 	       return ret;
 	   }
 	   
 	   /**
 	    * <code>toString</code> returns the string representation of this object.
 	    * It is in a format of a 3x3 matrix. For example, an identity matrix would
 	    * be represented by the following string. com.jme.math.Matrix3f <br>[<br>
 	    * 1.0  0.0  0.0 <br>
 	    * 0.0  1.0  0.0 <br>
 	    * 0.0  0.0  1.0 <br>]<br>
 	    * 
 	    * @return the string representation of this object.
 	    */
 	   public function toString():String {
 	       var result:String = "com.jme.math.Matrix3f\n[\n";
 	       result += " ";
 	       result += m00;
 	       result += "  ";
 	       result += m01;
 	       result += "  ";
 	       result += m02;
 	       result += " \n";
 	       result += " ";
 	       result += m10;
 	       result += "  ";
 	       result += m11;
 	       result += "  ";
 	       result += m12;
 	       result += " \n";
 	       result += " ";
 	       result += m20;
 	       result += "  ";
 	       result += m21;
 	       result += "  ";
 	       result += m22;
 	       result += " \n]";
 	       
 	       return result;
 	   }
	
 	   /**
 	    * 
 	    * <code>hashCode</code> returns the hash code value as an integer and is
 	    * supported for the benefit of hashing based collection classes such as
 	    * Hashtable, HashMap, HashSet etc.
 	    * 
 	    * @return the hashcode for this instance of Matrix4f.
 	    * @see java.lang.Object#hashCode()
 	    */
 	   public function hashCode():int {
 	       var hash:int = 37;/*
 	       hash = 37 * hash + Float.floatToIntBits(m00);
 	       hash = 37 * hash + Float.floatToIntBits(m01);
 	       hash = 37 * hash + Float.floatToIntBits(m02);
	
 	       hash = 37 * hash + Float.floatToIntBits(m10);
 	       hash = 37 * hash + Float.floatToIntBits(m11);
 	       hash = 37 * hash + Float.floatToIntBits(m12);
	
 	       hash = 37 * hash + Float.floatToIntBits(m20);
 	       hash = 37 * hash + Float.floatToIntBits(m21);
 	       hash = 37 * hash + Float.floatToIntBits(m22);
	*/
 	       return hash;
 	   }
 	   
 	   /**
 	    * are these two matrices the same? they are is they both have the same mXX values.
 	    *
 	    * @param o
 	    *            the object to compare for equality
 	    * @return true if they are equal
 	    */
 	   public function equals(comp:Matrix3f):Boolean {
 	       if (this == comp) {
 	           return true;
 	       }
 	       
 	       if (m00 != comp.m00) return false;
 	       if (m01 != comp.m01) return false;
 	       if (m02 != comp.m02) return false;
	
 	       if (m10 != comp.m10) return false;
 	       if (m11 != comp.m11) return false;
 	       if (m12 != comp.m12) return false;
	
 	       if (m20 != comp.m20) return false;
 	       if (m21 != comp.m21) return false;
 	       if (m22 != comp.m22) return false;	
 	       return true;
 	   }	
 	   /**
 	    * A function for creating a rotation matrix that rotates a vector called
 	    * "start" into another vector called "end".
 	    * 
 	    * @param start
 	    *            normalized non-zero starting vector
 	    * @param end
 	    *            normalized non-zero ending vector
 	    * @see "Tomas Möller, John Hughes \"Efficiently Building a Matrix to Rotate \
 	    *      One Vector to Another\" Journal of Graphics Tools, 4(4):1-4, 1999"
 	    */
 	   public function fromStartEndVectors(start:Vector3f, end:Vector3f):void {
 	       var v:Vector3f = new Vector3f();
 	       var e:Number;
 	       var h:Number;
 	       var f:Number;	
 	       start.cross(end, v);
 	       e = start.dot(end);
 	       f = (e < 0) ? -e : e;	
 	       // if "from" and "to" vectors are nearly parallel
 	       if (f > 1.0 - FastMath.ZERO_TOLERANCE) {
 	           var u:Vector3f = new Vector3f();
 	           var x:Vector3f = new Vector3f();
 	           var c1:Number;
 	           var c2:Number;
 	           var c3:Number; /* coefficients for later use */
 	           var i:int;
 	           var j:int;	
 	           x.x = (start.x > 0.0) ? start.x : -start.x;
 	           x.y = (start.y > 0.0) ? start.y : -start.y;
 	           x.z = (start.z > 0.0) ? start.z : -start.z;	
 	           if (x.x < x.y) {
 	               if (x.x < x.z) {
 	                   x.x = 1.0;
 	                   x.y = x.z = 0.0;
 	               } else {
 	                   x.z = 1.0;
 	                   x.x = x.y = 0.0;
 	               }
 	           } else {
 	               if (x.y < x.z) {
 	                   x.y = 1.0;
 	                   x.x = x.z = 0.0;
 	               } else {
 	                   x.z = 1.0;
 	                   x.x = x.y = 0.0;
 	               }
 	           }	
 	           u.x = x.x - start.x;
 	           u.y = x.y - start.y;
 	           u.z = x.z - start.z;
 	           v.x = x.x - end.x;
 	           v.y = x.y - end.y;
 	           v.z = x.z - end.z;	
 	           c1 = 2.0 / u.dot(u);
 	           c2 = 2.0 / v.dot(v);
 	           c3 = c1 * c2 * u.dot(v);
			   var val:Number;
			   
 	           for (i = 0; i < 3; i++) {
 	               for (j = 0; j < 3; j++) {
 	                   val = -c1 * u.get(i) * u.get(j) - c2 * v.get(i)
 	                           * v.get(j) + c3 * v.get(i) * u.get(j);
 	                   set(i, j, val);
 	               }
 	               val = get(i, i);
 	               set(i, i, val + 1.0);
 	           }
 	       } else {
 	           // the most common case, unless "start"="end", or "start"=-"end"
 	           var hvx:Number;
 	           var hvz:Number;
 	           var hvxy:Number;
 	           var hvxz:Number;
 	           var hvyz:Number;
 	           
 	           h = 1.0 / (1.0 + e);
 	           hvx = h * v.x;
 	           hvz = h * v.z;
 	           hvxy = hvx * v.y;
 	           hvxz = hvx * v.z;
 	           hvyz = hvz * v.y;
 	           set(0, 0, e + hvx * v.x);
 	           set(0, 1, hvxy - v.z);
 	           set(0, 2, hvxz + v.y);
	
 	           set(1, 0, hvxy + v.z);
 	           set(1, 1, e + h * v.y * v.y);
 	           set(1, 2, hvyz - v.x);
	
 	           set(2, 0, hvxz - v.y);
 	           set(2, 1, hvyz + v.x);
 	           set(2, 2, e + hvz * v.z);
 	       }
 	   }
	
 	   /**
 	    * <code>scale</code> scales the operation performed by this matrix on a
 	    * per-component basis.
 	    *
 	    * @param scale
 	    *         The scale applied to each of the X, Y and Z output values.
 	    */
 	   public function scale(scale:Vector3f):void {
 	   	m00 *= scale.x;
 	   	m10 *= scale.x;
 	   	m20 *= scale.x;
 	   	m01 *= scale.y;
 	   	m11 *= scale.y;
 	   	m21 *= scale.y;
 	   	m02 *= scale.z;
 	   	m12 *= scale.z;
 	   	m22 *= scale.z;
 	   }
	
 	   public static function equalIdentity(mat:Matrix3f):Boolean {
			if (Math.abs(mat.m00 - 1) > 1e-4) return false;
			if (Math.abs(mat.m11 - 1) > 1e-4) return false;
			if (Math.abs(mat.m22 - 1) > 1e-4) return false;
	
			if (Math.abs(mat.m01) > 1e-4) return false;
			if (Math.abs(mat.m02) > 1e-4) return false;
	
			if (Math.abs(mat.m10) > 1e-4) return false;
			if (Math.abs(mat.m12) > 1e-4) return false;
	
			if (Math.abs(mat.m20) > 1e-4) return false;
			if (Math.abs(mat.m21) > 1e-4) return false;
	
			return true;
 	   }
 	   
 	   public function clone():Matrix3f {
 	      return new Matrix3f(this);
 	   }


	}
}