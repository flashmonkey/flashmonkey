package org.flashmonkey.flash.utils.library
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.media.Sound;
	import flash.utils.Dictionary;
	
	import org.as3commons.logging.ILogger;
	import org.as3commons.logging.LoggerFactory;

	public class LibraryManager implements ILibraryManager
	{		
		private static var log:ILogger = LoggerFactory.getLogger("LibraryManager");
		
		public static const EMBEDDED_LIBRARY:String = "EmbeddedLibrary";
		public static const EXTERNAL_LIBRARY:String = "ExternalLibrary";
		
		public static var LIBRARY_TYPE:String = EMBEDDED_LIBRARY;
		
		public static const SKIN_KEY:String = "Skin";
		public static const SOUND_KEY:String = "Sound";
		
		private static var _instance:ILibraryManager;
		
		private var _assets:Dictionary = new Dictionary();
		
		public function get assets():Dictionary
		{
			return _assets;
		}
		
		public function set assets(value:Dictionary):void 
		{
			_assets = value;
		}
		
		public function LibraryManager()
		{
		}
		
		private static function getManager():ILibraryManager
		{
			log.info("Getting new LibraryManager");
			
			var libraryManager:ILibraryManager;
			
			switch (LIBRARY_TYPE)
			{
				case EMBEDDED_LIBRARY:
					libraryManager = new EmbeddedLibraryManager();
					break;
					
				default:
					break;
			}
			
			if (null == libraryManager) {
				throw new Error("You didn't supply a supported type for your LibraryManager");
			}

			return libraryManager;
		}
		
		public static function get instance():ILibraryManager
		{
			return _instance = (_instance == null) ? getManager() : _instance;
		}

		public function getDisplayObject(key:String, useCache:Boolean = false):DisplayObject
		{
			return null;
		}
		
		public function getSprite(key:String, useCache:Boolean = false):Sprite
		{
			return null;
		}

		public function getMovieClip(key:String, useCache:Boolean = false):MovieClip
		{
			return null;
		}
		
		public function getBitmapData(key:String, useCache:Boolean = false):BitmapData
		{
			return null;
		}
		
		public function getBitmap(key:String, useCache:Boolean = false):Bitmap
		{
			return null;
		}
		
		public function getSound(key:String, useCache:Boolean = false):Sound
		{
			return null;
		}
		
	}
}