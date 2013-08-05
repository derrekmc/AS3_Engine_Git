package {
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.utils.Timer.TimerEvent;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.display.BlendMode;
	import flash.events.Event;
	import flash.utils.Timer;
	
	import Obj;
	import Display;
	import Debug;
	import Global;
	import KeyHandler;
	import camera;
	
	public class SpawnEnemys extends Spawn {
		
		public var point:Point;
		public var timer:Timer;
		
		function SpawnEnemys(amount:Number=0, tick:Number=1000){
			point = spawn_point;
			spawnObj = new spawnClass();
			timer.addEventListener(TimerEvent.TIMER, Spawn, false, 0, true);
			timer = new Timer(tick, amount);
			timer.start();
		
		}
		
		function Spawn(){
			for(var i = 0; i< 20 ;i++){
				world.add(new Obj("bridge", path + "bridge2.png", "floor"), true, point.x, point.y);			
			}
		}
						
	}
	
}
