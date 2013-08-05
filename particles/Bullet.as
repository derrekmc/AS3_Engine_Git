package particles{
	
	import Debug;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import Obj;
	import ParticleSeeder;
	
	public class Bullet extends Obj {
		
		protected var minLife;
		protected var maxLife;
			
		protected var minSpeed;
		protected var maxSpeed;
			
		protected var minVariation;
		protected var maxVariation;
			
		protected var gravity;
			
		protected var angle;
			
		protected var scale;
		protected var scaleTo;
					
		protected var alphaTo:Number;
			
		protected var alive:Boolean;
			
		protected var collisionCheck:Boolean;
						
		protected var variation= 0;
			
			
		protected var origLife = 100;
			
		protected var origAlpha;
		
		protected static var Seed:ParticleSeeder;
			
		public function Bullet (name="particle", filename:String="", seed:ParticleSeeder=null){
		
			minLife 		= 20;
			maxLife 		= 40;				
			minSpeed 		= -1;
			maxSpeed 		= 2;				
			minVariation 	= 1;
			maxVariation 	= 5;				
			gravity 		= 0;
			angle 			= 0;
			scale 			= 100;
			scaleTo 		= 0;
			alphaTo 		= 0;					
			alive 			= true;				
			collisionCheck 	= false;							
			variation		= 0;				
			origLife 		= 100;				
					 
			
			Seed = seed;
			super(name, filename, "particle");
			this.addEventListener(Event.ENTER_FRAME, updateParticle);
			
		}
		
		protected function birth(){
			this.x = Seed.x + Math.random() * width;
			this.y = Seed.y + Math.random() * height;
				
			speed = Math.round(Math.random() * maxSpeed + minSpeed);
			variation = Math.round(Math.random() * maxVariation + minVariation) * -1;
				
			life = Math.round(Math.random() * maxLife + minLife);
			alpha = origAlpha;
			origLife = life;
		}
		
		protected function life_cycle(){
			//Debug.print("update", 1)				
				//var newscale = Math.round(life/origlife*100);
				//size = newscale - 200;
				//size += 100;
				
				alpha=life;
				//this.alpha = alpha;
				
				
				//scaleX=size;
				//scaleY=size;
				
				this.y += this.variation;			
				this.x += this.speed;
				life--;
		}
	
		protected function updateParticle(e:Event){
			
			if(life > 1){
				life_cycle();				
			}else{
				birth();				
			}
			
			
		}
	}
	
}
