/* --------------------------------------------------------------------------------------
 * PaperWorld3D - building better worlds
 * --------------------------------------------------------------------------------------
 * Real-Time Multi-User Application Framework for the Flash Platform.
 * --------------------------------------------------------------------------------------
 * Copyright (C) 2008 Trevor Burton [worldofpaper@googlemail.com]
 * --------------------------------------------------------------------------------------
 * 
 * This library is free software; you can redistribute it and/or modify it under the 
 * terms of the GNU Lesser General Public License as published by the Free Software 
 * Foundation; either version 2.1 of the License, or (at your option) any later version.
 *
 * This library is distributed in the hope that it will be useful, but WITHOUT ANY 
 * WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A 
 * PARTICULAR PURPOSE. See the GNU Lesser General Public License for more details.
 *
 * You should have received a copy of the GNU Lesser General Public License along with 
 * this library; if not, write to the Free Software Foundation, Inc., 59 Temple Place, 
 * Suite 330, Boston, MA 02111-1307 USA 
 * 
 * -------------------------------------------------------------------------------------- */
package org.flashmonkey.flash.utils.input 
{
	import flash.utils.IDataInput;
	import flash.utils.IDataOutput;
	import flash.utils.IExternalizable;
	
	import org.flashmonkey.flash.api.IInput;
	import org.flashmonkey.flash.utils.IRegisteredClass;
	import org.flashmonkey.flash.utils.NetObject;

	/**
	 * @author Trevor Burton [worldofpaper@googlemail.com]
	 */
	public class Input extends NetObject implements IInput
	{		
		public static const MOVE_FORWARD:String = "moveForward";
		
		private var _moveForward:Boolean;
		
		public function get moveForward():Boolean
		{
			return _moveForward;
		}
		
		public function set moveForward(value:Boolean):void
		{
			_moveForward = value;
		}
		
		public static const MOVE_BACKWARD:String = "moveBackward";
		
		private var _moveBackward:Boolean;
		
		public function get moveBackward():Boolean
		{
			return _moveBackward;
		}
		
		public function set moveBackward(value:Boolean):void
		{
			_moveBackward = value;
		}
		
		public static const MOVE_LEFT:String = "moveLeft";
		
		private var _moveLeft:Boolean;
		
		public function get moveLeft():Boolean
		{
			return _moveLeft;
		}
		
		public function set moveLeft(value:Boolean):void
		{
			_moveLeft = value;
		}
		
		public static const MOVE_RIGHT:String = "moveRight";
		
		private var _moveRight:Boolean;
		
		public function get moveRight():Boolean
		{
			return _moveRight;
		}
		
		public function set moveRight(value:Boolean):void
		{
			_moveRight = value;	
		}
		
		public static const MOVE_UP:String = "moveUp";
		
		private var _moveUp:Boolean;
		
		public function get moveUp():Boolean
		{
			return _moveUp;
		}
		
		public function set moveUp(value:Boolean):void
		{
			_moveUp = value;
		}
		
		public static const MOVE_DOWN:String = "moveDown";
		
		private var _moveDown:Boolean;
		
		public function get moveDown():Boolean
		{
			return _moveDown;
		}
		
		public function set moveDown(value:Boolean):void
		{
			_moveDown = value;
		}
		
		public static const PITCH_POSITIVE:String = "pitchPositive";
		
		private var _pitchPositive:Boolean;
		
		public function get pitchPositive():Boolean
		{
			return _pitchPositive;
		}
		
		public function set pitchPositive(value:Boolean):void
		{
			_pitchPositive = value;
		}
		
		public static const PITCH_NEGATIVE:String = "pitchNegative";
		
		private var _pitchNegative:Boolean; 
		
		public function get pitchNegative():Boolean
		{
			return _pitchNegative;
		}
		
		public function set pitchNegative(value:Boolean):void
		{
			_pitchNegative = value;
		}
		
		public static const ROLL_POSITIVE:String = "rollPositive";
		
		private var _rollPositive:Boolean; 
		
		public function get rollPositive():Boolean
		{
			return _rollPositive;
		}
		
		public function set rollPositive(value:Boolean):void
		{
			_rollPositive = value;
		}
		
		public static const ROLL_NEGATIVE:String = "rollNegative";
		
		private var _rollNegative:Boolean; 
		
		public function get rollNegative():Boolean
		{
			return _rollNegative;
		}
		
		public function set rollNegative(value:Boolean):void
		{
			_rollNegative = value;
		}
		
		public static const YAW_POSITIVE:String = "yawPositive";
		
		private var _yawPositive:Boolean; 
		
		public function get yawPositive():Boolean
		{
			return _yawPositive;
		}
		
		public function set yawPositive(value:Boolean):void
		{
			_yawPositive = value;
		}
		
		public static const YAW_NEGATIVE:String = "yawNegative";
		
		private var _yawNegative:Boolean; 
		
		public function get yawNegative():Boolean
		{
			return _yawNegative;
		}
		
		public function set yawNegative(value:Boolean):void
		{
			_yawNegative = value;
		}
		
		public static const FIRE:String = "fire";
		
		private var _fire:Boolean; 
		
		public function get fire():Boolean
		{
			return _fire;
		}
		
		public function set fire(value:Boolean):void
		{
			_fire = value;
		}
		
		public static const JUMP:String = "jump";
		
		private var _jump:Boolean; 
		
		public function get jump():Boolean
		{
			return _jump;
		}
		
		public function set jump(value:Boolean):void
		{
			_jump = value;
		}
		
		private var _mouseX:Number;
		
		public function get mouseX():Number
		{
			return _mouseX;
		}
		
		public function set mouseX(value:Number):void
		{
			_mouseX = value;
		}
		
		private var _mouseY:Number;
		
		public function get mouseY():Number
		{
			return _mouseY;
		}
		
		public function set mouseY(value:Number):void
		{
			_mouseY = value;
		}

		public function Input(moveForward : Boolean = false, moveBackward : Boolean = false, 
							  moveRight : Boolean = false, moveLeft : Boolean = false, 
							  moveUp : Boolean = false, moveDown : Boolean = false, 
							  pitchNegative : Boolean = false,	pitchPositive : Boolean = false,
							  rollNegative : Boolean = false, rollPositive : Boolean = false,
							  yawNegative : Boolean = false, yawPositive : Boolean = false, 
							  fire : Boolean = false, jump : Boolean = false,
							  mouseX : Number = 0, mouseY : Number = 0)
		{
			super();
						
			_moveForward 		= moveForward;
			_moveBackward 		= moveBackward;
			_moveRight 			= moveRight;
			_moveLeft 			= moveLeft;
			_moveUp 			= moveUp;
			_moveDown 			= moveDown;
			_pitchNegative 		= pitchNegative;
			_pitchPositive 		= pitchPositive;
			_rollNegative 		= rollNegative;
			_rollPositive 		= rollPositive;
			_yawNegative 		= yawNegative;
			_yawPositive 		= yawPositive;
			_fire 				= fire;
			_jump 				= jump;
			_mouseX				= mouseX;
			_mouseY				= mouseY;
			
			NetObject.registerClass(this);
		}

		public function clone() : IInput
		{
			return new Input( _moveForward, _moveBackward, 
							 _moveRight, _moveLeft, 
							 _moveUp, _moveDown, 
							 _pitchNegative, _pitchPositive, 
						 	 _rollNegative, _rollPositive, 
							 _yawNegative, _yawPositive, 
							 _fire, _jump,
							 _mouseX, _mouseY);
		}

		public function destroy() : void
		{

		}

		public function equals(other : IInput) : Boolean
		{
			return  _moveForward 	== other.moveForward && 
					_moveBackward 	== other.moveBackward && 
					_moveRight 		== other.moveRight && 
					_moveLeft 		== other.moveLeft && 
					_moveUp 		== other.moveUp && 
					_moveDown 		== other.moveDown && 
					_pitchNegative 	== other.pitchNegative && 
					_pitchPositive 	== other.pitchPositive && 
					_rollNegative 	== other.rollNegative && 
					_rollPositive 	== other.rollPositive && 
					_yawNegative 	== other.yawNegative && 
					_yawPositive 	== other.yawPositive && 
					_fire 			== other.fire && 
					_jump 			== other.jump &&
					_mouseX			== other.mouseX;
		}

		public function notEquals(other : IInput) : Boolean
		{
			return !equals( other );	
		}

		public function copyFrom(other : IInput) : void
		{
			_moveForward 	= other.moveForward;
			_moveBackward 	= other.moveBackward; 
			_moveRight 		= other.moveRight; 
			_moveLeft 		= other.moveLeft;
			_moveUp 		= other.moveUp;
			_moveDown 		= other.moveDown; 
			_pitchNegative 	= other.pitchNegative;
			_pitchPositive 	= other.pitchPositive;
			_rollNegative 	= other.rollNegative; 
			_rollPositive 	= other.rollPositive;
			_yawNegative 	= other.yawNegative; 
			_yawPositive 	= other.yawPositive; 
			_fire 			= other.fire; 
			_jump 			= other.jump;
			_mouseX			= other.mouseX;
			_mouseY			= other.mouseY;
		}
		
		override public function writeExternal(output:IDataOutput):void
		{
			output.writeBoolean(_moveForward);
			output.writeBoolean(_moveBackward);
			output.writeBoolean(_moveRight);
			output.writeBoolean(_moveLeft);
			output.writeBoolean(_moveUp);
			output.writeBoolean(_moveDown);
			output.writeBoolean(_pitchNegative);
			output.writeBoolean(_pitchPositive);
			output.writeBoolean(_rollNegative);
			output.writeBoolean(_rollPositive);
			output.writeBoolean(_yawNegative);
			output.writeBoolean(_yawPositive);
			output.writeBoolean(_fire);
			output.writeBoolean(_jump);
			output.writeFloat(_mouseX);
			output.writeFloat(_mouseY);
		}
		
		/**
		 * @inheritDoc
		 */
		override public function readExternal(input:IDataInput):void
		{
			_moveForward = input.readBoolean();
			_moveBackward = input.readBoolean();
			_moveRight = input.readBoolean();
			_moveLeft = input.readBoolean();
			_moveUp = input.readBoolean();
			_moveDown = input.readBoolean();
			_pitchNegative = input.readBoolean();
			_pitchPositive = input.readBoolean();
			_rollNegative = input.readBoolean();
			_rollPositive = input.readBoolean();
			_yawNegative = input.readBoolean();
			_yawPositive = input.readBoolean();
			_fire = input.readBoolean();
			_jump = input.readBoolean();
			_mouseX = input.readFloat();
			_mouseY = input.readFloat();
		}
	}
}
