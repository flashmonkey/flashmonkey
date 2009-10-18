package org.flashmonkey.flash.utils.math
{
	public class FastMath
	{
		/** A "close to zero" float epsilon value for use*/
    	public static const ZERO_TOLERANCE:Number = 0.0001;
    	
    	/** A "close to zero" float epsilon value for use*/
    	public static const FLT_EPSILON:Number = 1.1920928955078125E-7;
    	
    	/** A value to multiply a degree value by, to convert it to radians. */
	    public static const DEG_TO_RAD:Number = Math.PI / 180.0;
	
	    /** A value to multiply a radian value by, to convert it to degrees. */
	    public static const RAD_TO_DEG:Number = 180.0 / Math.PI;
	}
}