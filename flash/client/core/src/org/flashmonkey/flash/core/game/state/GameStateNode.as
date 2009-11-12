package org.flashmonkey.flash.core.game.state
{
	public class GameStateNode extends GameState
	{
		protected var _children:Array = [];
		
		public function get children():Array
		{
			return _children;
		}
		
		public function GameStateNode(name:String, active:Boolean)
		{
			super(name, active);
		}
		
		public override function update(tpf:Number):void
		{
			for each (var child:IGameState in _children)
			{
				if (child.active)
				{
					child.update(tpf);
				}
			}
		}
		
		public override function render(tpf:Number):void
		{
			for each (var child:IGameState in _children)
			{
				if (child.active)
				{
					child.render(tpf);
				}
			}
		}
		
		public override function cleanup():void
		{
			for each (var child:IGameState in _children)
			{
				if (child.active)
				{
					child.cleanup();
				}
			}
		}
		
		public function attachChild(child:IGameState):void
		{
			child.parent = this;
			_children.push(child);
		}
		
		public function detachChild(child:IGameState):void
		{
			child.parent = null;
			
			for (var i:int = 0; i < _children.length; i++)
			{
				if (_children[i] == child)
				{
					_children.splice(i, 0);
					break;
				}
			}
		}
		
		public function getChild(name:String):IGameState
		{
			for each (var child:IGameState in _children)
			{
				if (child.name == name)
				{
					return child;
				}
			}
			
			return null;
		}
	}
}