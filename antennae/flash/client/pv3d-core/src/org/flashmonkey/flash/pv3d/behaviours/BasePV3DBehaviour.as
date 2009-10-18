package org.flashmonkey.flash.pv3d.behaviours
{
	import org.flashmonkey.flash.core.action.Action;
	import org.flashmonkey.flash.pv3d.objects.PaperworldObject;
	
	import org.papervision3d.objects.DisplayObject3D;

	public class BasePV3DBehaviour extends Action
	{
		protected var _actor:PaperworldObject;
		
		public function set actor(value:PaperworldObject):void 
		{
			_actor = value;
			_displayObject = DisplayObject3D(_actor.displayObject);
		}
		
		protected var _displayObject:DisplayObject3D;
		
		public function BasePV3DBehaviour()
		{
			super();
		}
		
	}
}