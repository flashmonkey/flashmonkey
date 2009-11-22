package org.flashmonkey.flash.pv3d.behaviours
{
	import org.flashmonkey.flash.api.IAvatar;
	import org.flashmonkey.flash.api.IBehaviour;
	import org.flashmonkey.flash.api.IInput;
	import org.flashmonkey.flash.pv3d.operations.DAEAnimationOperation;
	import org.papervision3d.objects.parsers.DAE;		

	/**
	 * @author Trevor
	 */
	public class AnimatedDAEBehaviour implements IBehaviour 
	{
		public static const RUN_FORWARD_ANIMATION:Array = [0,30];
		public static const RUN_BACKWARD_ANIMATION:Array = [40,70];
		public static const WALK_FORWARD_ANIMATION:Array = [80,110];
		public static const WALK_BACKWARD_ANIMATION:Array = [120,150];
		public static const STRAFE_RIGHT:Array = [160,190];
		public static const STRAFE_LEFT:Array = [190,220];
		public static const JUMP:Array = [230,260];
		public static const BULLET_HIT:Array = [260,270];
		public static const FIRE:Array = [270,290];
		public static const RELOAD:Array = [300,370];
		public static const DEATH_01:Array = [380,430];
		public static const DEATH_02:Array = [440,500];
		public static const IDLE:Array = [510,650];
		public static const CROUCH_FORWARD:Array = [680,720];
		public static const CROUCH_BACKWARD:Array = [730,770];

		private var _walkForwardAnimation : DAEAnimationOperation;

		private var _idleAnimation : DAEAnimationOperation;
		
		private var _walkBackwardAnimation : DAEAnimationOperation;
		
		private var _strafeRightAnimation : DAEAnimationOperation;
		
		private var _stafeLeftAnimation : DAEAnimationOperation;

		private var _animations : Array = [];

		public function set dae(value : DAE) : void {
			_walkForwardAnimation = new DAEAnimationOperation(value, WALK_FORWARD_ANIMATION[0], WALK_FORWARD_ANIMATION[1]);
			_animations.push(_walkForwardAnimation);
			
			_idleAnimation = new DAEAnimationOperation(value, IDLE[0], IDLE[1]);
			_animations.push(_idleAnimation);
			
			_walkBackwardAnimation = new DAEAnimationOperation(value, WALK_BACKWARD_ANIMATION[0], WALK_BACKWARD_ANIMATION[1]);
			_animations.push(_walkBackwardAnimation);
			
			_strafeRightAnimation = new DAEAnimationOperation(value, STRAFE_RIGHT[0], STRAFE_RIGHT[1]);
			_animations.push(_strafeRightAnimation);
			
			_stafeLeftAnimation = new DAEAnimationOperation(value, STRAFE_LEFT[0], STRAFE_LEFT[1]);
			_animations.push(_stafeLeftAnimation);
		}

		public function AnimatedDAEBehaviour(dae : DAE) {
			super();
			
			this.dae = dae;
		}

	    public function apply(avatar : IAvatar) : void 
	    {
			
			var input : IInput = avatar.input;
			
			if (input.moveForward && !_walkForwardAnimation.playing) {
				stopIdle();
				_walkForwardAnimation.execute();						
			}
			
			if (!input.moveForward && _walkForwardAnimation.playing) {
				_walkForwardAnimation.stop();				
			}
			
			if (input.moveBackward && !_walkBackwardAnimation.playing) {
				stopIdle();
				_walkBackwardAnimation.execute();						
			}
			
			if (!input.moveBackward && _walkBackwardAnimation.playing) {
				_walkBackwardAnimation.stop();				
			}
			
			if (input.moveLeft && !_stafeLeftAnimation.playing) {
				stopIdle();
				_stafeLeftAnimation.execute();						
			}
			
			if (!input.moveLeft && _stafeLeftAnimation.playing) {
				_stafeLeftAnimation.stop();				
			}
			
			if (input.moveRight && !_strafeRightAnimation.playing) {
				stopIdle();
				_strafeRightAnimation.execute();						
			}
			
			if (!input.moveRight && _strafeRightAnimation.playing) {
				_strafeRightAnimation.stop();				
			}
			
			if (!input.moveForward && !input.moveBackward && !input.moveLeft && !input.moveRight && !input.yawNegative && !input.yawPositive) {
				if (!_idleAnimation.playing) {
					
					stopAllAnimations();
					_idleAnimation.execute();
				}
			}
		}

		private function stopIdle() : void {
			if (_idleAnimation.playing) {
				_idleAnimation.stop();
			}
		}

		private function stopAllAnimations() : void {
			for each (var animation:DAEAnimationOperation in _animations) {
				if (animation.playing) {
					animation.stop();
				}
			}
		}
	}
}
