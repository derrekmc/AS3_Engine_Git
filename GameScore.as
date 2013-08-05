package  {
	Display;
	import flash.utils.Timer;
	import flash.events.TimerEvent;
	public class GameScore {
		public static var enemiesKilled:int=0;
		public static var score:Number=0;
		public static var finalScore:Number=0;
			
		private static var t:Timer = new Timer(1000);
				
		public function GameScore() {
			// constructor code
			t.start();
			t.addEventListener(TimerEvent.TIMER, onTimer);
		}
		
		private function onTimer(e:TimerEvent):void{
			//subScore(100);
		}
		
		public static function getFinalScore(){
			return score;
		}
		
		public static function addScore(amount:Number=5){
			score += amount;
			
		}
		
		public static function subScore(amount:Number=5){
			if(score > amount){
				score -= amount;
			}
		}

	}
	
}
