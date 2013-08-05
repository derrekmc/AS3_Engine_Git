package  {
	import Obj;
	//import flash.events.*;
	import Debug;
	import Display;
	import flash.ui.Keyboard;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import com.coreyoneil.collision.CollisionList;
	import particles.Bullet;
	import particles.Flame;
	import ParticleSeeder;
	import Emitter;
	
	public class Weapons extends Obj{
		
		var jumped:Boolean;
		var grounded:Boolean;
		var playerOffSet;
		var emitter:Emitter 
		
		public var _collisionList	:CollisionList;
				
		public function Weapons(name:String="flame_gun", filename:String="flame_gun.png", offSetX=0, offSetY=0) {
			//_collisionList = new CollisionList(this);	
			this.addEventListener(Event.ENTER_FRAME, updateWeapon);
			//Displays.pDO.stage.addEventListener(KeyboardEvent.KEY_DOWN, keyPressed);
			//Display.pDO.stage.addEventListener(KeyboardEvent.KEY_UP, keyReleased);
			//this.emitter = new Emitter(Display.pDO, 10, this.x, this.y);
			super(name, filename, "weapon", offSetX - 30, offSetY-10);
			
		}
				
		public function shoot(event:Event){
			//trace("this" + this.x, this.y);
			this.emitter = new Emitter(Display.screen, this, 20, this.x, this.y, false);
			this.emitter.attach(this);
			//
			//trace("weapon:" + this.x, this.y, this.rotation);
			//trace("emitter:" + emitter.x, emitter.y, emitter.rotation);
			//Display.drawObj(emitter);
		}	
		
		// emitter x and y where not updating and particle needs to update by itself not by emitter
		
		
		public function playFrame(framename:String):void{
			for (var i:uint = 0; i < this.numChildren; i++){				
				//this.getChildAt(i).content.stickman.gotoAndPlay(framename);
				this.getChildAt(i).content[framename].gotoAndPlay(framename);
			}
			//trace ('\t|\t ' +i+'.\t name:' + target_mc.getChildAt(i).name + '\t type:' + typeof (target_mc.getChildAt(i))+ '\t' + target_mc.getChildAt(i).content);
		}
		
		public function updateWeapon(e:Event){
			
			if(emitter) {
				//this.emitter.x = this.x;
				//this.emitter.y = this.y;
				//trace(this.emitter.x)
				///trace(this.x)
			}	
			
		}
		
		

	}
	
}
