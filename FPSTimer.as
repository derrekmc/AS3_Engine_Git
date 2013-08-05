package{
	import flash.events.Event
	import flash.events.TimerEvent
	import flash.text.TextField
	import flash.utils.Timer

	public class FPSTimer extends TextField{
		
		public static var _fps:int = new int();
		public static var t:Timer = new Timer(1000);
		public static var fps:int = new int();
		public function FPSTimer():void{
			t.start();
			addEventListener(Event.ENTER_FRAME, onEnter);
			t.addEventListener(TimerEvent.TIMER, onTimer);
		}

		private function onEnter(e:Event):void{
			_fps++;
		}
		
		private function onTimer(e:TimerEvent):void{
			text = String(_fps);
			fps = _fps;
			_fps = 0;
		}
		
	}
}