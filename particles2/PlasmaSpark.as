package particles2{
	import flash.display.*; 
	import Global;
	import flash.utils.Timer;
    import flash.events.TimerEvent;
	import flash.geom.Point;
	import flash.filters.BitmapFilter;
	import flash.filters.BitmapFilterQuality;
	import flash.filters.BlurFilter;
	import flash.events.Event;
	import Obj;
	
	public class PlasmaSpark extends Particle
	{	
		[Embed(source = "../pak/lightning.swf")]
        private var particleImage:Class;
		
		public function PlasmaSpark(seed:Point, canCollide="NONE") 
		{
			super("plasma_spark", particleImage, seed, 0,0, canCollide);
            attackStrength = 0.000005;        
			//clip.filters = [new BlurFilter(4,4,BitmapFilterQuality.HIGH)];
			//filters = [new BlurFilter(0, 4, BitmapFilterQuality.HIGH)];
			this.blendMode = BlendMode.ADD;
			
		}
		
		
		override public function birth(seed){
			
			// and move it to its starting position
			this.x = seed.x; 
			this.y = seed.y;
			//cliprotation = this.getDegreesByMouse();
			
			// set our particle's life
			life = 125;
			
			// set our particle's velocity
			xVel = Global.randRange(0.5,0.8); 
			yVel = Global.randRange(0,0.8);
			
			// add drag
			drag = Global.randRange(0.68,.69); 
			
			// add gravity
			gravity = Global.randRange(0.15, 0.21); 
			
			// randomise initial particle size
			this.scaleX = this.scaleY = Global.randRange(.4, .5); 
			
			// add shrink
			shrink = Global.randRange(0.8, .9); 
			
			// add spin
			//spin += Global.randRange(-90,+90); 
			
			// add fade 
			fade = 1; 
			// set the particle's starting alpha
			
			//this.alpha = Global.randRange(0.7, 1.0); 
			
			//PARTICLE TYPE EDIT END///////////////////////////////////////////////////
			
			
			
		}
		
	}
	
}