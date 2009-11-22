package org.flashmonkey.flash.pv3d.game
{
	import flash.display.DisplayObjectContainer;
	
	import org.flashmonkey.flash.core.game.display.IDisplay;
	import org.papervision3d.cameras.Camera3D;
	import org.papervision3d.core.render.AbstractRenderEngine;
	import org.papervision3d.objects.DisplayObject3D;
	import org.papervision3d.render.BasicRenderEngine;
	import org.papervision3d.scenes.Scene3D;
	import org.papervision3d.view.Viewport3D;

	public class PV3DDisplay implements IDisplay
	{
		protected var _scene:Scene3D;
		
		public function get scene():Object
		{
			return _scene;
		}
		
		protected var _viewport:Viewport3D;
		
		protected var _renderer:AbstractRenderEngine;
		
		protected var _camera:Camera3D;
		
		public function set target(value:DisplayObjectContainer):void
		{
			value.addChild(_viewport);
		}
	
		public function PV3DDisplay()
		{
			init();
		}

		protected function init():void
		{
			_scene = createScene();
			_viewport = createViewport();
			_renderer = createRenderer();
			_camera = createCamera();
			_camera.z = -250;
		}
		
		protected function createScene():Scene3D 
		{
			return new Scene3D();
		}
		
		protected function createViewport():Viewport3D 
		{
			return new Viewport3D();
		}
		
		protected function createRenderer():AbstractRenderEngine 
		{
			return new BasicRenderEngine();
		}
		
		protected function createCamera():Camera3D 
		{
			return new Camera3D();
		}
		
	 	public function render(tpf:Number):void
		{
			for each (var do3d:DisplayObject3D in _scene.children)
			{
				trace("do3d: " + do3d + " " + do3d.scale + " " + _camera.z + " " + _viewport.parent);
			}
			_renderer.renderScene(_scene, _camera, _viewport);
		}
		
	}
}