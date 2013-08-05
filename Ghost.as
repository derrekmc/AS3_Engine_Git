package  {
	import Obj;
	//import flash.events.*;
	import Debug;
	import Display;
	import flash.ui.Keyboard;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.utils.Timer;


	public class Ghost extends Obj{
		
		var jumped:Boolean;
		//var grounded:Boolean;
		var attackValue:Number = 20;
		var update_i:Timer;
		//var mist:ParticleSystem;
		
		public function Ghost(name:String="Ghost", filename="ghost.swf", offSetX=0, offSetY=0 ):void {
			
			this.mass = this.radius * 100;
			
			this.grounded = false;
			this.jumped = false;			
			
			this.addEventListener(Event.ENTER_FRAME, updateEnemy);
			
			
			super(name, filename, "enemy", offSetX, offSetY, "BOUNDING_BOX");
			
			follow(Display.player);
			
			//this._speed += Global.randRange(0.1, 0.1) * direction;
			//mist = new ParticleSystem("enemy_smoke", x, y, 20, true);
		}
		
		public function updateEnemy(e:Event){
			if(Math.abs(this.vx) > 1.0){
				playFrame("stickman", "run"); 
				mist.seed.x = x - 20;
				mist.seed.y = y + 80;
			}
			
		}
		
		/*function updateEnemy(){
			if(this.life < 1 ) this.destroy();
		}*/
		
		override public function init(){
			trace("enemy init");
			
			//playFrame("stickman", "appear"); // appear
		}
		
		override public function interact(obj:Obj):void{		
			if(obj.life > 0){
				trace("attack");
				obj.life -= this.attackValue;
				obj.vx -= this.attackValue * obj.direction;
				Display.cam.shake(5, 10);
			}			
		}
		
		override public function destroy():void{
			
			trace("Enemy Dead" );			
			this.drop();			
			
			if(this.hasEventListener(Event.ENTER_FRAME)){
				//removeEventListener(Event.ENTER_FRAME, updateEnemy);
				//playFrame("stickman", "die");			
				removeFromCollisionList(objects);
				removeFromCollisionList(Display.world.enemies);
				removeListenersAndChildren();	
			}
					
		}		

	}
	
}
