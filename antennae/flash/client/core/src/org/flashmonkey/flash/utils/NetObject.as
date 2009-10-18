package org.flashmonkey.flash.utils
{
	import flash.net.registerClassAlias;
	import flash.utils.IDataInput;
	import flash.utils.IDataOutput;
	import flash.utils.IExternalizable;
	
	import org.as3commons.reflect.ClassUtils;
	import org.springextensions.actionscript.utils.StringUtils;

	public class NetObject implements IExternalizable, IRegisteredClass
	{
		private static var _registeredClasses:Array = [];
		
		public static function registerClass(instance:IRegisteredClass):void 
		{
			var clazz:Class = ClassUtils.forInstance(instance);
			
			if (!isRegistered(clazz))
			{
				registerClassAlias(instance.aliasName, clazz);
			}
		}
		
		private static function isRegistered(clazz:Class):Boolean 
		{
			for each (var registeredClass:Class in _registeredClasses)
			{
				if (registeredClass == clazz)
				{
					return true;
				}
			}	
			
			return false;
		}
		
		private var _aliasName:String = "";
		
		/**
		 * Default behaviour for returning the remote alias for this class.
		 * We just replace the word 'java' with the word 'flash' in the package path.
		 * This relies on the server-side package structure being identical (apart
		 * from the flash/java replacement) so if you don't follow this convention
		 * in your application you'll need to override the createAliasName() 
		 * method in your objects that are being passed over the wire.
		 */
		public function get aliasName():String
		{
			// If we don't already have the alias name cached.
			if (!_aliasName)
			{
				// Create and cache it.
				_aliasName = createAliasName();
			}

			return _aliasName;
		}
		
		protected function createAliasName():String
		{
			var className:String = ClassUtils.getFullyQualifiedName(ClassUtils.forInstance(this), true);
			var beginIndex:int = className.indexOf(Constants.FLASH_STRING + ".");

			return StringUtils.replaceAt(className, Constants.JAVA_STRING, beginIndex, beginIndex + Constants.FLASH_STRING.length);
		}
		
		public function NetObject()
		{
			registerClass(this);
		}

		public function writeExternal(output:IDataOutput):void
		{
		}
		
		public function readExternal(input:IDataInput):void
		{
		}	
	}
}