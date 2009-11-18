package org.flashmonkey.examples.mousegesturecontrolvideo;

public class Vector2D {

	public double x = 0.0;
	
	public double y = 0.0;
	
	public Vector2D(double x, double y)
	{
		this.x = x;
		this.y = y;
	}


	//we need some overloaded operators
	public Vector2D plusEquals(Vector2D other)
	{
		x += other.x;
		y += other.y;

		return this;
	}
	
	public Vector2D minusEquals(Vector2D other)
	{
		x -= other.x;
		y -= other.y;

		return this;
	}
	
	public Vector2D multiplyEquals(double other)
	{
		x *= other;
		y *= other;

		return this;
	}

	public Vector2D divideEquals(double other)
	{
		x /= other;
		y /= other;

		return this;
	}
  	

	//overload the * operator
	public Vector2D multiply(Vector2D lhs, double rhs)
	{
	  Vector2D result = new Vector2D(lhs.x, lhs.y);
	  result.multiplyEquals(rhs);
	  return result;
	}

	public Vector2D multiply(double lhs, Vector2D rhs)
	{
		Vector2D result = new Vector2D(rhs.x, rhs.y);
		result.multiplyEquals(lhs);
		return result;
	}

	//overload the - operator
	public Vector2D minus(Vector2D lhs, Vector2D rhs)
	{
		Vector2D result = new Vector2D(lhs.x, lhs.y);
		result.x -= rhs.x;
		result.y -= rhs.y;
	  
		return result;
	}

	//------------------------- Vec2DLength -----------------------------
	//
	//	returns the length of a 2D vector
	//--------------------------------------------------------------------
	public double length()
	{
		return Math.sqrt(x * x + y * y);
	}

	//------------------------- Vec2DNormalize -----------------------------
	//
	//	normalizes a 2D Vector
	//--------------------------------------------------------------------
	public void normalize()
	{
		double vector_length = length();
	
		x = x / vector_length;
		y = y / vector_length;
	}

	//------------------------- Vec2DDot --------------------------
	//
	//	calculates the dot product
	//--------------------------------------------------------------------
	public double dot(Vector2D v)
	{
		return x * v.x + y * v.y;
	}

	//------------------------ Vec2DSign --------------------------------
	//
	//  returns positive if v2 is clockwise of v1, minus if anticlockwise
	//-------------------------------------------------------------------
	public int sign(Vector2D v)
	{
	  if (y * v.x > x * v.y)
	  { 
	    return 1;
	  }
	  else 
	  {
	    return -1;
	  }
	}
}
