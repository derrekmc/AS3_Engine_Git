package particles{
	
	import Debug;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import Obj;
	import ParticleSeeder;
	
	public class BlueFlame extends Obj {
		
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
			
			
		protected var origAlpha;
		
		protected static var Seed:*;
			
		public function BlueFlame (name="particle", filename:String="", seed:*=null){
		
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
			super(name, filename, "particle", 0, 0, "NONE");
			
			birth();
			watch();
			
			
		}
		
		public function birth(){
			this.x = Seed.x + Math.random() * width;
			this.y = Seed.y + Math.random() * height;
				
			speed = Math.round(Math.random() * maxSpeed + minSpeed);
			variation = Math.round(Math.random() * maxVariation + minVariation) * -1;
				
			life = Math.round(Math.random() * maxLife + minLife);
			alpha = origAlpha;
			origLife = life;
		}
		
		public function lifeCycle(){
			//Debug.print("update", 1)				
				var newscale = life/origLife;
				
				alpha=newscale;
				//this.alpha = alpha;
				
				
				scaleX=newscale;
				scaleY=newscale;
				
				this.y += this.variation;			
				this.x += this.speed;
				life--;
		}
	
		override public function update(){
			
			if(isAlive()){
				lifeCycle();				
			}else{
				//trace("particle dead");
				die(2);				
			}
			
			
		}
		override public function bottomBound(object:Obj){
			
		}
		
	}
	
}
