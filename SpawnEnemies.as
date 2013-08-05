package {
		
	import flash.events.TimerEvent;
	import flash.geom.Point;
	import flash.events.Event;
	import Display;
	import Debug;
	import Global;
	import flash.utils.Timer;
	import Ghost;
	import Enemy;
	import World;
	
	public class SpawnEnemies extends SpawnPoint {
		
		private var amountUsed:Number = 0;
		 
		private var groupAmount:Number = 5;
		private var totalAmount:Number = 20;
			
		function SpawnEnemies(object:Obj, point:Point, group_amount:Number=20, total_amount:Number=100, tick:Number=5000){
			
			super(object, point, group_amount, Global.randRange(tick, tick*1.5));
			
			
		}
		
		
		override public function spawn(){
			//trace("Spawing Enemy");
				var en = new Enemy("zombie", "enemy.swf", -50);
				Display.screen.addChild();
				en.x = point.x;
				en.y = point.y;
				
			
		}
						
	}
	
}
