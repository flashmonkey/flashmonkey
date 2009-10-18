package org.flashmonkey.flash.api
{
	import flash.utils.IExternalizable;
	
	import org.flashmonkey.flash.utils.math.Quaternion;
	import org.flashmonkey.flash.utils.math.Vector3f;
	
	public interface IState extends IExternalizable
	{
		function get position():Vector3f;		
		function set position(value:Vector3f):void;
		
		function get orientation():Quaternion;
		function set orientation(value:Quaternion):void;
		
		function clone():IState;
		function equals(other:IState):Boolean;
		function notEquals(other:IState):Boolean;
		function compare(other:IState):Boolean;
	}
}