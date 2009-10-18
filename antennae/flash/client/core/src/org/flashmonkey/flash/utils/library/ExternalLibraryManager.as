package org.flashmonkey.flash.utils.library
{
	import org.flashmonkey.flash.utils.library.LibraryManager;
	import org.flashmonkey.flash.utils.patterns.iterator.IIterator;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Loader;
	import flash.display.MovieClip;
	import flash.media.Sound;
	import flash.system.ApplicationDomain;
	import flash.utils.Dictionary;
	
	import org.as3commons.logging.ILogger;
	import org.as3commons.logging.LoggerFactory;
	import org.as3commons.reflect.ClassUtils;
	import org.springextensions.actionscript.utils.DictionaryUtils;
	

	/**
	 * @author Trevor
	 */
	public class ExternalLibraryManager extends LibraryManager
	{
		private static var logger:ILogger = LoggerFactory.getLogger("Paperworld(Util)");
				
		private static var _instance : ExternalLibraryManager;

		private var _cache : Dictionary;
		
		//private var _assets:Dictionary;
  
		public function ExternalLibraryManager(singleton : Singleton)
		{
			super( );
			
			initialise();
		}
		
		public function initialise():void 
		{
			assets = new Dictionary(true);
			assets[SKIN_KEY] = [];
			assets[SOUND_KEY] = [];
			
			_cache = new Dictionary(true);
		}

		public static function getInstance() : ExternalLibraryManager
		{
			return (_instance == null) ? new ExternalLibraryManager( new Singleton( ) ) : _instance;
		}
		
		private function get skins():Array
		{
			return assets[SKIN_KEY] as Array;
		}
		
		private function get sounds():Array 
		{
			return assets[SOUND_KEY] as Array;
		}
		
		private function _createCache(key:Loader):void 
		{
			if (!DictionaryUtils.containsKey(_cache, key))
			{
				_cache[key] = new Object();
			}
		}
		
		private function _registerFile(loader:Loader, key:String):void 
		{
			logger.info("registering " + key + " file");
			(assets[key] as Array).push(loader);
			
			_createCache(loader);
		}
		
		public function registerSkinFile(loader:Loader):void 
		{
			_registerFile(loader, SKIN_KEY);
		}
		
		public function registerSoundFile(loader:Loader):void 
		{
			_registerFile(loader, SOUND_KEY);
		}
		
		override public function getMovieClip(key:String, useCache:Boolean = false):MovieClip 
		{		
			return MovieClip(_getInstance(key, SKIN_KEY, useCache));
		}
		
		override public function getBitmap(key:String, useCache:Boolean = false):Bitmap 
		{
			return Bitmap(_getInstance(key, SKIN_KEY, useCache));
		}
		
		override public function getBitmapData(key:String, useCache:Boolean = false):BitmapData
		{
			return BitmapData(_getInstance(key, SKIN_KEY, useCache));
		}
		
		override public function getSound(key:String, useCache:Boolean = false):Sound 
		{
			return Sound(_getInstance(key, SKIN_KEY, useCache));
		}
		
		private function _getInstance(key:String, type:String, useCache:Boolean):* 
		{
			if (useCache)
			{
				var instance:* = _getInstanceFromCache(key);
				
				if (instance)
				{
					return instance;
				}
			}
			
			var applicationDomain:ApplicationDomain = _getApplicationDomain(key, assets[type]);
			
			if (applicationDomain)
			{
				return ClassUtils.forName(key, applicationDomain);
			}
			
			return null;
		}
		
		private function _getInstanceFromCache(key:String):*
		{
			var loader:Loader = _getLoaderForKey(key);
			
			if (loader)
			{
				var cache:Object = _cache[loader];
				
				return cache[key];
			}
		}
		
		private function _getLoaderForKey(key:String):Loader 
		{
			var iterator:IIterator = new ClassKeysIterator(assets);
			
			while (iterator.hasNext())
			{
				var loader:Loader = Loader(iterator.next());
				
				if (loader.contentLoaderInfo.applicationDomain.hasDefinition(key))
				{
					return loader;
				}
			}
			
			return null;
		}
		
		private function _getApplicationDomain(key:String, classes:Array):ApplicationDomain
		{			
			for each (var loader:Loader in classes)
			{
				var applicationDomain:ApplicationDomain = loader.contentLoaderInfo.applicationDomain;
				
				if (applicationDomain.hasDefinition(key))
				{
					return applicationDomain;
				}
			}
			
			return null;
		}
	}
}

import org.flashmonkey.flash.utils.patterns.iterator.IIterator;
import flash.utils.Dictionary;

internal class Singleton
{
}

internal class ClassKeysIterator implements IIterator
{
	private var _collection:Array;
	
	private var _index:int;
	
	public function ClassKeysIterator(classes:Dictionary)
	{
		_collection = new Array();
		
		for each (var array:Array in classes)
		{
			_collection = _collection.concat(array);
		}
	}
	
	public function hasNext():Boolean 
	{
		return _index < _collection.length;
	}
	
	public function next():*
	{
		return _collection[_index++];
	}
	
	public function size():int 
	{
		return _collection.length;
	}
}
