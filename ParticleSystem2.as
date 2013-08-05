package{

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

	import particles2.Particle;
		
	public class ParticleSystem2 extends MovieClip{
		
		public var particles:Array;
		
		public function ParticleSystem2(renderer){
			renderer.addChild(this);
			// an array in which to store our particles
			particles = new Array(); 
			
			// add a blur filter to our stage
			filters = [new BlurFilter(0,0,0)];
			
			// call updateParticle every frame
			this.addEventListener(Event.ENTER_FRAME, updateParticle); 
			
		}
		
		
		public function updateParticle(e:Event){
			var particle:Particle;
			
			
			
			
			// loop through the array of particles and update each one
			for(var i:int = 0; i < this.particles.length; i++)
			{
				// update the particle at index i
				particles[i].update(); 
			}
			
			
			// make a new particle
			particle = new Particle(Spark, this, mouseX, mouseY); 
			
		//PARTICLE TYPE EDIT///////////////////////////////////////////////////
			//var flamesAmount = 10;
			// set our particle's velocity
			particle.xVel += randRange(-1,1); 
			particle.yVel = 0;
			
			// add drag
			particle.drag = 1; 
			
			// add gravity
			particle.gravity = randRange(-0.5,-0.4); 
			
			// randomise initial particle size
			particle.clip.scaleX = particle.clip.scaleY = randRange(1.0,1.12); 
			
			// add shrink
			particle.shrink = +1; 
			
			// add spin
			particle.spin += randRange(-10,+10); 
			
			// add fade 
			particle.fade = 0.015; 
			// set the particle's starting alpha
			
			particle.clip.alpha = randRange(0.4,0.6); 
			
		//PARTICLE TYPE EDIT END///////////////////////////////////////////////////
			
			// and add it to the array of particles
			particles.push(particle); 
		
			
			// if there are more than 40 particles delete the first 
			// one in the array... 
			while(particles.length>40)
			{
				particle = particles.shift();
				particle.destroy();
				
			}
			
		}
		
		public function birth(){
			
		}
		
		// returns a random value between min and max
		function randRange(min:Number, max:Number)
		{
			return Math.random()*(max-min)+min; 
		}
	
		
	}
	
}
