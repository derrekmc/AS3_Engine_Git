package particles{
	
	import Debug;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import Obj;
	import Particle;
	
	public class GunFlames extends Particle {
		
		public function GunFlames (name:String="particle", filename:String="", startX:Number=0, startY:Number=0, offSetX:Number=0, offSetY:Number=0, canCollide="NONE"){
			
			super(name, filename, startX, startY, offSetX, offSetY, canCollide);			
			
		}
		
		override public function init(){
			
		}
		
		override public function birth(){			
			
			minLife 		= 8;
			maxLife 		= 16;				
			minSpeed 		= -1;
			maxSpeed 		= 3;				
			minVariation 	= 1;
			maxVariation 	= 2;				
			gravity 		= -5;
			angle 			= 0;
			scale 			= 0.4;
			scaleTo 		= 1.6;
			shrink			= 1.3;
			alphaTo 		= 0;					
			variation		= 0;				
			origLife 		= life;
			drag 			= Global.randRange(0.8,.9); 
			gravity 		= Global.randRange(-2.7, -5.5); 
			
			//this.x = seed.x + Math.random() * this.width;
			//this.y = seed.y + Math.random() * this.height;
			
			speed 			= Math.round(Math.random() * maxSpeed + minSpeed);
			variation 		= Math.round(Math.random() * maxVariation + minVariation) * -1;
			
			life 			= Math.round(Math.random() * maxLife + minLife);
							
			scaleX = scaleY = scale;			
			
		}
		
		override public function lifeCycle(){
			
			alpha=life/origLife;
				
			if(scale < scaleTo){
				scale *= shrink;
				scaleX = scaleY = scale;
			}
				//this.y += gravity;
							
				//this.variation *= drag;
				//this.speed *= drag;
				
				//this.y += this.variation;			
				//this.x += this.speed;
				
				life--;
		}
	
				
		
	}
	
}
