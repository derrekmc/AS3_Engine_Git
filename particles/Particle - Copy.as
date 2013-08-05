package particles{
	
	import Debug;
	import flash.events.TimerEvent;
	import flash.display.BlendMode;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import Obj;
	import ParticleSeeder;
	
	public class Particle extends Obj {
		
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
		
		protected static var Seed:*;
			
		public function Particle(name="particle", filename:String="", seed:*=null){
		
			Seed = seed;
						
			super(name, filename, "particle");
			
			this.addEventListener(Event.ENTER_FRAME, updateParticle);
			
			
			 minLife = 20;
			 maxLife = 40;
				
			 minSpeed = -1;
			 maxSpeed = 1;
				
			 minVariation = 1;
			 maxVariation = 5;
				
			 gravity = 0;
				
			 angle = 0;
				
			 scale = 100;
			 scaleTo = 0;
						
			 alphaTo = 0;
				
			 alive = true;
				
			 collisionCheck = false;
						
			 variation= Global.randRange(minVariation, maxVariation);
			
				
			 origLife = 100;
				
			 			 
			 speed = Math.round(Math.random() * maxSpeed + minSpeed);
			 variation = Math.round(Math.random() * maxVariation + minVariation) * -1;
				
			 this.x = Seed.x + Math.random() * width;
			 this.y = Seed.y + Math.random() * height;
				
		     life = Math.round(Math.random() * maxLife + minLife);
			 alpha = origAlpha;
			 origLife = life;
			 		 
			 blendMode = BlendMode.ADD;
		}
		
		override public function init(){
			
		}
		
		public function attachToSeed(seed:ParticleSeeder){
			
		}
	
		protected function updateParticle(e:Event){
			
			if(life > 1){
				//Debug.print("update", 1)
				life--;
				//var newscale = Math.round(life/origlife*100);
				//size = newscale - 200;
				//size += 100;
				
				this.alpha = life/100;
				//trace(this.alpha);
				//scaleX=size;
				//scaleY=size;
				
				this.y += this.variation;			
				this.x += this.speed;
				
				
				
			}else{
				
				destroy();
				/*speed = Math.round(Math.random() * maxSpeed + minSpeed);
				variation = Math.round(Math.random() * maxVariation + minVariation) * -1;
				
				this.x = Seed.x + Math.random() * width;
				this.y = Seed.y + Math.random() * height;
				
				life = Math.round(Math.random() * maxLife + minLife);
				alpha = origAlpha;
				origLife = life;*/
			}
			
			
		}
		
		override public function destroy():void{
			trace("Object " + this.name + " Destroyed" );
			removeEventListener(Event.ENTER_FRAME, updateParticle);
			this.removeListenersAndChildren(new TimerEvent("destroy"));			
		}
	}
	
}
