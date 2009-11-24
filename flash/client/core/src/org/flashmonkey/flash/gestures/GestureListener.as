package org.flashmonkey.flash.gestures
{
	public interface GestureListener
	{
		function onGestureStart(e:GestureEvent):void;
		
		function onGestureComplete(e:GestureEvent):void;
	}
}