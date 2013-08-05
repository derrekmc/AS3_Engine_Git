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
	import particles2.Plasma;
	import particles2.PlasmaSpark;
	import Emitter;
	import flash.utils.Timer;
	import flash.events.TimerEvent;
		
	public class PlasmaRifle extends Weapon{
		var pulse = 0;
		var plasmaRechargeTime = 7;
		public function PlasmaRifle(name:String="plasma_rifle", offSetX=-46, offSetY=-51){
			// add a blur filter to our stage
			super(name, "plasma_gun.swf", "plasma_pulse_pass_by.mp3", offSetX, offSetY);
			
		}		
				
		
		override public function shoot(){
			
			//if(this._particles.length < 2){
				emit(new Point(this.x, this.y));
				
			//}
			//Display.player.shake(1, 2);
			//Display.cam.shake(2, 2);
			//Display.cam.shake(2, 2);
			
			//this.emitter = new Emitter(Display.screen, this, 20, this.x, this.y, false);
			//this.emitter.attach(this);
			
			
		}	
		
		override public function emit(seed:Point){
			if(firing == false ) pulse = 0;
			if (pulse > 1 ) {
				//shoot
				pulse--
				return;
			} 
			if(isCurrentFrameLabel("gun", "fire") != true){
					playFrame("gun", "fire");
			}
			pulse = this.plasmaRechargeTime;
			var particle:Plasma = new Plasma(seed, "BOUNDING_BOX"); 
			Display.pDO.addChild(particle);
			
			
			var objRotation = (this.rotation - 90) *-1;
			//particle.birth(seed);
			//filters = [new BlurFilter(0,4,BitmapFilterQuality.HIGH)];
			var dif = Global.randRange(30,35);
			particle.xVel=(dif*(Math.sin((objRotation)*(Math.PI/180)))) * this.direction;
			particle.yVel=(dif*(Math.cos((objRotation)*(Math.PI/180)))) * this.direction;
			particle.rotation = (this.getDegreesByXY(particle.xVel, particle.yVel) - 90)* -1;
			particle.x += particle.xVel;
			particle.y += particle.yVel;
			
			_particles.push(particle); 			
			this.numParticles++;
			
		}
				
		override public function update(){		
			
			// loop through the array of particles and update each one
			for(var i:int = 0; i < this._particles.length; i++)
			{
				// update the particle at index i
				if(lifeSpan(_particles[i]) < 1){
					_particles[i].kill();
					_particles.splice(i, 1);							
					continue;
				}else{
					
					_particles[i].lifeCycle();
					var enemie = enemies;
					
					for(var j:int = 0; j < enemies.length; j++)	{		
						if(enemie[j] != Display.world.player && enemie[j].dying != true){
							if(enemies[j].isOnScreen){
								if(_particles[i].checkCollisionWith(enemie[j])){
									_particles[i].damage(enemie[j]);									
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
						//_particles[i].collisionType = "PER_PIXLE";
						if(_particles[i].checkCollisionWith(floors[j])){
							//trace("checking");
						}
						//_particles[i].collisionType = "BOUNDING_BOX";
						
					}*/
				}				
			}				
			
			
		}
		
		
		
		
		
		
		
	}
	
}
