package org.flashmonkey.flash.utils
{
	import flash.net.registerClassAlias;
	import flash.utils.IDataInput;
	import flash.utils.IDataOutput;
	import flash.utils.IExternalizable;
	
	import org.as3commons.reflect.ClassUtils;

	public class NetObject implements IExternalizable, IRegisteredClass
	{
		private static const FLASH_STRING:String = "flash";
		private static const JAVA_STRING:String = "java";
		
		private static var _registeredClasses:Array = [];
		
		/**
		 * Registers a class alias.
		 * If the class is already registered does nothing.
		 */
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
			if (_registeredClasses.indexOf(clazz) < 0)
			{
				_registeredClasses.push(clazz);
			
				return false;
			}
			
			return true;
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
			
			return className.split(FLASH_STRING).join(JAVA_STRING);		
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