package particles2{
	
	import Global;
	import flash.geom.Point;
	import particles2.Particle;
	
	public class Snowing extends Particle{	
		
		[Embed(source = "../pak/particles/SnowFlake.png")]
        private var particleImage:Class;
		
		public function Snowing(seed:Point, canCollide="NONE") {
			super(particleImage, seed, 0 ,0, canCollide);			
		}
		
		
		override public function birth(seed){			
			// and move it to its starting position
			if(seed) this.seed = seed;
			
			this.x = seed.x; 
			this.y = seed.y;
			//cliprotation = this.getDegreesByMouse();
						
			// set our particle's life
			life = 18;
			
			// set our particle's velocity
			xVel += Global.randRange(17.5,55.8); 
			yVel += Global.randRange(7.5,15.8);
			
			// add drag
			drag = Global.randRange(0.7,.8); 
			
			// add gravity
			gravity = Global.randRange(-1.4, -1.8); 
			
			// randomise initial particle size
			this.scaleX = this.scaleY = Global.randRange(.8, 1.1); 
			
			// add shrink
			shrink = Global.randRange(1.1, 1.1); 
			
			// add spin
			spin += Global.randRange(-10,+10); 
			
			// add fade 
			fade = 0.014; 
			// set the particle's starting alpha
			
			this.alpha = Global.randRange(0.0, 0);
			
			//PARTICLE TYPE EDIT END//////////////////////////////
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
			
			yVel += gravity; 
			
			this.scaleX *= shrink;
			this.scaleY *= shrink; 
			this.alpha +=fade*10; 
			this.rotation +=spin;
			life -= this.alpha;
						
			
		}
		
		override public function boxBound(object:Obj){			
			//trace("calling boxbound");
				yVel *= -0.45 * (Global.randRange(0.5, 1.0));
				xVel *= -0.45 * (Global.randRange(0.5, 1.0));
				
		}
		
	}
	
}