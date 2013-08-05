package
{
	import flash.display.*;
	import fl.transitions.Tween;
	import fl.transitions.easing.*;
	import flash.utils.Timer;
	import flash.events.TimerEvent;
	import flash.display.MovieClip;
	
	public class EventWatcher extends MovieClip
	{
		
		var t:Timer;
		private var objectToWatch:Obj;
		private var watchParam:*;
		private var paramValueEquals:*;
		private var watchFunction:Function;
		
		public function EventWatcher(objectToWatch:Obj, watchParam:*, paramValueEquals:*, watchFunction:Function, ticks:Number=5){
			
				this.objectToWatch = objectToWatch;
				this.watchParam = watchParam;
				this.paramValueEquals = paramValueEquals;
				this.watchFunction = watchFunction;
				
				t = new Timer(ticks * 1000);
				t.addEventListener(TimerEvent.TIMER, updateTimer);
				t.start();
						
		}
		
		public function updateTimer(e:TimerEvent){
			//trace("Event Timer Tick");
			if(objectToWatch[watchParam].valueOf() >= paramValueEquals){
				trace(objectToWatch.name + "'s " + watchParam + " is " + paramValueEquals);
				t.stop();
				t.removeEventListener(TimerEvent.TIMER, updateTimer);
				watchFunction();
			}
			
			update();
		}
		
		public function update(){
			
		}
			
	}
			
}