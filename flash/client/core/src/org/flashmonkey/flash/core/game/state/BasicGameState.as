package org.flashmonkey.flash.core.game.state
{
	import org.flashmonkey.flash.api.connection.IClient;
	
	public class BasicGameState implements IGameState
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
		
		protected var _children:Array = [];
		
		public function get children():Array
		{
			return _children;
		}
		
		protected var _client:IClient;
		
		public function set client(value:IClient):void 
		{
			_client = value;
		}
		
		public function BasicGameState(name:String, active:Boolean = false)
		{
			_name = name;
			_active = active;
		}

		public function update(tpf:Number):void
		{
			for each (var child:IGameState in _children)
			{
				if (child.active)
				{
					child.update(tpf);
				}
			}
		}
		
		public function render(tpf:Number):void
		{
			for each (var child:IGameState in _children)
			{
				if (child.active)
				{
					child.render(tpf);
				}
			}
		}
		
		public function cleanup():void
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