package vehicles{

	import Global;
	
	import flash.geom.Point;

	import particles2.Particle;
	
	import flash.display.BlendMode;
	import flash.filters.BitmapFilter;
	import flash.filters.BitmapFilterQuality;
	import flash.filters.BlurFilter;
	
	public class JetPakFlames extends Particle
	{	
		
		[Embed(source = "../pak/particles/fire7.png")]
        private var particleImage:Class;
		
		public function JetPakFlames(seed:Point, canCollide="NONE") {			
			super("jetpakflames", particleImage, seed, -32, -32, canCollide);					
		
		}
		
		override public function init(){
			
		}
		
		/*
		public function birth(Seed=null){
			if(!Seed) Seed = this.seed;
			// and move it to its starting position
			this.x = Seed.x; 
			this.y = Seed.y;
			//cliprotation = this.getDegreesByMouse();
			
			
			// set our particle's life
			life = 40;
			
			// set our particle's velocity
			xVel = Global.randRange(-.5,.5); 
			yVel += Global.randRange(0.5,0.9); 
			
			// add drag
			drag = .1; 
			
			// add gravity
			gravity = Global.randRange(0.2,0.4); 
			
			// randomise initial particle size
			this.scaleX = this.scaleY = Global.randRange(.4, 0.6); 
			
			// add shrink
			shrink = +0.93; 
			
			// add spin
			spin += Global.randRange(-10,+10); 
			
			// add fade 
			fade = 20 ; 
			// set the particle's starting alpha
			
			this.alpha = Global.randRange(0.6, 1); 
			this.setTint(0x00c0ff, 0.1);
		//PARTICLE TYPE EDIT END///////////////////////////////////////////////////
			
			
		}
		*/
		override public function birth(seed){
			//if(!Seed) Seed = this.seed;
			// and move it to its starting position
			this.x = seed.x; 
			this.y = seed.y;
			//cliprotation = this.getDegreesByMouse();
			
			
			// set our particle's life
			life = 80;
			
			// set our particle's velocity
			xVel = Global.randRange(-.5,.5); 
			yVel += Global.randRange(2.5,5.9); 
			
			// add drag
			drag = .9; 
			
			// add gravity
			gravity = Global.randRange(0.2,0.4); 
			
			// randomise initial particle size
			this.scaleX = this.scaleY = Global.randRange(.2, 0.4); 
			
			// add shrink
			shrink = +0.93; 
			
			// add spin
			spin += Global.randRange(-10,+10); 
			
			// add fade 
			fade = 10 ; 
			// set the particle's starting alpha
			
			this.alpha = Global.randRange(0.6, 1); 
			this.setTint(0x00c0ff, 0.1);
			//filters = [new BlurFilter(0, 4, BitmapFilterQuality.HIGH)];
			this.blendMode = BlendMode.ADD;
		//PARTICLE TYPE EDIT END///////////////////////////////////////////////////
			
			
		}
		
		override public function lifeCycle() : void
		{
			 // every day you live you die, so if we run one life cycle we take one life.
			// add the velocity to the clip's position
			this.x += xVel; 
			this.y += yVel; 
			
			// apply drag
			xVel *= drag; 
			yVel *= drag; 
			this.setTint(0x803f00, this.alpha/4);
			
			yVel += gravity; 
			
			this.scaleX *= shrink;
			this.scaleY *= shrink; 
			//trace(life);
			this.rotation +=spin;
			life -= fade;
			this.alpha = life/100; 
			//trace(life);
			
			
			
			
		}
		
		
		
		
		
		
	}
	
}