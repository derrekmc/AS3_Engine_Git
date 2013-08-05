package  {
	
	public class RealFire {

		public function RealFire() {
			// constructor code
		}
		
		var particles:Array = new Array();
		
		// add a blur filter to our stage
		filters = [new BlurFilter(0,0,0)];
		
		// call frameLoop every frame
		addEventListener(Event.ENTER_FRAME, frameLoop);
		
		function frameLoop(e:Event){
			
			var particle:Particle;
			
			// loop through the array of particles and update each one
			for(var i : int = 0; i < ){
				particle  new;
				yvel = 0; 
				drag =1; 
				gravity = randRange(-0.5,-0.4);
				scalex = particle.clip.scaleY;
				shrink = +1;
				fade = 0.015; 
				alpha = randRange(0.4,0.6);
				
				particle = particles.shift();
				particle.destroy();
			
			}
			
			
			// loop through the array of particles and update each one
			for(var i : int = 0; i < particle =" new" yvel =" 0;" drag =" 1;" gravity =" randRange(-0.5,-0.4);" scalex =" particle.clip.scaleY" shrink =" +1;" fade =" 0.015;" alpha =" randRange(0.4,0.6);">40)
			{
			particle = particles.shift();
			particle.destroy();
			
			}
		
		}
		
		// returns a random value between min and max
		function randRange(min:Number, max:Number){
			return Math.random()*(max-min)+min;
		}


		sparks.x *= Math.random()+0,-5;
		smoke.x = smoke.y = Math.random()*-8,+8;
		flame.x = flame.y = Math.random()*-4,+4;
		
		smoke.scaleX = smoke.scaleY = Math.random()+0.2, +0.1;
		flame.scaleX = flame.scaleY = Math.random()+0.6, +0.65;
		sparks.scaleX = sparks.scaleY = Math.random()-0.001, +0.001;
		
		sparks.rotation *= Math.random()+0,+5;
		flame.rotation *= Math.random()+0,+5;
		smoke.rotation *= Math.random()+0,+90;

	}
	
}
