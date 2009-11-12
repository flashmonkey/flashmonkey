package org.flashmonkey.flash.pv3d.game.state
{
	import flash.display.DisplayObjectContainer;
	
	import org.flashmonkey.flash.core.game.state.BasicGameState;
	import org.flashmonkey.flash.pv3d.game.PV3DDisplay;

	public class PV3DGameState extends BasicGameState
	{	
		public function PV3DGameState(name:String, active:Boolean=false)
		{
			super(name, active);
			
			init();
		}
		
		protected function init():void 
		{ 
			_display = new PV3DDisplay();
		}
	}
}