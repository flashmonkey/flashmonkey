package org.flashmonkey.flash.pv3d.views
{	
	import flash.display.Sprite;
	import flash.utils.Dictionary;
	
	import org.as3commons.logging.ILogger;
	import org.as3commons.logging.LoggerFactory;
	import org.papervision3d.objects.DisplayObject3D;
	import org.papervision3d.view.BasicView;
	import org.papervision3d.view.layer.ViewportLayer;

	public class BasicPaperworldView extends BasicView
	{
		private static var logger:ILogger = LoggerFactory.getLogger("Paperworld(PV3D)");
		
		protected var layers:Dictionary;
		
		public function getLayerByName(name:String):ViewportLayer
		{
			return ViewportLayer(layers[name]);
		}
		
		public function set target(value:Sprite):void 
		{
			logger.info("Adding " + viewport + " to " + value);
			value.addChild(viewport);
		}
		
		public function BasicPaperworldView()
		{
			super();
			
			layers = new Dictionary();
		}
		
		public function createLayer(name:String, parent:String = null, do3d:DisplayObject3D = null):ViewportLayer
		{
			var d:DisplayObject3D = do3d ? do3d : new DisplayObject3D();
			var layer:ViewportLayer = viewport.getChildLayer(d, true);
			layers[name] = layer;
			return layer;
		}
		
		public function addToLayer(do3d:DisplayObject3D, layer:String = null ):void 
		{
			scene.addChild(do3d);
			//ViewportLayer(layers[layer]).addDisplayObject3D(do3d);
		}
		
		/*public function onSpaceStarted(event:SpaceEvent):void 
		{
			logger.info("starting rendering");
			startRendering();
		}
		
		public function onSpaceStopped(event:SpaceEvent):void 
		{
			stopRendering();
		}*/
	}
}