package
{
	import flash.events.Event;
	import flash.utils.IDataInput;
	import flash.utils.IDataOutput;
	
	import org.flashmonkey.flash.connection.messages.BaseMessage;

	public class SpeechRecognitionMessage extends BaseMessage
	{
		public override function get aliasName():String 
		{
			return "org.flashmonkey.java.examples.speechrecognition.SpeechRecognitionMessage";
		}
		
		private var _streamName:String = ".";
		
		private var _bestResult:String = ".";
		
		public function get bestResult():String 
		{
			return _bestResult;
		}
		
		public function SpeechRecognitionMessage(streamName:String = null)
		{
			super();
			
			if (streamName)
				_streamName = streamName;
		}
		
		public override function onResult(result:Object):void 
		{
			_bestResult = SpeechRecognitionMessage(result).bestResult;

			dispatchEvent(new Event(Event.COMPLETE));
		}
		
		public override function readExternal(input:IDataInput):void 
		{
			super.readExternal(input);
			
			_streamName = input.readUTF();
			_bestResult = input.readUTF();
		}
		
		public override function writeExternal(output:IDataOutput):void
		{
			super.writeExternal(output);

			output.writeUTF(_streamName);
			output.writeUTF(_bestResult);
		}
		
		public override function toString():String 
		{
			return "SpeechRecognitionMessage[" + senderId + "]";
		}
	}
}