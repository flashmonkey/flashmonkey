package org.flashmonkey.flash.api
{
	public class AvatarType
	{
		public static const REMOTE:AvatarType = new AvatarType("Remote");
		public static const LOCAL:AvatarType = new AvatarType("Local");
		
		private var _name:String;
		
		private static var _created:Boolean = false;
		
		{
			_created = true;
		}
		
		public function AvatarType(name:String) 
		{
	      	if (_created)
	      	{
	        	throw new Error("The enum is already created.");
	      	}
	      	
	     	 _name = name;
	    }


	}
}