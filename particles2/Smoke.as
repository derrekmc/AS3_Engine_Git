package particles2{
import Global;
	import flash.geom.Point;
	import particles2.Particle;
	import particles.FireSmoke;
		import flash.display.BlendMode;
	import flash.filters.BitmapFilter;
	import flash.filters.BitmapFilterQuality;
	import flash.filters.BlurFilter;
	
	public class Smoke extends Particle
	{	
		[Embed(source = "../pak/particles/smoke.png")]
        private var particleImage:Class;
		
		private var smoking:Boolean = false;
		
		public function Smoke(seed:Point, canCollide="NONE") {
			super("Smoke", particleImage, seed, -32 ,-32, canCollide);
            attackStrength = 0.10;        
			
		}
		
		override public function init(){
			var radius = 0.5;
			leftBumpPoint 	= new Point(offSetX * radius, offSetY + (this.height/2)); // acount for image offset later
			upBumpPoint 	= new Point(offSetX + (this.width/2), offSetY * radius);
			rightBumpPoint 	= new Point(offSetX + this.width * radius, offSetY + (this.height/2) - (this.height/2));
			downBumpPoint 	= new Point(offSetX + (this.width/2), offSetY + this.height-(this.height * radius));
		}
		override public function birth(seed){
			this.x = seed.x; 
			this.y = seed.y;
			life = 10;
			drag = Global.randRange(0.59,.69); 
			gravity = Global.randRange(-1.8, -2.2); 
			this.scaleX = this.scaleY = Global.randRange(2, 2.4); 
			shrink = Global.randRange(1.1, 1.2); 
			spin = Global.randRange(-10,+10); 
			this.fadeToLife();
			fade = 1;
			//filters = [new BlurFilter(0, 4, BitmapFilterQuality.HIGH)];
			//this.blendMode = BlendMode.MULTIPLY;
		//PARTICLE TYPE EDIT END///////////////////////////////////////////////////
			
			
		}
		
		override public function lifeCycle() : void		{
			// apply drag
			xVel *= drag; 
			yVel *= drag; 
			
			yVel += gravity; 
			
			this.scaleX *= shrink;
			this.scaleY *= shrink; 
			
			life -= fade;
			
			this.fadeToLife();
			
			this.rotation += spin;
						
			this.x += xVel; 
			this.y += yVel; 
			
		}
		
		
	}
	
}