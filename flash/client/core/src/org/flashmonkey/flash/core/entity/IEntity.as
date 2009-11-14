package org.flashmonkey.flash.core.entity
{
	public interface IEntity
	{
	function get name():String;
		
	 function addComponent(component:IComponent):void;
		
 function removeComponet(component:IComponent):void;
		
	 function getComponentByName(name:String):IComponent;
		
		 function getComponentByType(type:Class):IComponent;
	}
}