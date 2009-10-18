package org.flashmonkey.flash.api
{
	import flash.events.Event;
	
	public interface IUpdatable
	{
		function update(e:Event = null):void;
	}
}