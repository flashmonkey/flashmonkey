package org.flashmonkey.flash.pv3d
{
	import com.joeberkovitz.moccasin.service.AbstractOperation;
	
	import flash.events.Event;
	
	import org.flashmonkey.flash.api.ISynchronisedObject;
	import org.flashmonkey.flash.pv3d.objects.PaperworldObject;

	public class SynchronisedObjectOperation extends AbstractOperation
	{
		protected var _syncObject:ISynchronisedObject;
		
		public function SynchronisedObjectOperation()
		{
			super();
		}
		
		public override function execute():void
		{
			_syncObject = new PaperworldObject();
			
			handleComplete(new Event(Event.COMPLETE));
		}
		
		public override function get result():*
		{
			return _syncObject;
		}
	}
}