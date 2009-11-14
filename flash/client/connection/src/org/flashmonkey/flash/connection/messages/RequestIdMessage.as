package org.flashmonkey.flash.connection.messages
{
	import flash.utils.IDataInput;
	import flash.utils.IDataOutput;
	
	public class RequestIdMessage extends BaseMessage
	{			
		private var _uniqueId:String = "-1";
		
		override public function get aliasName():String
		{
			return "org.flashmonkey.java.multiplayer.messages.RequestIdMessage";
		}
		
		public function RequestIdMessage()
		{
			super();
		}
		
		override public function onResult(result:Object):void
		{
			_uniqueId = String(result);
			
			super.onResult(result);
		}
		
		override public function read():* 
		{
			return _uniqueId;
		}
	}
}