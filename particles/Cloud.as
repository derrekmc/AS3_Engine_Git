package particles{
	
	import Debug;
	import flash.display.BlendMode;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import Obj;
	import ParticleSeeder;
	import World;
	
	public class Cloud extends Obj {
		
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
						
		protected var variation;
			
			
		protected var origAlpha;
		
		protected static var Seed:*;
			
		public function Cloud(name="particle", filename:String="", seed:*=null){
		
			Seed = seed;
						
			super(name, filename, "particle");
			
			this.addEventListener(Event.ENTER_FRAME, updateParticle);
			
			
			 minLife = 20;
			 maxLife = 40;
				
			 minSpeed = -1;
			 maxSpeed = 2;
				
			 minVariation = 1;
			 maxVariation = 5;
				
			 gravity = 0;
				
			 angle = 0;
				
			 scale = 100;
			 scaleTo = 0;
						
			 alphaTo = 0;
				
			 alive = true;
				
			 collisionCheck = false;
							
			 variation= 0;
				
				
			 origLife = 100;
				
			 origAlpha;
			 
			 //this.x = Seed.x + Math.random() * width;
			 //this.y = Seed.y + Math.random() * height;
			 
			 
			 //this._x = Math.random()*500;
			 //this._y = Math.random()*100+20;
			
			this.variation = Math.round(Math.random()*200+100)*-1;
			trace("variation"+variation);
			this.x = Seed.x + Math.round(Math.random()*(Display.pDO.stage.stageWidth-400)+200);
			this.y = Seed.y + Math.random() * variation;
			 
			this.minLife=100;
			this.maxLife=200;
			this.scale = Math.round(Math.random()*maxLife+minLife);
			this.speed = scale/20;
			this.alpha=scale/ 100;
			this.scaleX=scale/100;
			this.scaleY=scale/100;
			//this.cacheAsBitmap=true;
			
			this.blendMode=BlendMode.ADD;
	
			 
		}
		
		public function attachToSeed(seed:ParticleSeeder){
			
		}
	
		protected function updateParticle(e:Event){
			
			this.x+=speed;
			if(this.x> Display.pDO.stage.stageWidth){
				x=-300;
			}
			//Debug.print( "speed:" + this.speed,1);
			
		}
	}
	
}
