package org.flashmonkey.flash.pv3d.operations
{
	import flash.utils.IDataInput;
	import flash.utils.IDataOutput;
	
	import org.flashmonkey.flash.connection.messages.BaseMessage;

	public class ResolveAvatarLocationMessage extends BaseMessage
	{
		private var _id:String;
		
		public function get location():String 
		{
			return String(_result);
		}
		
		public override function get aliasName():String 
		{
			return "org.flashmonkey.java.connection.messages.ResolveAvatarLocationMessage";
		}
		
		public function ResolveAvatarLocationMessage(id:String = ".")
		{
			super();
			
			_id = id;
		}
		
		public override function writeExternal(output:IDataOutput):void
		{
			super.writeExternal(output);
			
			output.writeUTF(_id);
		}
		
		public override function readExternal(input:IDataInput):void
		{
			super.readExternal(input);
			
			_id = input.readUTF();
		}
	}
}