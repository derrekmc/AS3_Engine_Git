package{
	
	import Debug;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import Obj;
	import particles.Particle;
	
	public class ParticleSeeder extends Obj {
		
		
		protected var continous:Boolean;
		protected var seedAmount:Number;
		public var seed:Point;
		
		public function ParticleSeeder(startX=0, startY=0, seedAmount:Number=100, continous:Boolean=true){
			
			this.continous = continous;
			this.seedAmount = seedAmount;
			//this.particleClass = particleClass;
			//seed = new Point(startX, startY);
			this.x = startX;
			this.y = startY;
			super(name, "", "seed");
			
			
		}
	
		
		
		
	}
	
}
