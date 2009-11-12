package org.flashmonkey.flash.core.game.state
{
	import org.flashmonkey.flash.core.game.display.IDisplay;
	
	public class GameState implements IGameState
	{
		/** The name of this GameState. */
		protected var _name:String;
		
		public function get name():String
		{
			return _name;
		}
		
		public function set name(value:String):void
		{
			_name = value;
		}
		
		/** Flags whether or not this GameState should be processed. */
		protected var _active:Boolean; 
		
		public function set active(value:Boolean):void
		{
			_active = value;
		}
		
		public function get active():Boolean
		{
			return _active;
		}
		
		/** GameState's parent, or null if it has none (is the root node). */
		protected var _parent:IGameState;
		
		public function get parent():IGameState
		{
			return _parent;
		}
		
		public function set parent(value:IGameState):void
		{
			_parent = parent;
		}
		
		public function get display():IDisplay
		{
			throw new Error("display getter must be implemeted in any child classes");
			
			return null;
		}
		
		public function set display(value:IDisplay):void 
		{
			throw new Error("display setter must be implemeted in any child classes");
		}
		
		public function GameState(name:String, active:Boolean)
		{
			_name = name;
			_active = active;
		}

		public function update(tpf:Number):void
		{
			throw new Error("update() must be implemeted in any child classes");
		}
		
		public function render(tpf:Number):void
		{
			throw new Error("render() must be implemeted in any child classes");
		}
		
		public function cleanup():void
		{
			throw new Error("cleanup() must be implemeted in any child classes");
		}
	}
}