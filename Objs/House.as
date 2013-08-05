package Objs {
	
	import Obj;
	import flash.events.TimerEvent;
	import Emitter;
	import flash.geom.Point;
	import flash.filters.BitmapFilter;
	import flash.filters.BitmapFilterQuality;
	import flash.filters.BlurFilter;
	import flash.display.BlendMode;
	import particles2.Flames;
	import HealthBar;
	import SpawnPoint;
	import flash.events.Event;
	import Enemy;

	public class House extends Obj{
		var spawnEnemy:SpawnPoint;
		var instructions;
		var timeTillNextIncrease:int = 100;
		var currentTime:int = 0;
		public var healthBar:HealthBar;
		var smoke:ParticleSystem;
		public function House(filename:String, offSetX:Number=0, offSetY:Number=0){
			// constructor code
			super("house", filename, "structure", offSetX, offSetY, "POINT");
			
			this.life = this.origLife = 3000;
			//playFrame("health", "glow");
			
			soundFx = new PlaySound("building_on_fire_wood_burning_glass_breaking_and_other_debris_falling.mp3");
		}
		
		override public function onAppear(){
			healthBar = new HealthBar(this.life, 0, -50, this.width, 30);
			this.addChild(healthBar);
			
			watch();
			smoke = new ParticleSystem("smoke", 240, 20, 12, true);
			this.addChild(smoke);
			spawnEnemy = new SpawnPoint(Enemy, new Point(this.x+250, this.y+210), 6, 40, 3000);
			//trace("boo",this.x+250, this.y+190);
			spawnEnemy.addEntityParams("enemy", "enemy.swf", - 50);
			spawnEnemy.startSpawn(25);
			spawnEnemy.addEventListener("spawn", openDoor);
			instructions = new Obj("spawn_point_instructions", "spawn_point.png");
			Display.addchild(instructions);
			
			if(instructions){
				instructions.x = this.x-instructions.width/2;
				instructions.y = this.y-120;
			}
		}
		
		public function openDoor(event:Event){
			playFrame("house", "openDoor");
		}
		
		override public function update(){
				
				if(currentTime < timeTillNextIncrease){
					currentTime++;
					//trace("spawn Ticks: " + spawnEnemy.currentSpawnTick);
				}else{
					currentTime = 0;
					if(spawnEnemy.currentSpawnTick > 1000){
						spawnEnemy.currentSpawnTick -= 100;
					}
					
				}
				
				healthBar.updateHealth(this.life);
				var particle:Flames;
				var i=0;
				if(this.dying == true){
					Display.cam.shake(5, 20);
					//trace(this.life , (this.origLife/4));
					for(i=0 ; i< 2; i++){						
						particle = new Flames(new Point(Global.randRange(74, width-150), Global.randRange(60,  height - 180)));
						particle.scaleX = particle.scaleY += Global.randRange(0.2, 0.6);
						this.addChild(particle);		
					}					
					this.soundFx.play(1, Global.SOUND_LVL_SOUND_EFFECTS);					
					
				
				}else if(this.life < (this.origLife*.25)){
					//trace(this.life , (this.origLife*.25));
					for(i=0 ; i< 3; i++){
						particle = new Flames(new Point(Global.randRange(74, width-150), Global.randRange(60,  height - 180)));
						this.addChild(particle);
					}
				}else if(this.life < (this.origLife*.50)){
					//trace(this.life , (this.origLife*.50));
					for(i=0 ; i< 2; i++){
						particle = new Flames(new Point(Global.randRange(74, width-150), Global.randRange(60,  height - 180)));						
						this.addChild(particle);
						
					}
				}else if(this.life < (this.origLife*.75)){
					//trace(this.life , (this.origLife*.75));
					for(i=0 ; i< 1; i++){
						particle = new Flames(new Point(Global.randRange(74, width-150), Global.randRange(60,  height - 180)));
						this.addChild(particle);
					}
				}
		}
		
		override public function damaged(){
			GameScore.addScore();
			//this.shake(3, 5);
			
		}
		
		override public function kill(){
			this.soundFx = new PlaySound("explosion_medium_brick_wood_and_glass_debris.mp3");
			soundFx.play();
			//blendMode = BlendMode.ADD;
			var dieTime = Global.randRange(8, 10);
			this.shake(dieTime,5)
			this.smoke.kill();
			//filters = [new BlurFilter(4, 4,BitmapFilterQuality.HIGH)];
			//this.removeFromCollisionList();
			spawnEnemy.stopSpawn();
			instructions.kill();
			die(dieTime);
						
			
		}
		
		override public function deconstruct():void{
			//this.soundFx.stop();
			//soundFx = null;
		}
		
		override public function interact(obj:Obj):void{
			//if(this.canGrab){ // if grabables
				
			//}
		}
		
		override public function boxBound(object:Obj){			
			
		}
		
		override public function topBound(object:Obj){			
				
		}
						
		override public function bottomBound(object:Obj){
			
		}
		
		override public function leftBound(object:Obj){
			
		}
		
		override public function rightBound(object:Obj){
		
		}
		
				
	}
	
}
