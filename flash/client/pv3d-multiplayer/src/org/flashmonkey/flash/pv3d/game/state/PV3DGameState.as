package org.flashmonkey.flash.pv3d.game.state
{
	import org.flashmonkey.flash.core.game.state.BasicGameState;
	import org.papervision3d.cameras.Camera3D;
	import org.papervision3d.core.render.AbstractRenderEngine;
	import org.papervision3d.render.BasicRenderEngine;
	import org.papervision3d.scenes.Scene3D;
	import org.papervision3d.view.Viewport3D;

	public class PV3DGameState extends BasicGameState
	{
		protected var _scene:Scene3D;
		
		protected var _viewport:Viewport3D;
		
		protected var _renderer:AbstractRenderEngine;
		
		protected var _camera:Camera3D;
		
		public function PV3DGameState(name:String, active:Boolean=false)
		{
			super(name, active);
			
			init();
		}
		
		protected function init():void
		{
			_scene = createScene();
			_viewport = createViewport();
			_renderer = createRenderer();
			_camera = createCamera();
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
		
		override public function render(tpf:Number):void
		{
			_renderer.renderScene(_scene, _camera, _viewport);
		}
	}
}