package org.flashmonkey.flash.pv3d.game
{
	import flash.display.DisplayObjectContainer;
	
	import org.flashmonkey.flash.core.game.display.IDisplay;
	import org.flashmonkey.flash.pv3d.views.ChequerBoardView;
	import org.papervision3d.view.AbstractView;

	public class NewPV3DDisplay implements IDisplay
	{
		private var _view:AbstractView;
		
		public function NewPV3DDisplay(viewportWidth:Number=640, viewportHeight:Number=480, scaleToStage:Boolean=true, interactive:Boolean=false, cameraType:String="Target")
		{
			_view = new ChequerBoardView(1000, 1000, viewportWidth, viewportHeight, scaleToStage, interactive, cameraType);
		}
		
		public function set target(value:DisplayObjectContainer):void
		{
			value.addChild(_view);
		}
		
		public function get scene():Object
		{
			return _view.scene;
		}
		
		public function render(tpf:Number):void
		{
			_view.singleRender();
		}
		
	}
}