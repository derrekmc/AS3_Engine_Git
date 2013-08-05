package{
	
	import Debug;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import Obj;
	import Particle;
	import ParticleSeeder;
	
	public class FlamesSystem extends ParticleSystem {
		
		private var particles:Array;
		private var seed;
		
		public function FlamesSystem(startX=0, startY=0, seedAmount:Number=100, continous:Boolean=true){
			super(startX, startY, seedAmount, continous);
			//this.addEventListener(Event.ENTER_FRAME, update);
		}
		
		public function update(){
			Debug.print("working", 1);
		}
	
		
	}
	
}
