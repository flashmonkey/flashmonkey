package
{
	import flash.utils.IDataInput;
	import flash.utils.IDataOutput;
	
	import org.flashmonkey.flash.api.IInput;
	import org.flashmonkey.flash.connection.messages.BaseMessage;
	import org.flashmonkey.flash.utils.input.SimpleInput;

	public class MultiplayerVideoInputMessage extends BaseMessage
	{
		public override function get aliasName():String 
		{
			return "org.red5.core.MultiplayerVideoInputMessage";
		}
		
		private var _input:IInput = new SimpleInput();
		
		public function set input(value:IInput):void 
		{
			_input = value;
		}
		
		public function MultiplayerVideoInputMessage()
		{
			super();
		}
		
		public override function readExternal(input:IDataInput):void
		{
			super.readExternal(input);
			
			_input = IInput(input.readObject());
		}
		
		public override function writeExternal(output:IDataOutput):void 
		{
			super.writeExternal(output);
			
			output.writeObject(_input);
		}
		
		public override function toString():String
		{
			return "MultiplayerVideoInputMessage";
		}
		
	}
}