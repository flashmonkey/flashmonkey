package org.flashmonkey.flash.multiplayer.inputhandlers 
{
	import org.as3commons.logging.ILogger;
	import org.as3commons.logging.LoggerFactory;
	import org.flashmonkey.flash.api.IAvatar;
	import org.flashmonkey.flash.api.IInput;
	import org.flashmonkey.flash.api.IState;
	import org.papervision3d.core.math.Matrix3D;
	import org.papervision3d.core.math.Number3D;
			

	/**
	 * @author Trevor
	 */
	public class SimpleAvatarInputHandler25D extends AbstractInputHandler
	{
		private static var logger:ILogger = LoggerFactory.getLogger("Paperworld");

		public var moveForwardAmount : Number = 1;

		public var moveBackAmount : Number = 1;

		public var moveRightAmount : Number = 1;

		public var moveLeftAmount : Number = 1;

		public var turnLeftAmount : Number = 1;

		public var turnRightAmount : Number = 1;		

		public function SimpleAvatarInputHandler25D()
		{
		}

		override public function apply(avatar : IAvatar) : void
		{		
			var input : IInput = avatar.input;
			var state : IState = avatar.state;
			
			var m:Matrix3D = Matrix3D.quaternion2matrix(state.orientation.x, state.orientation.y, state.orientation.z, state.orientation.w);
			m.n14 = state.position.x;
			m.n24 = state.position.y;
			m.n34 = state.position.z;
				
			if (input != null) 
			{
				if (input.moveForward)
				{
					translate(5, m, new Number3D(  0,  0,  1 ), state);
				}
				
				if (input.moveBackward)
				{
					translate(5, m, new Number3D( 0, 0, -1 ), state);
				}
				
				if (input.moveLeft)
				{
					translate(5, m, new Number3D( -1,  0,  0 ), state);
				}
				
				if (input.moveRight)
				{
					translate(5, m, new Number3D( 1,  0,  0 ), state);
				}
				
				if (input.yawPositive)
				{
					
				}
				
				if (input.yawNegative)
				{
					
				}
				
				/*if (input.moveForward)
					state.pz += moveForwardAmount;
					
				if (input.moveBackward)
					state.pz -= moveBackAmount;

				if (input.moveRight)
					state.px += moveRightAmount;

				if (input.moveLeft)
					state.px -= moveLeftAmount;

				if (input.yawPositive)
					state.ow += turnRightAmount;

				if (input.yawNegative)
					state.ow -= turnLeftAmount;*/
			}		
			
			super.apply( avatar );
		}
		
		protected function translate( distance:Number, transform:Matrix3D, axis:Number3D, state:IState ):void
		{
			//trace("before\n" + transform);
			Matrix3D.rotateAxis( transform, axis );
	
			transform.n14 += distance * axis.x;
			transform.n24 += distance * axis.y;
			transform.n34 += distance * axis.z;
			
			state.position.x = transform.n14;
			state.position.y = transform.n24;
			state.position.z = transform.n34;
			//trace("after\n" + transform);
		}
	}
}
