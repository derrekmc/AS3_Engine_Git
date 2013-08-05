package{
	
	import Debug;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import Obj;
	import particles.Flame;
	import particles.Cloud;
	import particles.BlueFlame;
	import particles.WorldLargeFog;
	import particles.StageCloud;
	import particles.ScreenCloud;
	import particles2.Snowing;
	import particles.StarGlow;
	import particles.Smoke;
	import particles.EnemySmoke;
	import flash.events.TimerEvent;
	import flash.utils.Timer;

	public class ParticleSystem extends Obj{
		
		public var _particles:Array;
		public var seedAmount:Number;
		public var seed:Point;
				
		public function ParticleSystem(particleClass:String="particle", startX=0, startY=0, seedAmount:Number=100, continous:Boolean=false){ // AKA CreateParticles();
			
			Display.addchild(this);
			//this.addEventListener(Event.ENTER_FRAME, update);
			//super(startX, startY, seedAmount, continous);
			this.seedAmount = seedAmount;
			this.seed = new Point(startX, startY);
			_particles = new Array();
			
			var p;
			for(var i =0; i < this.seedAmount; i++){
				switch(particleClass){
					case "WorldLargeFog":
						p = new WorldLargeFog("large_fog" + i, "clouds.png", seed);
					break;
					
					case "stage_clouds":
						p = new StageCloud("cloud" + i, "clouds.png", seed);
					break;
					
					case "snow_particles":
						//p = new Snowing("snowflake" + i, "particles/SnowFlake.png", seed);
					break;
					
					case "screen_clouds":
						p = new ScreenCloud("cloud" + i, "clouds.png", seed);
					break;
					
					case "clouds":
						p = new Cloud("cloud" + i, "clouds.png", seed);
					break;
					
					case "flame":
						p = new Flame("flame" + i, "torch_flame.png", seed);
					break;
					
					case "blue_flame":
						p = new BlueFlame("blue_flame" + i, "star_base.png", seed);
					break;
					
					case "smoke":
						p = new Smoke("smoke" + i, "smoke.png", seed);
					break;
					
					case "enemy_smoke":
						p = new EnemySmoke("smoke" + i, "smoke.png", seed);
					break;
					
					case "start_glow":
						p = new BlueFlame("start_glow" + i, "star_glow.png", seed);
					break;
					
					case "bullet":
						p = new BlueFlame("star_glow" + i, "star_glow.png", seed);
					break;
					
					default:
					case "particle":
						//p = new Particle("particle" + i, "fire.png", seed);
					break;
				}
				
				//addChild(particle);
				
				if(p){
					this.addChild(p);
					this._particles.push(p);
				}
			}						
		}
		
		
		
		override public function destroy():void{
			for(var i:int = 0; i < this._particles.length; i++){
				_particles[i].destroy();
				_particles.shift();					
			}	
			//this.removeEventListener(Event.ENTER_FRAME, updateEmitter); 	
		}
		
	}
	
}
