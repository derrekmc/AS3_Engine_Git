package particles{
	
	import Debug;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import Obj;
	import Particle;
	
	public class Flames  {
		
		private var particles:Array;
		private var continous:Boolean;
		private var seedAmount:Number;
		private var particleClass;
				
		public function ParticleSeeder(seedAmount:Number=100, continous:Boolean=true){
			particles = new Array();
			this.continous = continous;
			this.seedAmount = seedAmount;
			this.particleClass = particleClass;
			type = "seed";
			
		}
	
		
		
		public function attachTo(seed:ParticleSeeder){
			
		}
	}
	
}
