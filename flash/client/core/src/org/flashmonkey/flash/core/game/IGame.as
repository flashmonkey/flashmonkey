package org.flashmonkey.flash.core.game
{
	import flash.events.Event;
	
	public interface IGame
	{
		function start():void;
		
		function update(e:Event = null):void;
		
		function render(e:Event = null):void;
		
		function finish():void;
		
		function cleanup():void;
	}
}