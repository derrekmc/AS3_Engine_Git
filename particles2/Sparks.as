package particles2{
	
	import Global;
	import flash.geom.Point;
	import particles2.Particle;
		import flash.display.BlendMode;
	import flash.filters.BitmapFilter;
	import flash.filters.BitmapFilterQuality;
	import flash.filters.BlurFilter;
	
	public class Sparks extends Particle
	{	
		//public var life : Number = 1;
		
		[Embed(source = "../pak/particles/sparks.png")]
        private var particleImage:Class;
		
		// This is the constructor, a special function used 
		// to create this particle object.
		
		public function Sparks(seed:Point, canCollide="NONE") {			
			super("sparks", particleImage, seed, -32, -32, canCollide);			
		}
		
		
		override public function birth(seed){
			
			// and move it to its starting position
			this.x = seed.x; 
			this.y = seed.y;
			//cliprotation = this.getDegreesByMouse();
			
			
			// set our particle's life
			origLife = life = 20;
			
			
			// set our particle's velocity
			xVel = Global.randRange(-.5,.5); 
			yVel += Global.randRange(-4.5,-8.5); 
			
			// add drag
			drag = .2; 
			
			// add gravity
			gravity = Global.randRange(-.5,-7.7); 
			
			// randomise initial particle size
			this.scaleX = this.scaleY = Global.randRange(1.0, 1.5); 
			
			// add shrink
			shrink = +.8; 
			
			// add spin
			spin += Global.randRange(-20,+20); 
			
			// add fade 
			fade = 1; 
			// set the particle's starting alpha
			
			this.alpha = Global.randRange(1, 1.0); 
			//filters = [new BlurFilter(0, 4, BitmapFilterQuality.HIGH)];
			//this.setTint(0x00c0ff, 0.1);
			this.blendMode = BlendMode.ADD;
		//PARTICLE TYPE EDIT END///////////////////////////////////////////////////
			
			
		}
		
		
		
		
	}
	
}