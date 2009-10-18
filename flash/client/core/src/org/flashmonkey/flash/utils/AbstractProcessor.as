package org.flashmonkey.flash.utils
{
	public class AbstractProcessor implements IProcessor
	{
		private var _types:Array = [];
		
		public function AbstractProcessor(types:Array = null)
		{
			_types = _types.concat(types);
		}
		
		public function addType(type:Class):void 
		{
			_types.push(type);
		}

		public function canProcess(object:*):Boolean
		{
			for each (var type:Class in _types)
			{
				if (object is type)
				{
					return true;
				}
			}
			
			return false;
		}
		
		public function process(object:*):void
		{
		}
	}
}