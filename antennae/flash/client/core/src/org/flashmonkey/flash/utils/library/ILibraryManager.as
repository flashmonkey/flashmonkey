package org.flashmonkey.flash.utils.library
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.media.Sound;
	import flash.utils.Dictionary;
	
	public interface ILibraryManager
	{
		function get assets():Dictionary;
		function set assets(value:Dictionary):void;
		
		function getDisplayObject(key:String, useCache:Boolean = false):DisplayObject;
		
		function getSprite(key:String, useCache:Boolean = false):Sprite;
		
		function getMovieClip(key:String, useCache:Boolean = false):MovieClip;
		
		function getBitmapData(key:String, useCache:Boolean = false):BitmapData;
		
		function getBitmap(key:String, useCache:Boolean = false):Bitmap;
		
		function getSound(key:String, useCache:Boolean = false):Sound;
	}
}