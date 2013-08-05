package vehicles{
	import flash.display.*; 
	import Global;
	import flash.utils.Timer;
    import flash.events.TimerEvent;
	import flash.geom.Point;
	import flash.filters.BitmapFilter;
	import flash.filters.BitmapFilterQuality;
	import flash.filters.BlurFilter;
	import flash.events.Event;
	import particles2.Particle;
	public class JetPakFlames2 extends Particle
	{	
		[Embed(source = "../pak/particles/jetpak_flames.png")]
		private var particleImage:Class;
		
		public function JetPakFlames2(seed:Point, canCollide="NONE") 
		{
			
			super(particleImage, seed, 0, 0, canCollide);
			
			//filters = [new BlurFilter(0, 4, BitmapFilterQuality.HIGH)];
		   this.blendMode = BlendMode.ADD;
		   watch();
        
			
		}
		
		override public function update(){
			if(this.isAlive()){
				lifeCycle();
			}else{
				destroy();
			}
           
            //Apply The Vector To The Position
            //this.x += vector.x;
            //this.y += vector.y;
           
            //Apply gravity
            //vector.y += gravity;
           
            //Apply Friction!
           // vector.x *= friction;
        }
		
		override public function birth(seed){
			if(!seed)seed = this.seed;
			// and move it to its starting position
			this.x = this.seed.x; 
			this.y = this.seed.y;
			//cliprotation = this.getDegreesByMouse();
			
			
			// set our particle's life
			life = 50;
			
			// set our particle's velocity
			xVel = Global.randRange(-.5,.5); 
			yVel += Global.randRange(0.5,1.9); 
			
			// add drag
			drag = .1; 
			
			// add gravity
			gravity = Global.randRange(0.2,0.4); 
			
			// randomise initial particle size
			this.scaleX = this.scaleY = Global.randRange(.4, 0.6); 
			
			// add shrink
			shrink = +0.96; 
			
			// add spin
			spin += Global.randRange(-10,+10); 
			
			// add fade 
			fade = 10 ; 
			// set the particle's starting alpha
			
			this.alpha = Global.randRange(0.6, 1); 
			
		//PARTICLE TYPE EDIT END///////////////////////////////////////////////////
			
			
		}
		
		override public function boxBound(object:Obj){			
			//trace("calling boxbound");
				yVel *= -0.05;
				xVel *= -0.05;
				
		}
		
		
		
		
		
	}
	
}