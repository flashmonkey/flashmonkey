package org.flashmonkey.flash.api.connection
{
	import com.joeberkovitz.moccasin.service.IOperation;
	
	import org.flashmonkey.flash.api.message.IMessageService;
	
	public interface IClient extends IMessageService
	{
		function connect():void;
		
		function disconnect():void;
	}
}