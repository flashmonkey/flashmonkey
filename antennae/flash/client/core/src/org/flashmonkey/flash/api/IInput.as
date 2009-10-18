package org.flashmonkey.flash.api
{
	public interface IInput
	{
		function get moveForward():Boolean;
		
		function set moveForward(value:Boolean):void;
		
		function get moveBackward():Boolean;
		
		function set moveBackward(value:Boolean):void;
		
		function get moveLeft():Boolean;
		
		function set moveLeft(value:Boolean):void;
		
		function get moveRight():Boolean;
		
		function set moveRight(value:Boolean):void;
		
		function get moveUp():Boolean;
		
		function set moveUp(value:Boolean):void;
		
		function get moveDown():Boolean;
		
		function set moveDown(value:Boolean):void;
		
		function get pitchPositive():Boolean;
		
		function set pitchPositive(value:Boolean):void;
		
		function get pitchNegative():Boolean;
		
		function set pitchNegative(value:Boolean):void;
		
		function get rollPositive():Boolean;
		
		function set rollPositive(value:Boolean):void;
		
		function get rollNegative():Boolean;
		
		function set rollNegative(value:Boolean):void;
		
		function get yawPositive():Boolean;
		
		function set yawPositive(value:Boolean):void;
		
		function get yawNegative():Boolean;
		
		function set yawNegative(value:Boolean):void;
		
		function get fire():Boolean;
		
		function set fire(value:Boolean):void;
		
		function get jump():Boolean;
		
		function set jump(value:Boolean):void;
		
		function get mouseX():Number;
		
		function set mouseX(value:Number):void;
		
		function get mouseY():Number;
		
		function set mouseY(value:Number):void;
		
		function equals(other:IInput):Boolean;
		
		function notEquals(other:IInput):Boolean;
		
		function clone():IInput;
		
		function copyFrom(other:IInput):void;
	}
}