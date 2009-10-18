package org.flashmonkey.flash.utils.patterns.iterator
{
	public interface IIterator
	{
		function hasNext():Boolean;
		
		function next():*;
		
		function size():int;
	}
}