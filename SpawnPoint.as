package {
		
	import flash.utils.Timer
	import flash.events.TimerEvent;
	import flash.geom.Point;
	import flash.events.Event;
	import Display;
	import Debug;
	import Global;
	import flash.events.EventDispatcher;
	import Obj;
	
	public class SpawnPoint extends Obj {
		
		public var point:Point;
		public var spawnTimer:Timer;
		public var objParams:Array;
		
		public var amountUsed:int = 0;
		public var currentAmount:int = 0;
		public var groupAmount:int = 5;
		public var totalAmount:int = 20;
		
		public var spawnedEntities:Array;
		public var spawnObj;
		
		public var delayTimer:Timer;
		
		public function SpawnPoint(spawnObj:Class, spawn_point:Point, group_amount:Number=20, total_amount:Number=100, tick:Number=5000){
			this.spawnObj	= spawnObj;
			this.objParams = new Array();
			this.point 				= spawn_point;
			this.groupAmount 		= group_amount;
			this.totalAmount 		= total_amount;
			this.x = spawn_point.x;
			this.y = spawn_point.y;
			
			//this.spawnObj			= new spawnObj(this.objParams);
			this.spawnedEntities	= new Array();
			spawnTimer 				= new Timer(tick);
			
			spawnTimer.addEventListener(TimerEvent.TIMER, _Spawn);
			Debug.print("spawn", Debug.OBJECT_DETAILS);
			
			super("spawn_point", "", "entity");
			
		}
		
		public function addEntityParams( ...objParams){
			this.objParams  = objParams;
			
		}
		
		override public function init(){
			
			spawnObj.x = this.x;
			spawnObj.y = this.y;
		}
		
		private function _Spawn(event:TimerEvent){
			
			if((spawnedEntities.length < groupAmount) && (amountUsed < totalAmount)){
				addEntity();
				Debug.print("spawn", Debug.OBJECT_DETAILS);
				//trace("spawnedEntities", spawnedEntities.length, groupAmount, amountUsed , totalAmount);
				this.dispatchEvent(new Event("spawn", true, true));
				spawn();
			}else{
				
				//trace("Maxed Out For Now");
				
			}
			
			for(var i =0; i < spawnedEntities.length; i++){
					if(!spawnedEntities[i].isAlive()){
						spawnedEntities.splice(i,1);
						Debug.print("Spawn Point Entity Died. Current entities remaining: " + spawnedEntities.length, Debug.OBJECT_DETAILS);
						//trace("Spawn Point Entity Died. Current entities remaining: " + spawnedEntities.length);
					}
				}
			
			
		}
		
		private function addEntity(){									
			var entity = new spawnObj(objParams[0], objParams[1], objParams[2], objParams[3]);
			
			Display.world.add(entity ,point.x - Global.randRange(10, 20),point.y ,true);
			//entity.init();
			spawnedEntities.push(entity);
			amountUsed++;
			//trace(amountUsed);
		}
		
		public function spawn(){
			//trace("spawnClass");
		}
		
		public function startSpawn(delay:int=0){
			if(delay == 0){
				//trace("delay = 0");
				_startSpawn(new TimerEvent("startSpawn"));
			}else{
				//trace("delay != 0::", delay);
				delayTimer = new Timer(delay * 1000, 1);
				delayTimer.addEventListener(TimerEvent.TIMER_COMPLETE, _startSpawn);
				delayTimer.start();
			}
			
			
		}
		
		public function set currentSpawnTick(newTickDelay:int){
			spawnTimer.delay = newTickDelay;
		}
		
		public function get currentSpawnTick(){
			return spawnTimer.delay;
		}
		
		public function _startSpawn(evt:TimerEvent){
			delayTimer.stop();
			//trace("_startSpaw");
			addEntity();
			spawnTimer.start();	
			
		}
		
		public function stopSpawn(){
			Debug.print("SpawnPoint Stopped", Debug.OBJECT_DESTROY);
			spawnTimer.stop();	
		}
						
	}
	
}
