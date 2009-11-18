package org.flashmonkey.flash.api.connection
{	
	import flash.events.IEventDispatcher;
	import flash.net.Responder;
	
	public interface INetConnection extends IEventDispatcher
	{
		function connect(command:String, ...args):void;
		
		function call(command:String, responder:Responder, ...args):void;
		
		function set client(value:Object):void;
		
		function get rtmpURI():String;
		
		function set rtmpURI(value:String):void;
		
		function get connected():Boolean;
		
		function get connectionArgs():Array;
		function set connectionArgs(value:Array):void;
	}
}