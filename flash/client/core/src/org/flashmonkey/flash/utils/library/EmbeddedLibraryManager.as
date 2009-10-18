package org.flashmonkey.flash.utils.library
{
	import flash.display.Sprite;
	
	import org.as3commons.logging.ILogger;
	import org.as3commons.logging.LoggerFactory;
	import org.as3commons.reflect.ClassUtils;
	
	public class EmbeddedLibraryManager extends LibraryManager
	{
		private static var log:ILogger = LoggerFactory.getLogger("EmbeddedLibraryManager");
		
		private static var _instance:EmbeddedLibraryManager;
		
		public function EmbeddedLibraryManager()
		{
		}

		public static function get instance():EmbeddedLibraryManager
		{
			return _instance = (_instance == null) ? new EmbeddedLibraryManager() : _instance;
		}
		
		override public function getSprite(key:String, useCache:Boolean = false):Sprite 
		{
			var instance:* = newInstance(key);
			
			if (!(instance is Sprite))
			{
				throw new Error("The asset you've requested [" + key + "] is not a MovieClip");
			}			
			
			return Sprite(instance);
		}
		
		public function newInstance(key:String):*
		{
			var clazz:Class = assets[key];

			if (null == clazz)
			{
				throw new Error("There's no asset class registered with the name " + key);
			}
			
			return ClassUtils.newInstance(clazz);
		}
	}
}