package org.flashmonkey.flash.core.game.display
{
	import flash.display.DisplayObjectContainer;
	
	public interface IDisplay
	{
		function set target(value:DisplayObjectContainer):void;
		
		function get scene():Object;
		
		function render(tpf:Number):void;
	}
}