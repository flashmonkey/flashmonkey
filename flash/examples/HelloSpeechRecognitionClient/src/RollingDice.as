package
{
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.utils.setTimeout;

	public class RollingDice extends Sprite
	{
		[Embed(source="Dice.swf", symbol="Dice")]
      	private var Dice:Class;
      	
      	private var die:MovieClip;
      	
      	private var stopping:Boolean = false;
      
		public function RollingDice()
		{
			super();
			
			die = new Dice() as MovieClip;
			addChild(die);
			scaleX = scaleY = 3;
			addEventListener(Event.ENTER_FRAME, roll);
		}
		
		public function roll(e:Event):void 
		{
			trace(stopping + " " + rotation);
			if (stopping && rotation == 0)
			{
				removeEventListener(Event.ENTER_FRAME, roll);
			}
			else
			{
				rotation += 90;
			}
		}
		
		public function setDots(dots:Number):void
		{
			MovieClip(die.getChildAt(1)).gotoAndStop(dots);
		}
		
		public function setColour(colour:Number):void 
		{
			MovieClip(die.getChildAt(0)).gotoAndStop(colour);
		}
		
		public function setDelay(delay:Number):void 
		{
			setTimeout(stop, delay);
		}
		
		private function stop():void 
		{
			stopping = true;
		}
	}
}