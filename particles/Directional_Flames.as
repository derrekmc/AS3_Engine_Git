package particles{
	
	import Debug;
	import flash.geom.Point;
	import particles.Particle;
		
	public class Directional_Flames extends Particle {
							
		public function Directional_Flames (name="particle", filename:String="", seed:*=null, canCollide:String="NONE"){
				
			super(name, filename, "particle", seed, offSetX, offSetY, canCollide);			
			
		}
		
		override public function birth(){
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
			
			this.x = Seed.x + Math.random() * width;
			this.y = Seed.y + Math.random() * height;
				
			speed = Math.round(Math.random() * maxSpeed + minSpeed);
			variation = Math.round(Math.random() * maxVariation + minVariation) * -1;
				
			life = Math.round(Math.random() * maxLife + minLife);
			alpha = origAlpha;
			origLife = life;
		}
		
		override public function lifeCycle(){
			//Debug.print("update", 1)				
				var newscale = life/origLife;
				
				alpha=newscale;
				
				scaleX=newscale;
				scaleY=newscale;
				
				this.y += this.variation;			
				this.x += this.speed;
				life--;
		}
			
		
	}
	
}
