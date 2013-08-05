package ammo{
	
	import Debug;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import Obj;
	import Particle;
	import ParticleSeeder;
	import particles.Flame;
	import particles.Cloud;
	import particles.BlueFlame;
	import particles.WorldLargeFog;
	import particles.StageCloud;
	import particles.StarGlow;
	import particles.Smoke;
	
	public class BulletSystem {
		
		private var bullets:Array;
		private var seed;
		
		public function BulletSystem(particleClass:String="particle", startX=0, startY=0, seedAmount:Number=100, continous:Boolean=false){ // AKA CreateParticles();
			
			Display.addchild(this);
			//this.addEventListener(Event.ENTER_FRAME, update);
			super(startX, startY, seedAmount, continous);
			
			bullets = new Array();
			seed = new ParticleSeeder(startX, startY, seedAmount, continous);
			
			for(var i =0; i < this.seedAmount; i++){
				switch(particleClass){
					case "WorldLargeFog":
						var particle = new WorldLargeFog("large_fog" + i, "pak/clouds.png", seed);
					break;
					
					case "stage_clouds":
						var particle = new StageCloud("cloud" + i, "pak/clouds.png", seed);
					break;
					
					case "clouds":
						var particle = new Cloud("cloud" + i, "pak/clouds.png", seed);
					break;
					
					case "flame":
						var particle = new Flame("flame" + i, "pak/torch_flame.png", seed);
					break;
					
					case "blue_flame":
						var particle = new BlueFlame("blue_flame" + i, "pak/star_base.png", seed);
					break;
					
					case "smoke":
						var particle = new Smoke("smoke" + i, "pak/smoke.png", seed);
					break;
					
					case "start_glow":
						var particle = new BlueFlame("blue_flame" + i, "pak/star_glow.png", seed);
					break;
					
					default:
					case "particle":
						var particle = new Particle("particle" + i, "pak/star_glow.png.png", seed);
					break;
				}
				
				//addChild(particle);
				if(particle){
					Display.addchild(particle);
					//bullets.push(particle);
				}
			}
		}
		
		public function update(e:Event){
			//Debug.print("working", 1);
			
		}
	
		
	}
	
}
