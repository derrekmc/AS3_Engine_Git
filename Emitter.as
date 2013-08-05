package{
	import Obj;
	import flash.display.MovieClip;
	import flash.filters.BitmapFilter;
	import flash.filters.BitmapFilterQuality;
	import flash.filters.BlurFilter;
	
	//import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.geom.Rectangle;

	import particles.BlueFlame;
		
	public class Emitter extends Obj{
		
		public var _particles:Array;
		public var continuous:Boolean=false;
		public var seed:Point;
		protected var numParticles:int;
		protected var maxParticles:int;
		
		public function Emitter(name, filename="heart.png", type:String="emitter", amount:int=1, offSetX:int=0, offSetY:int=0, continuous:Boolean=false, canCollide="NONE"){
			//.addChild(this);
			// an array in which to store our particles
			this._particles = new Array(); 
			this.maxParticles = amount;
			this.numParticles = 0;
			this.continuous = continuous;
			// add a blur filter to our stage
			//filters = [new BlurFilter(0,4,BitmapFilterQuality.HIGH)];
						
			//plantSeed(seedX , seedY);
			super(name, filename, type, offSetX, offSetY, canCollide);
			watch();
			
		}		
		
		override public function init(){
			
		}
		
		override public function update(){		
			//trace("updateEmitter");
			if(numParticles < maxParticles ){
				emit(this.seed);
			}else{
				this.destroy();
			}
			//trace(numParticles);
			// loop through the array of particles and update each one
			//trace(this.rotation);
			
		
		}
		
		public function plantSeed(seedX:int=0, seedY:int=0){
			this.x = seedX;
			this.y = seedY;
			
			//addEventListener(Event.ENTER_FRAME, updateEmitter); 
		}
		
		public function emit(seed:Point){
						
			//shotxspeed=40*Math.sin(_root.gun._rotation*(Math.PI/180));
			//shotyspeed=40*Math.cos(_root.gun._rotation*(Math.PI/180));
			var particle = new BlueFlame("heart", "heart.png", new Point(this.x, this.y)); 
			//particle.getDegreesByMouse();
			//particle.birth();
			Display.screen.addChild(particle);
			//particle.getDegreesByMouse();
			
			//trace("particle:" +seed.x, seed.y);
			// and add it to the array of particles
			
			//_particles.push(particle); 			
			numParticles++;
		}
		
		public function lifeSpan(particle){
			if(continuous == true){
				return 1;
			}else if(continuous == false){
				//trace("life" + particle.life);
				return particle.life;
			}
		}		
		
		override public function kill(){			
			//trace("emitter destroyed");
			//this.removeEventListener(Event.ENTER_FRAME, updateEmitter);
			_particles = [];
			
			//particles=null;
			
			destroy();
			
		}	
		
	}
	
}
