package com.gesturelib.flash
{
	public interface GestureListener
	{
		function onGestureStart(e:GestureEvent):void;
		
		function onGestureComplete(e:GestureEvent):void;
	}
}