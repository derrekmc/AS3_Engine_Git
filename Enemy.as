package  {
	import Obj;
	//import flash.events.*;
	import Debug;
	import Display;
	import flash.ui.Keyboard;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	
	//import AI;
	import flash.utils.Timer;
	import flash.events.TimerEvent;
	//import particles.Flame;
	import flash.geom.Point;
	//import particles2.Particle;
	import particles2.Sparks;
	import particles2.Flames;
	import flash.filters.BitmapFilter;
	import flash.filters.BitmapFilterQuality;
	import flash.filters.BlurFilter;
	import flash.display.BlendMode;
	
	
	public class Enemy extends Obj{
		var burnEffect:PlaySound;
		var painEffect:PlaySound;
		var jumped:Boolean;
		var _particles:int;
		
		public function Enemy(name:String="enemy1", filename="enemy.swf", offSetX=-50, offSetY=0 ):void {
			
			super(name, filename, "enemy", offSetX, offSetY, "POINT");
			if(!burnEffect)burnEffect = new PlaySound("dry_weeds_and_grass_burning.mp3");
			if(!painEffect)painEffect = new PlaySound("scream_pain_male.mp3");
			//soundFx = new PlaySound("zombie_walk.mp3");
		}
		
		override public function init(){
			//trace("enemy init");
			
			downBumpPoint 	= new Point(offSetX + (this.width/2), offSetY + this.height-(this.height * .2));
			//playFrame("stickman", "appear"); // appear
			follow(Display.player);
			
			this.xspeed = this.speed = Global.randRange(0.6, .9);//min 0.55
			this.attackStrength = 5;
			this.mass = this.radius * 10;
			
			this.grounded = true;
			this.jumped = false;			
			//this.friction = 0.2;
			//this.soundFx.play(1, Global.SOUND_LVL_SOUND_EFFECTS);
			watch();
		}
		
		override public function update(){
			
			if(Math.abs(this.vx) > 1.0){
				playFrame("stickman", "run"); 
			}
			
			//if(this.isCloseTo(Display.player, 100)){
				//playFrame("stickman", "attack"); 
			//}
			
			this.xspeed = this.speed * this.direction;
			if(this.dying == true ){
				playFrame("stickman", "run");			
				
				//if(this._particles < 30) {
				//
				/*
					var particle:Sparks = new Sparks(new Point(this.x+20, this.y+20));
					Display.screen.addChild(particle);
					_particles++;
					
					*/
					var particle:Flames = new Flames(new Point(this.x, this.y+height -20));
					Display.screen.addChild(particle);
					_particles++;
					
					
				//}
				//stopWatching();
			}
			
			
			
			var enableEnemyCollision = true;
			if(enableEnemyCollision == true){
				var enemie = objects;
				//Display.hud.text1.text= objects.length;
				for(var j:int = 0; j < enemie.length; j++)	{		
					if(enemie[j] != this  && enemie[j].type=="enemy"){ // &&  Math.abs(enemie[j].xspeed) < Math.abs(this.xspeed)){
						if(this.checkCollisionWith(enemie[j])){								
							break; 								
						}
					}						
				}
			}						
		}
		
		/*function updateEnemy(){
			if(this.life < 1 ) this.destroy();
		}*/
		
		override public function kill(){
			GameScore.enemiesKilled++;
			painEffect.play();
			
			
			//burnEffect.play();
			
			this.speed += Global.randRange(0.6, .9);
			GameScore.addScore(2000);
			this.removeFromCollisionList(enemies);
			//filters = [new BlurFilter(3,3,BitmapFilterQuality.HIGH)];
			die(2);			
		}
		
		
		
		override public function interact(obj:Obj):void{		
			if(obj.type == "player") this.damage(obj);
		}
		
		override public function boxBound(object:Obj){			
			//trace("box bound enemy");
			bringToGround(object);
		}
		
		
		
		override public function leftBound(object:Obj){
			if(this.vx < 0){
				var dif = this.diff(object.x + object.width, this.x );
				//trace(dif, this.leftBumpPoint.x, this.rightBumpPoint.x);
				//if(this.type=="player")trace(dif);
				this.vx += dif  * 0.2;
				//this.x = object.x + object.width ;
				this.turnAround();
			}
			
		}
		
		override public function rightBound(object:Obj){
			if(this.vx > 0){
				var dif = this.diff(object.x, this.x + rightBumpPoint.x);
				//if(this.type=="player")trace(dif);
				this.vx -= dif * 0.2;
				//this.x = object.x - this.width;
				this.turnAround();
			}
		}
		
		override public function bottomBound(object:Obj){
			bringToGround(object);
		}
		
		override public function deconstruct():void{
			burnEffect.stop();
			burnEffect = null;
			painEffect.stop();
			painEffect = null;
			//soundFx.stop();
		}
		
		
		

	}
	
}
