package org.flashmonkey.flash.examples.mousecontrolvideo.messages
{
	import flash.geom.Point;
	import flash.utils.IDataInput;
	import flash.utils.IDataOutput;
	
	import org.flashmonkey.flash.connection.messages.BaseMessage;

	public class RecogniseGestureMessage extends BaseMessage
	{
		public override function get aliasName():String
		{
			return "org.flashmonkey.examples.mousegesturecontrolvideo.messages.RecogniseGestureMessage";	
		}
		
		private var _gesture:Array = [];
		
		public function get gestureName():String 
		{
			return String(_result);
		}
		
		public function RecogniseGestureMessage(gesture:Array = null)
		{
			super();
			
			if (gesture)
				_gesture = gesture;
		}
		
		public override function readExternal(input:IDataInput):void
		{
			super.readExternal(input);
			
			/*var n:int = input.readInt();
			
			for (var i:int = 0; i < n; i++)
			{
				_gesture[i] = input.readObject();
			}*/
		}
		
		public override function writeExternal(output:IDataOutput):void
		{
			super.writeExternal(output);
			trace("Writing " + _gesture.length);
			output.writeInt(_gesture.length);
			
			for each (var n:Number in _gesture)
			{
				output.writeDouble(n);
			}
		}
	}
}