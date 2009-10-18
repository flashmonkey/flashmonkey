package org.flashmonkey.flash.core.objects
{
	import flash.utils.IDataInput;
	import flash.utils.IDataOutput;
	
	import org.flashmonkey.flash.api.IState;
	import org.flashmonkey.flash.utils.IRegisteredClass;
	import org.flashmonkey.flash.utils.NetObject;
	import org.flashmonkey.flash.utils.math.Quaternion;
	import org.flashmonkey.flash.utils.math.Vector3f;
	
	public class BasicState extends NetObject implements IState, IRegisteredClass
	{	
		private var _position:Vector3f = new Vector3f();
		
		public function get position():Vector3f
		{			
			return _position;
		}
		
		public function set position(value:Vector3f):void 
		{
			_position = value;
		}
		
		private var _orientation:Quaternion = new Quaternion();
		
		public function get orientation():Quaternion
		{			
			return _orientation;
		}
		
		public function set orientation(value:Quaternion):void
		{
			_orientation = value;
		}
		
		public function set px(value:Number):void
		{
			_position.x = value;
		}
		
		public function set py(value:Number):void
		{
			_position.y = value;
		}
		
		public function set pz(value:Number):void
		{
			_position.z = value;
		}
		
		public function set ox(value:Number):void
		{
			_orientation.x = value;
		}
		
		public function set oy(value:Number):void
		{
			_orientation.y = value;
		}
		
		public function set oz(value:Number):void
		{
			_orientation.z = value;
		}
		
		public function set ow(value:Number):void
		{
			_orientation.w = value;
		}
		
		public function BasicState()
		{			
			NetObject.registerClass(this);
		}
		
		public function clone():IState
		{
			var state:BasicState = new BasicState();
			state.position = _position.clone();
			state.orientation = _orientation.clone();
			
			return state;
		}
		
		public function destroy():void 
		{
			
		}
		
		public function compare(other:IState):Boolean
		{
			return false;
		}
		
		public function equals(other:IState):Boolean
		{
			return false;
		}
		
		public function notEquals(other:IState):Boolean
		{
			return !equals(other);
		}
		
		override public function writeExternal(output:IDataOutput):void
		{
			output.writeFloat(_position.x);
			output.writeFloat(_position.y);
			output.writeFloat(_position.z);

			output.writeFloat(_orientation.x);
			output.writeFloat(_orientation.y);
			output.writeFloat(_orientation.z);
			output.writeFloat(_orientation.w);
		}
		
		/**
		 * @inheritDoc
		 */
		override public function readExternal(input:IDataInput):void
		{			
			px = input.readFloat();
			py = input.readFloat();
			pz = input.readFloat();
			
			ox = input.readFloat();
			oy = input.readFloat();
			oz = input.readFloat();
			ow = input.readFloat();
		}
	}
}