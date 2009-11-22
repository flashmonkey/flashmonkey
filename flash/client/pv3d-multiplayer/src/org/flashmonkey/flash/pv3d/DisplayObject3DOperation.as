package org.flashmonkey.flash.pv3d
{
	import com.joeberkovitz.moccasin.service.AbstractOperation;
	
	import flash.events.Event;

	public class DisplayObject3DOperation extends AbstractOperation
	{
		protected var _displayObject:*;
		
		public function DisplayObject3DOperation()
		{
			super();
		}
		
		public override function execute():void
		{
			handleComplete(new Event(Event.COMPLETE));
		}
		
		public override function get result():*
		{
			return _displayObject;
		}
	}
}