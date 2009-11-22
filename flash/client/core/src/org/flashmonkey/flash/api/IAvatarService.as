package org.flashmonkey.flash.api
{
	import com.joeberkovitz.moccasin.service.IOperation;
	
	import org.flashmonkey.flash.api.ISynchronisedObject;
	

	/**
	 * @author Trevor
	 */
	public interface IAvatarService 
	{
		function getAvatar(type:AvatarType, properties : Object) : IOperation;
		
		function getAvatarAsync(type:AvatarType, properties:Object):IOperation;
		
		function getSynchronisedObject(type:AvatarType, properties:Object):IOperation;
		
		function getDisplayObject(type:AvatarType, properties:Object):IOperation;
	}
}
