package org.flashmonkey.flash.api.connection
{
	import com.joeberkovitz.moccasin.service.IOperation;
	
	public interface IHandshake extends IOperation
	{
		function addClassToRegister(c:Class):void;
	}
}