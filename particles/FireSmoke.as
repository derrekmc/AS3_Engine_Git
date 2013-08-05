package particles{
	
	import Debug;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import Obj;
	import ParticleSeeder;
	import flash.display.BlendMode;
	
	public class FireSmoke extends Obj {
		public var smoking:Boolean = false;
		protected var minLife		:uint;
		protected var maxLife		:uint;			
		protected var minSpeed		:int;
		protected var maxSpeed		:int;			
		protected var minVariation	:int;
		protected var maxVariation	:int;				
		protected var angle			:int;		
		protected var scale			:int;	
		protected var scaleTo		:int;		
		protected var alphaTo		:int;			
		protected var alive			:Boolean;			
		protected var collisionCheck:Boolean;						
		protected var variation		:int;						
		protected var origLife		:int;			
		protected var origAlpha		:int;
		
		protected var spin			:int;		
		protected var Seed:*;
			
		public function FireSmoke (seed:Point, canCollide:String="NONE"){
			
			Seed = seed;
			super("fire_smoke", filename, "particle", 0, 0, canCollide);
			this.addEventListener(Event.ENTER_FRAME, updateParticle);
			
			/******** Start Defs*********/
			minLife 		= 20;
			maxLife 		= 40;				
			minSpeed 		= -1;
			maxSpeed 		= 2;				
			minVariation 	= 1;
			maxVariation 	= 3;				
			life 			= Math.round(Global.randRange(minLife, maxLife));
			origLife 		= life;
			origAlpha 		= origLife;
			alpha 			= origAlpha;
						
			angle 			= 0;
			scale 			= 100;
			scaleTo 		= 0;
			alphaTo 		= 0;					
			alive 			= true;				
			collisionCheck 	= false;							
			spin 			= Global.randRange(minLife, maxLife);
						
			//this.blendMode=BlendMode.MULTIPLY;
			
			birth();
			
			
		}
		
		protected function birth(){
			this.x = Seed.x + Math.random() * width;
			this.y = Seed.y + Math.random() * height;
					
			/*scale = Math.round(Math.random()*origLife+life);
			this.alpha=scale/100;
			this.scaleX=scale/100;
			this.scaleY=scale/100;
			*/
			speed = Math.round(Math.random() * maxSpeed + minSpeed);
			variation = Math.round(Math.random() * maxVariation + minVariation) * -1;
				
			life = Math.round(Math.random() * maxLife + minLife);
			alpha = origAlpha;
			origLife = life;
		}
		
		protected function life_cycle(){
			//Debug.print("update", 1)				
				var newscale = life/origLife;
				//trace(newscale);
											
				scaleX=newscale;
				scaleY=newscale;
				alpha = newscale;
				
				this.y += this.variation;			
				this.x += this.speed;
				
				this.life--;
				
				alpha = this.life/100;
				 
				//rotation +=spin; 
				
				
		}
	
		protected function updateParticle(e:Event){
			
			if(life > 0){
				life_cycle();				
			}else{
				destroy();				
			}
			
			
		}
	}
	
}
