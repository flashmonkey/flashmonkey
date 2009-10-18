package org.flashmonkey.flash.ai.scheduling 
{
	/**
	 * @author Trevor
	 */
	public interface Scheduleable 
	{
		function run(time : int = 0) : void;
	}
}
