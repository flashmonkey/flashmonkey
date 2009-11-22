package org.flashmonkey.flash.pv3d
{
	import flash.events.Event;
	
	import org.papervision3d.events.FileLoadEvent;
	import org.papervision3d.objects.parsers.DAE;
	
	public class DAEDisplayObject3DOperation extends DisplayObject3DOperation
	{
		protected var _url:String;
		
		protected var _scale:Number;
		
		public function DAEDisplayObject3DOperation(url:String, scale:Number)
		{
			super();
			
			_url = url;
			_scale = scale;
		}
		
		public override function execute():void
		{
			var model : DAE = new DAE(false);
			model.addEventListener(FileLoadEvent.ANIMATIONS_COMPLETE, onModelLoaded);
			model.load(_url);	
		}
		
		protected function onModelLoaded(e:Event):void 
		{
			var model:DAE = DAE(e.target);
			model.scale = _scale;
			
			_displayObject = model;
			
			handleComplete(new Event(Event.COMPLETE));
		}
		
	}
}