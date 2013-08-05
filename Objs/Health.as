package Objs {
	
	import Obj;
	import flash.events.TimerEvent;
	import Emitter;
	import flash.display.BlendMode;
	import fl.transitions.Tween;
	import fl.transitions.easing.*;
	public class Health extends Obj{
		
		var disappear:Emitter;
		
		public function Health(filename:String, offSetX:Number=0, offSetY:Number=0, health_amount:Number=100){
			// constructor code
			super("health", filename, "health", offSetX, offSetY , "BOUNDING_BOX");
			//playFrame("health", "glow");
			soundFx = new PlaySound("heart_beating.mp3");
			blendMode = BlendMode.ADD;
		}
		
		override public function interact(obj:Obj):void{
			//if(this.canGrab){ // if grabables
				
				
				this.life = 0;
				this.shake(10, 5);
				Debug.print("life: " + obj.life + " " + this.life, 6);
				this.kill();
				if(!disappear){
					soundFx.play();
					this.follow(Display.player);
					//Display.player.hb.shake(2, 5);
					if(obj.life < 100) {
						var giveLife = obj.life + (Global.randRange(40, 100));
						//trace(obj.life, giveLife);
						var myTween:Tween = new Tween(obj, "life", None.easeNone, obj.life, giveLife, 1, true);
						
						obj.glow(0xff0000, 1, 15, 1);
						this.glow();
						//var myTween:Tween = new Tween(obj, "scale", None.easeNone, obj.scale, 0, 1, true);
						//var myTween:Tween = new Tween(obj, "vy", None.easeNone, obj.vy, -100, 1, true);
						//obj.life += Global.randRange(10, 50);
					}
					disappear = new Emitter("healthSparkle", "", "emitter", 5);
					disappear.plantSeed(this.x, this.y);
					//disappear.emit(new Point(this.x, this.y));
					Display.screen.addChild(disappear);
					//var obj2 = getObjByName("ui");
					//var myTween:Tween = new Tween(obj2, "alpha",None.easeNone, obj2.alpha, 0, 1, true);
				}
				
				
				
			//}
		}
		
		
		
		override public function topBound(object:Obj){			
				
		}		
		
		override public function leftBound(object:Obj){
			
		}
		
		override public function rightBound(object:Obj){
			
		}
		
		override public function bottomBound(object:Obj){
			
		}
		
		
		override public function kill(){
			die(0.5);
		}
		
				
	}
	
}
