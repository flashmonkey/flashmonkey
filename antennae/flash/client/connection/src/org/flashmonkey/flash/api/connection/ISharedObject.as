package org.flashmonkey.flash.api.connection
{	
	import flash.events.IEventDispatcher;
	import flash.net.SharedObject;
	
	public interface ISharedObject extends IEventDispatcher
	{
		function get connection():INetConnection;
		
		function set connection(value:INetConnection):void;
		
		function get sharedObject():SharedObject;
	}
}