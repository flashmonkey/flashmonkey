package org.flashmonkey.flash.utils
{
	import org.flashmonkey.flash.api.IInput;
	
	public class SyncObject
	{
		public var id:String;
		
		public var input:IInput;
		
		public function SyncObject(id:String, input:IInput)
		{
			this.id = id;
			this.input = input;
		}

	}
}