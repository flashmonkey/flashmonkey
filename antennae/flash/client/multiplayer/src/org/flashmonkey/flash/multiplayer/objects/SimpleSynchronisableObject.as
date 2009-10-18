package org.flashmonkey.flash.multiplayer.objects 
{
	import org.flashmonkey.flash.api.IInput;
	import org.flashmonkey.flash.api.IPaperworldObject;
	import org.flashmonkey.flash.api.IState;
	
	import flash.display.Sprite;
	
	import org.as3commons.logging.ILogger;
	import org.as3commons.logging.LoggerFactory;	

	/**
	 * @author Trevor
	 */
	public class SimpleSynchronisableObject implements IPaperworldObject 
	{
		private static var logger:ILogger = LoggerFactory.getLogger("Paperworld");

		public var object : Sprite;

		public function SimpleSynchronisableObject(object : Sprite = null)
		{
			super( );
			
			this.object = object;
		}

		public function get displayObject() : *
		{
			return object;
		}

		public function set displayObject(object : *) : void
		{
			this.object = object;
		}

		public function synchronise(time : int, input : IInput, state : IState) : void
		{
			this.object.x = state.position.x;
			//this.object.y = state.py;

			//object.rotation = state.ow;
		}

		public function destroy() : void
		{
		}
	}
}

