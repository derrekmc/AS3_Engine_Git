package weapons{
	import Obj;
	import flash.display.MovieClip;
	import flash.filters.BitmapFilter;
	import flash.filters.BitmapFilterQuality;
	import flash.filters.BlurFilter;
	//import flash.ui.Mouse;
	//import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import particles2.Fire;
	import Emitter;

		
	public class FlameGun extends Weapon{
				
		public function FlameGun(name:String="flame_gun", offSetX=0, offSetY=0){
			// add a blur filter to our stage
			//
			
			super(name, "flame_gun.swf", "flames.mp3", offSetX, offSetY);
			
			//this.addEventListener(Event.ENTER_FRAME, updateWeapon); 
			//filters = [new BlurFilter(0, 4, BitmapFilterQuality.HIGH)];
		   //this.blendMode = BlendMode.ADD;
		}		
				
		
		override public function shoot(){
			
			if(this._particles.length <12){
					
				emit(new Point(this.x, this.y));
				if(isCurrentFrameLabel("gun", "fire") != true){
					playFrame("gun", "fire");
				}
			}
			//Display.player.shake(1, 2);
			//Display.cam.shake(2, 2);
			//Display.cam.shake(2, 2);
			
			//this.emitter = new Emitter(Display.screen, this, 20, this.x, this.y, false);
			//this.emitter.attach(this);
			//trace("emitter:" + emitter.x, emitter.y, emitter.rotation);
			
		}	
		
		
		
		override public function emit(seed:Point){
			
			var f:Fire = new Fire(seed, "BOUNDING_BOX"); 
			Display.screen.addChild(f);
			
			var objRotation = (this.rotation - 90) *-1;
			//f.birth(seed);
			//filters = [new BlurFilter(0,4,BitmapFilterQuality.HIGH)];
			var dif = Global.randRange(65,75);
			f.xVel=(dif*(Math.sin((objRotation)*(Math.PI/180)))) * this.direction;
			f.yVel=(dif*(Math.cos((objRotation)*(Math.PI/180)))) * this.direction;
			
			f.x += f.xVel;
			f.y += f.yVel;
			
			_particles.push(f); 			
			this.numParticles++;
			
			return f;
		}
				
		override public function update(){		
			
			// loop through the array of particles and update each one
			for(var i:int = 0; i < this._particles.length; i++)
			{
				// update the particle at index i
				if(lifeSpan(_particles[i]) < 1){
					_particles[i].destroy();
					_particles.splice(i, 1);		
					//_particles[i].birth(seed);
					continue;
				}else{
					
					_particles[i].lifeCycle();
					var enemies = enemies;
					//trace("enemies: " + enemies.length);
					//particles[i].checkCollisionWith(Display.world);
					for(var j:int = 0; j < enemies.length; j++)	{		
						if(enemies[j] != Display.world.player && enemies[j].dying != true){
							if(enemies[j].isOnScreen){
								if(_particles[i].checkCollisionWith(enemies[j])){
									//trace(enemies[j]);
									//trace(enemies[j].life, this.attackStrength);
									_particles[i].damage(enemies[j]);
									
									//if(enemies[j].name =="house") trace("burning: ", enemies[j].life);
									break; // so flames are not as powerful, only hit the front most enemy of a group instead of all of them also speeds up collision
																	
								}else{
									continue;
								}
							}
						}
						
					}
					//World collision to react with flames, but needs perpixle collision. I'll add this later
					/*var floors = Display.world.floors;
					for(var j:int = 0; j < floors.length; j++)	{		
						if(_particles[i].checkCollisionWith(floors[j])){
							//trace("checking");
						}
						
					}*/
				}				
			}				
		}
		
		
		 
		
		
		
	}
	
}
