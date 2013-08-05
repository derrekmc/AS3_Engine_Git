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
	
	public class ScreenCloud extends Obj {
		
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
		
		protected static var Seed:Point;
			
		public function ScreenCloud(name="particle", filename:String="", seed:*=null){
		
			Seed = seed;
						
			
			super(name, filename, "particle", 0, 0, "NONE", true);
			//this.addEventListener(Event.ENTER_FRAME, updateParticle);
			
			
			 minLife = 20;
			 maxLife = 40;
				
			 minSpeed = -1;
			 maxSpeed = 2;
				
			 minVariation = 1;
			 maxVariation = 5;
				
			 gravity = 0;
				
			 angle = 0;
				
			 scale = 1;
			 scaleTo = 5;
						
			 alphaTo = 0;
				
			 alive = true;
				
			 collisionCheck = false;
							
			 variation= 0;
				
				
			 origLife = 100;
				
			
			 
			 //this.x = Seed.x + Math.random() * width;
			 //this.y = Seed.y + Math.random() * height;
			 
			 
			 //this._x = Math.random()*500;
			 //this._y = Math.random()*100+20;
			 
			this.minLife=120;
			this.maxLife=170;
			
			this.variation = Math.round(Math.random()*140+75)*-1;
			//trace("variation"+variation);
			this.x =  Math.round(Math.random()*(Display.pDO.stage.stageWidth));
			this.y = Seed.y + Math.random() * Display.pDO.stage.stageHeight;
			 
			
			this.scale 	= Global.randRange(minLife, maxLife)/100 ;
			this.speed 	= scale * Global.randRange(2,4);
			this.alpha	= Math.round(scale * (minLife/maxLife)* Global.randRange(0.5,1));
			this.scaleX = this.scaleY = scale;
			this.cacheAsBitmap=true;
			//trace(alpha);
			this.blendMode=BlendMode.ADD;
			watch();
			 
		}
		
		override public function onAppear(){
			//this.alpha=this.scale;
		}
		
		public function attachToSeed(seed:ParticleSeeder){
			
		}
	
		override public function update(){
			//trace(Display.cam.x);
			this.x-=speed;
			
			var isOffScreen = false;
			//check for right boarder of screen
			if(this.x > Display.cam.x + Display.pDO.stage.stageWidth){
				isOffScreen = true;
				x = Display.cam.x -this.width;
			}
			//check for left boarder of screen
			if(this.x+this.width < Display.cam.x ){
				isOffScreen = true;
				x = Display.cam.x + Display.pDO.stage.stageWidth;
			}
			
			if(this.y > Display.cam.y + Display.pDO.stage.stageHeight){
				isOffScreen = true;
				y = Display.cam.y - this.height;
			}
			//check for left boarder of screen
			if(this.y+this.width < Display.cam.y ){
				isOffScreen = true;
				y = Display.cam.y + Display.pDO.stage.stageHeight;
			}
			
			
			if(isOffScreen == true){
				this.scaleX = this.scaleY = scale + (Display.cam.y*-1)/1000;
			}
			//Debug.print( "speed:" + this.speed,1);
			
		}
	}
	
}
