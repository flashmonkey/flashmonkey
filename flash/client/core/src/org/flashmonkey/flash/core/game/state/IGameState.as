package org.flashmonkey.flash.core.game.state
{
	import org.flashmonkey.flash.api.IAvatarService;
	import org.flashmonkey.flash.core.game.display.IDisplay;
		
	public interface IGameState
	{			
		/**
		 * Gets called every frame before render(float) by the parent 
		 * <code>GameStateNode</code>.
		 * 
		 * @param tpf The elapsed time since last frame.
		 */
	    function update(tpf:Number):void;
	    
		/**
		 * Gets called every frame after update(float) by the 
		 * <code>GameStateManager</code>.
		 * 
		 * @param tpf The elapsed time since last frame.
		 */
	    function render(tpf:Number):void;
	    
	    /**
	     * Gets performed when cleanup is called on a parent GameStateNode (e.g.
	     * the GameStateManager).
	     */
	    function cleanup():void;
	    
	    /**
	     * Sets whether or not you want this GameState to be updated and rendered.
	     * 
	     * @param active 
	     *        Whether or not you want this GameState to be updated and rendered.
	     */
		function set active(active:Boolean):void;
	
	    /**
	     * Returns whether or not this GameState is updated and rendered.
	     * 
	     * @return Whether or not this GameState is updated and rendered.
	     */
		function get active():Boolean;
	
	    /**
	     * Returns the name of this GameState.
	     * 
	     * @return The name of this GameState.
	     */
		function get name():String;
		
		/**
		 * Sets the name of this GameState.
		 * 
		 * @param name The new name of this GameState.
		 */
		function set name(name:String):void;
		
		/**
		 * Sets the parent of this node. <b>The user should never touch this method,
		 * instead use the attachChild method of the wanted parent.</b>
		 * 
		 * @param parent The parent of this GameState.
		 */
		function set parent(parent:IGameState):void;
		
		/**
		 * Retrieves the parent of this GameState. If the parent is null, this is
		 * the root node.
		 * 
		 * @return The parent of this node.
		 */
		function get parent():IGameState;
		
		function get display():IDisplay;
		
		function set display(value:IDisplay):void;
		
		function set avatarService(value:IAvatarService):void;

	}
}