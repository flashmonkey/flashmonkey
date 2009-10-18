package org.flashmonkey.flash.connection
{
	import com.joeberkovitz.moccasin.service.IOperation;
	
	import flash.net.NetConnection;
	
	import org.flashmonkey.flash.api.connection.IClient;
	import org.flashmonkey.flash.message.BaseMessageService;

	public class Red5Client extends BaseMessageService implements IClient
	{
		protected var _url:String;
		
		public function set url(value:String):void 
		{
			_url = value;
		}
		
		public function Red5Client()
		{
		}
		
		public function connect():void
		{
			_connection = new NetConnection();
			_connection.connect(_url);
		}
		
		public function disconnect():void
		{
			
		}
	}
}