package com.gesturelib.flash
{
	public class Gestures
	{
		public static const RIGHT:Array = [1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0 ];

		public static const LEFT:Array = [-1, 0, -1, 0, -1, 0, -1, 0, -1, 0, -1, 0, -1, 0, -1, 0, -1, 0, -1, 0, -1, 0, -1, 0 ];
			
		public static const DOWN:Array = [0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1 ];

		public static const UP:Array = [ 0, -1, 0, -1, 0, -1, 0, -1, 0, -1, 0, -1, 0, -1, 0, -1, 0, -1, 0, -1, 0, -1, 0, -1 ];

		public static const CLOCKWISE_SQUARE:Array = [ 1, 0, 1, 0, 1, 0, 0, 1, 0, 1, 0, 1, -1, 0, -1, 0, -1, 0, 0, -1, 0, -1, 0, -1 ];

		public static const ANTI_CLOCKWISE_SQUARE:Array = [ -1, 0, -1, 0, -1, 0, 0, 1, 0, 1, 0, 1, 1, 0, 1, 0, 1, 0, 0, -1, 0, -1, 0, -1 ];

		public static const RIGHT_ARROW:Array = [ 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, -0.45, 0.9, -0.9, 0.45, -0.9, 0.45 ];

		public static const LEFT_ARROW:Array = [ -1, 0, -1, 0, -1, 0, -1, 0, -1, 0, -1, 0, -1, 0, -1, 0, -1, 0, 0.45, 0.9, 0.9, 0.45, 0.9, 0.45 ];

		public static const SOUTH_WEST:Array = [ -0.7,0.7, -0.7,0.7, -0.7,0.7, -0.7,0.7, -0.7,0.7, -0.7,0.7, -0.7,0.7, -0.7,0.7, -0.7,0.7, -0.7,0.7, -0.7,0.7, -0.7,0.7 ];

		public static const SOUTH_EAST:Array = [ 0.7,0.7, 0.7,0.7, 0.7,0.7, 0.7,0.7, 0.7,0.7, 0.7,0.7, 0.7,0.7, 0.7,0.7, 0.7,0.7, 0.7,0.7, 0.7,0.7, 0.7,0.7];

		public static const ZORRO:Array = [1, 0, 1, 0, 1, 0, 1, 0, -0.72, 0.69, -0.7, 0.72, 0.59, 0.81, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0 ];

		public static const GESTURES:Array = ["RIGHT", "LEFT", "DOWN", "UP", "CLOCKWISE_SQUARE", "ANTI_CLOCKWISE_SQUARE", "RIGHT_ARROW", "LEFT_ARROW", "SOUTH_WEST", "SOUTH_EAST", "ZORRO"];
	}
}