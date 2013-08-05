package particles2{
import Global;
	import flash.geom.Point;
	import particles2.Particle;
	import particles.Smoke;
	import flash.display.BlendMode;
	import flash.filters.BitmapFilter;
	import flash.filters.BitmapFilterQuality;
	import flash.filters.BlurFilter;
	
	public class Fire extends Particle
	{	
		[Embed(source = "../pak/particles/spark.jpg")]
        private var particleImage:Class;
		
		private var smoking:Boolean = false;
		
		public function Fire(seed:Point, canCollide="NONE") 	{
			super("Fire", particleImage, seed, -32 ,-32, canCollide);
            attackStrength = 0.4;        
			
		}
		
		override public function init(){
			var radius = 0.5;
			leftBumpPoint 	= new Point(offSetX * radius, offSetY + (this.height/2)); // acount for image offset later
			upBumpPoint 	= new Point(offSetX + (this.width/2), offSetY * radius);
			rightBumpPoint 	= new Point(offSetX + this.width * radius, offSetY + (this.height/2) - (this.height/2));
			downBumpPoint 	= new Point(offSetX + (this.width/2), offSetY + this.height-(this.height * radius));
		}
		override public function birth(seed){
			
			// and move it to its starting position
			this.x = seed.x; 
			this.y = seed.y;
			//cliprotation = this.getDegreesByMouse();
			
			
			// set our particle's life
			life = 36;
			
			// set our particle's velocity
			//xVel += Global.randRange(17.5,55.8); 
			//yVel -= Global.randRange(7.5,15.8);
			
			// add drag
			drag = Global.randRange(0.79,.89); 
			
			// add gravity
			gravity = Global.randRange(-1.8, -2.8); 
			
			// randomise initial particle size
			this.scaleX = this.scaleY = Global.randRange(.8, 1.8); 
			
			// add shrink
			shrink = Global.randRange(1.1, 1.16); 
			
			// add spin
			spin += Global.randRange(-10,+10); 
			
			// add fade 
			fade = 0.044; 
			// set the particle's starting alpha
			
			this.alpha = Global.randRange(0.0, 0);
			/*
			clip.sparks.x *= Math.random()+0,-5;
			clip.smoke.x = clip.smoke.y = Math.random()*-8,+8;
			clip.flame.x = clip.flame.y = Math.random()*-4,+4;
			
			clip.smoke.scaleX = clip.smoke.scaleY = Math.random()+0.2, +0.1;
			clip.flame.scaleX = clip.flame.scaleY = Math.random()+0.6, +0.65;
			clip.sparks.scaleX = clip.sparks.scaleY = Math.random()-0.001, +0.001;
			
			clip.sparks.rotation *= Math.random()+0,+5;
			clip.flame.rotation *= Math.random()+0,+5;
			clip.smoke.rotation *= Math.random()+0,+90;
			*/
			
			
			
			
			clip.rotation *= Math.random()+0,-1;
			
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
			
			yVel += gravity; 
			
			this.scaleX *= shrink;
			this.scaleY *= shrink; 
			this.alpha +=fade*10; 
			this.rotation +=spin;
			life -= this.alpha;
			//trace(life);
			//life--;
			/*if(life < 1){
				this.destroy();
			}*/
			
			if(life < 5 && smoking == false){
				smoking = true;
				//this.setTint(0x353535);
				//shrink = Global.randRange(0.7, 0.9); 
				//drag = Global.randRange(0.4,.6); 
				//gravity = Global.randRange(-8.4, -14.8); 
				
				//var ps:Smoke = new Smoke(new Point(this.x + ((this.offSetX *direction)), this.y+ this.offSetY));
				
				//Display.screen.addChild(ps);
				//this.setTint(0xCCCCCC);
				//ps.smoking = true;
			
			}
			
			
			
		}
		
		override public function boxBound(object:Obj){			
			//trace("calling boxbound");
				yVel *= -0.45 * (Global.randRange(0.5, 1.0));
				xVel *= -0.45 * (Global.randRange(0.5, 1.0));
				//scaleY = scaleX * .8; 
				//var ps:PlasmaSpark = new PlasmaSpark(new Point(this.x, this.y), "NONE"); 
				//Display.addchild(ps);
		}
		
		override public function leftBound(object:Obj){
			xVel *= 0.45 * (Global.randRange(0.5, 1.0));
		}
		
		override public function rightBound(object:Obj){
			xVel *= -0.45 * (Global.randRange(0.5, 1.0));
		}
		
		override public function bottomBound(object:Obj){
			yVel *= -0.45 * (Global.randRange(0.5, 1.0));
		}
		
		override public function topBound(object:Obj){
			yVel *= 0.45 * (Global.randRange(0.5, 1.0));
		}
		
	}
	
}