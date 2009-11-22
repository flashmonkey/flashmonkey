package org.flashmonkey.flash.pv3d.operations 
{	
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	
	import org.papervision3d.core.animation.channel.AbstractChannel3D;
	import org.papervision3d.objects.parsers.DAE;
	import org.springextensions.actionscript.mvcs.service.operation.AbstractOperation;
	
	/**
	 * @author Trevor
	 */
	public class DAEAnimationOperation extends AbstractOperation {
		protected var dae : DAE;

		protected var currentFrame:int = 0;
		
		protected var startFrame:int;
		
		protected var endFrame:int;
		
		protected var timer : Timer;

		protected var direction:int;
		
		protected var loop:Boolean;
		
		public var playing:Boolean;
		
		public function DAEAnimationOperation(dae:DAE, startFrame:int, endFrame:int, loop:Boolean = true)
		{
			super(this);
			
			this.dae = dae;
			this.startFrame = startFrame;
			this.endFrame = endFrame;
			this.loop = loop;
			
			direction = (endFrame > startFrame) ? 1 : -1;
		}
		
		override public function execute():void 
		{
			playing = true;
			
			currentFrame = startFrame - direction;
			
			timer = new Timer(10, 100000);
			timer.addEventListener(TimerEvent.TIMER, onTimer);
			timer.start();
		}
		
		protected function playFrame(frame:int):void 
		{
			
			var channels:Array = dae.getAnimationChannels();
			
			for each (var channel:AbstractChannel3D in channels)
			{
				channel.updateToFrame(frame);
			}
		}
		
		protected function onTimer(e:TimerEvent):void
		{
			if (currentFrame == endFrame)
			{
				onAnimationComplete();
				
				if (loop)
				{
					execute();
				}
				else
				{
					dispatchResult(this);
				}
			}
			else
			{
				currentFrame += direction;
				playFrame(currentFrame);
			}
		}
		
		public function stop():void 
		{
			playing = false;
			onAnimationComplete();
			dispatchResult(result);
		}
		
		protected function onAnimationComplete():void 
		{
			timer.stop();
			timer.removeEventListener(TimerEvent.TIMER, onTimer);
		}
	}
}
