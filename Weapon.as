package{
	import Obj;
	import fl.transitions.Tween;
	import fl.transitions.easing.*;
	import flash.filters.BitmapFilter;
	import flash.filters.BitmapFilterQuality;
	import flash.filters.BlurFilter;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Point;

	import particles2.Particle;
	import flash.utils.Timer;
	import flash.events.TimerEvent;
	
	import PlaySound;
		
	public class Weapon extends Emitter{
		
		public var bulletAsset;
		public var weaponDropTimer:Timer;
		public var firing:Boolean = false;
		public var pickupSoundFx:PlaySound ;
		
		public function Weapon(name:String="weapon", filename:String="flame_gun.swf", sfxFilename:String="flames.mp3", offSetX:int=0, offSetY:int=0){
			super(name, filename, "weapon", 0, offSetX, offSetY, false, "POINT");
			soundFx = new PlaySound(sfxFilename);
			//filters = [new BlurFilter(0, 4, BitmapFilterQuality.HIGH)];
		   	//this.blendMode = BlendMode.ADD;
		}		
		
		override public function interact(obj:Obj):void{
			
			firing = true;
			shoot();			
			if(this.soundFx) this.soundFx.play(1, Global.SOUND_LVL_SOUND_EFFECTS);
		}
		
		public function shoot(){		
			
			//Display.player.shake(1, 2);					
		}	
		
		public function shootingStopped(){		
			//Display.player.shake(1, 2);		
			//trace("shootingStopped");
			soundFx.stop();
			
		}	
		
		override protected function _update(){
			//trace("update");
			if(this._particles.length < 1 && firing == true){
				firing = false;
				this.shootingStopped();
			}
		}
		
		public function particleLifeCycle(p:Particle){
			
			
			var bullet = p;
			// loop through the array of particles and update each one
			
					var enemies = enemies;
					
					for(var j:int = 0; j < enemies.length; j++)	{		
					
						if(enemies[j] != Display.world.player && enemies[j].dying != true){
							
							if(enemies[j].isOnScreen){
								
								if(bullet.checkCollisionWith(enemies[j])){
									//trace("enemies.length"+enemies.length);
									bullet.damage(enemies[j]);
									//trace("collision");
									break; // so flames are not as powerful, only hit the front most enemy of a group instead of all of them also speeds up collision
																	
								}else{
									continue;
								}
							}
						}
						
					}
					//World collision to react with flames, but needs perpixle collision. I'll add this later
					/*for(var j:int = 0; j < objects.length; j++)	{		
						if(particles[i].checkCollisionWith(objects[j])){
							objects[j].life -= this.attackStrength;
							trace(objects[j].life, this.attackStrength);
						}
						
					}*/
					
			this.bulletLifeCycle(p);
		}
				
		public function bulletLifeCycle(bullet:Particle){		
			//trace("bulletLifeCycle");
			
		}
		
		
		override public function topBound(object:Obj){			
				
		}
						
		
		override public function leftBound(object:Obj){
			
		}
		
		override public function rightBound(object:Obj){
		
		}
		
		override public function grabbed(){
			if(!Display.myCursor) Display.CreateCustomCursor("target.png"); // this goes in the weapons class
			pickupSoundFx = new PlaySound("grab_weapon.mp3");
			pickupSoundFx.play();
			//Display.cam.addToFocus//
			Display.cam.addToFocus(Display.player);//
			//Display.cam.addToFocus(Display.myCursor);
			Display.cam.addToFocus(Display.myCursor);
			//Display.cam.setFocusOn(Display.player);
			Display.cam.attachTo(Display.player);
			trace("grabbed: " + this.type, this.isGrabbed);
			watch();
		}
		
		override public function dropped(){
			this.removeFromCollisionList(objects);
			//stopWatching();
			this.alpha = 0.5;
			//var myTween:Tween = new Tween(this, "rotation", None.easeNone, this.rotation, 0, 0.2, true);
			rotation = 0;
			weaponDropTimer = new Timer(800);
			weaponDropTimer.addEventListener(TimerEvent.TIMER, this.addBackToCollisionList);
			weaponDropTimer.start();
			trace("dropped: " + this.type);
			//stopWatching();
			
		}
		
		public function addBackToCollisionList($evt:TimerEvent){
			this.addToCollisionList();
			this.alpha = 1;
			weaponDropTimer.stop();
			weaponDropTimer = null;
			trace("adding back to collision list");
			
			
		}
		
	}
	
}
