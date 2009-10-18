package org.flashmonkey.flash.utils
{
	public interface IProcessor
	{
		function addType(type:Class):void;
		
		function canProcess(object:*):Boolean;
		
		function process(object:*):void;
	}
}