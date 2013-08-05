package  vehicles{
	
	import Obj;
	//import PlayerController;
	import Vehicle;
	import vehicles.JetPakFlames;
	import flash.geom.Point;
	import Display;
	
	public class JetPak extends Vehicle{
		
		
		//var controller:PlayerController;
		var flame;
		var instructions:Obj;
		var getInSoundFx:PlaySound;
		public function JetPak(name:String="jetpak", filename="jetpak.swf", offSetX:Number=-35, offSetY:Number=10) {
			// constructor code
			super(name, filename, offSetX, offSetY);
			soundFx = new PlaySound("jetpak.mp3");
			getInSoundFx = new PlaySound("armor_put_on.mp3")
		}
		
		override public function init(){
			downBumpPoint 	= new Point(offSetX + (this.width/2), offSetY + 80 );
		}
		
		override public function onAppear(){
			//this.xspeed += 0.1;
			trace("working");
			
			instructions = new Obj("jetpak_instructions", "jetpak_instructions.png");
			Display.screen.addChild(instructions);
			
			watch(); // causes lag error
		}
		
		override public function update(){
			
			//controller = Display.world.player.controller;
			//if(Display.hud)Display.hud.text2.text = this.y;
			var obj = this.attachedTo;
			
			
			if(obj){
				if(Display.player.upPressed){
					obj.doubleJumpReady = false;
					
					obj.vy -= 1.40; //this.vy = obj.vy -= 1.40;
					if(Math.abs(this.y) < Display.world.ATMOSPHERE_H){
						Display.cam.adjustBottomBound(this.y);
					}
					
					
					
					flame = new JetPakFlames(new Point( (-8 ), 80));
					this.addChild(flame);
					flame = new JetPakFlames(new Point( (-14 ), 80));
					this.addChild(flame);
					if(isCurrentFrameLabel("jetpak", "flying") != true){
						playFrame("jetpak", "flying");
						this.soundFx.play(1, Global.SOUND_LVL_SOUND_EFFECTS);
					}
					instructions.kill();
			
				}else{
					if(isCurrentFrameLabel("jetpak", "flying") != true){
						playFrame("jetpak", "idle");
						this.soundFx.stop();
					}
				}
				
				if(!obj.isAlive()){
					detach();
				}
				
			}
			if(instructions){
				instructions.x = this.x-this.width/2-instructions.width/2;
				instructions.y = this.y-120;
			}
			
			
			
		}
		
		override public function interact(object:Obj):void{
			if(object.type == "player"){
				//Display.world.player.controller.stopWatchingKeyboard();
				//this.removeFromCollisionList(objects);
				this.attach(object);
				//addPassenger(object);
				//soundFx.play();
				
				getInSoundFx.play();
				//controller = new InputController();
				//Display.cam.addToFocus(this);
				
			}
		}
		
		public function accelerate(){
			
		}
		
		override public function topBound(object:Obj){			
				
		}
						
		
		override public function leftBound(object:Obj){
			
		}
		
		override public function rightBound(object:Obj){
		
		}
		
	}
	
}
