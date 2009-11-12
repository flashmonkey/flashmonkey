package org.flashmonkey.flash.core.game.state
{
	import org.flashmonkey.flash.core.game.display.IDisplay;
		
	public class BasicGameState extends GameState
	{
		protected var _display:IDisplay;
		
		public override function get display():IDisplay
		{
			return _display;
		}
		
		public override function set display(value:IDisplay):void 
		{
			_display = value;
		}
		
		public function BasicGameState(name:String, active:Boolean = false)
		{
			super(name, active);
		}

		public override function update(tpf:Number):void
		{
			
		}
		
		public override function render(tpf:Number):void
		{
			_display.render(tpf);
		}
		
		public override function cleanup():void
		{
			
		}
	}
}