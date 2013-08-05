package  {
	import Obj;
	//import flash.events.*;
	import Debug;
	import Display;
	import flash.ui.Keyboard;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	//import flash.ui.Mouse;
	import com.coreyoneil.collision.CollisionList;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	import fl.transitions.Tween;
	import fl.transitions.easing.*;
	import HealthBar;
	
	public class Player extends Obj{
		
		public var leftPressed:Boolean = false;
		public var rightPressed:Boolean = false;
		public var upPressed:Boolean = false;
		public var downPressed:Boolean = false;
						
		public var regenerate:Number = 0.2;
		
		public var jumpConstant:Number = -28;
		public var maxSpeedConstant:Number = 18;
		public var speedConstant:Number = 4;
		
		public var animationState:String = "standing";
				
		public var doubleJumpReady:Boolean = false;
		public var upReleasedInAir:Boolean = false;
		
		public var hb:HealthBar;
		
		public function Player(name:String="", filename="", offSetX=0, offSetY=0) {
			this.friction = 0.95;			
			super(name, filename, "player", offSetX, offSetY, "POINT");
		}
		
		override public function init(){
			Display.world.watch(); // this causes the jetpack and weapon lag if they are not near the same onnEnterFrame Beat they will be off.
			//Display.cam.attachTo(this);
			Display.pDO.stage.addEventListener(MouseEvent.MOUSE_MOVE, mouseMove);
			Display.pDO.stage.addEventListener(MouseEvent.MOUSE_DOWN, mouseDown);
			Display.pDO.stage.addEventListener(MouseEvent.MOUSE_UP, mouseUp); 
						
			Display.pDO.stage.addEventListener(KeyboardEvent.KEY_DOWN, keyDownHandler);
			Display.pDO.stage.addEventListener(KeyboardEvent.KEY_UP, keyUpHandler);
			
			downBumpPoint 	= new Point(offSetX + (this.width/2), offSetY + this.height-(this.height * .2));
			
			watch();
			
			//Display.cam.createBound(this.x, this.y, 600, 300);
		}
		
		override public function onAppear(){
			//Display.world.watch();
			
		}
		
		override public function damaged(){
			Display.cam.shake(5, 15);
			//Display.player.shake(5, 10);
			
			
		}
			
		override public function update(){
			
			moveArm();
			//movement
			if(leftPressed){
				this.vx -= speedConstant;		 
			} else if(rightPressed){
				this.vx += speedConstant;
			}
			
			if(this.vx > maxSpeedConstant){ //moving right
				 this.vx = maxSpeedConstant;
			} else if(this.vx < (maxSpeedConstant * -1)){ //moving left
				 this.vx = (maxSpeedConstant * -1);
			}
		 
			if(Math.abs(this.vx) < 2.0) this.vx *= 0.8; 
			
			///////Start Double Jump - @ bottomBound
			if(upPressed == false){ // if the player releases the up arrow key
				upReleasedInAir = true; // set the variable to true
				//trace("upReleasedInAir");
			}
			
			if(doubleJumpReady && upReleasedInAir){ // if both variables are true
				if(upPressed){ //and if the up arrow is pressed
					//trace("doubleJump!");
					//playFrame("stickman", "jumping");
					this.vy = jumpConstant; //set the y speed to the jump constant
					doubleJumpReady = false; //prevent additional double jumps
				}
			 }			
			///////End Double Jump
						
			/*if(this.isCurrentFrameLabel("stickman", animationState)){
				 playFrame("stickman", animationState);
				 //trace(animationState);
			}	*/		
			
			var jumpAniHeight = -3;
			if( ( (leftPressed || rightPressed) && Math.abs(vx) > 1)  && dying == false && !(vy < jumpAniHeight)&& !(vy > (jumpAniHeight*-1))){
				
				 if(grabbingOnTo == null){
					if(rightPressed ) direction = Global.Right;
				 	if(leftPressed ) direction = Global.Left;
				 }
				
				 if(direction == Global.Right && rightPressed) animationState = "run";
				 if(direction == Global.Right && leftPressed) animationState = "run_backwards";
				 
				 if(direction == Global.Left && rightPressed) animationState = "run_backwards";
				 if(direction == Global.Left && leftPressed) animationState = "run";
				// if(!this.isCurrentFrameLabel("stickman", animationState)){
					 playFrame("stickman", animationState);
				// }
				 
				 
				 
			}else if( vy < jumpAniHeight){
				 animationState = "jumping";
				 playFrame("stickman", animationState);
			}else if(dying == true){
				animationState = "die";
				playFrame("stickman", animationState);
			}else if( vy > 2){
				animationState = "fall";
				playFrame("stickman", animationState);
			}else{
				
				if(this.life < 100){
					//trace("regenerating");
					
					this.life += Math.round(Global.randRange(0,1));
					this.getObjByName("hud").healthBar.glow(0x337300, 1, 25, 0.2, 1);
					this.glow(0x337300, 1, 10, 0.2, 1);
				}
				animationState = "standing";
				playFrame("stickman", animationState);
			}
			//movement	
			
			for(var i:uint = 0; i < objects.length; i++)
			{
				if(objects[i].type != "player"){
					if(this.checkCollisionWith(objects[i]) ){
						switch(objects[i].type){							
							case "weapon":
								this.grab(objects[i], 0, 40);								
							break;
							
							default:
							case "health":
							case "enemy":
								//this.life--;
								objects[i].interact(this);
								//trace("life:" + life);
							break;
						}
					}
				}
			}
									
			//moveArm();
						
			if(Global.MouseDown == true){
				if(grabbingOnTo){
					switch(grabbingOnTo.type){
						case "weapon": grabbingOnTo.interact(this);	 break;
					}
				}
			}
			
			if(this.life < 100 && animationState == "standing"){
					//trace("regenerating");
					this.life += Math.round(Global.randRange(0,1));
					this.getObjByName("hud").healthBar.glow(0x337300, 1, 25, 0.2, 1);
					this.glow(0x337300, 1, 10, 0.2, 1);
					
				}
			
			
			if( downPressed && animationState == "fall"){
				vy += 1.0;
				if(grounded == true) {
					//trace(vy);
					Display.cam.shake(5, 10);
					this.damage(this);
				}
			}
			
			
			
			if(grounded && lastCollissionObj){
				//trace("downBumping");
				if( lastCollissionObj.type =="floor") Display.cam.adjustBottomBound(this.y);
				//object.bottomBound(this);
				//bringToGround(object);
				if(upPressed){ //and if the up arrow is pressed
					//playFrame("stickman", "jumping");
					vy = jumpConstant; //set the y speed to the jump constant
					upReleasedInAir = false; //upon landing, reset to false
					doubleJumpReady = true; //upon landing, reset to true
					//trace("jumpPresse");
				}
			}
			
			
			
			
			
			if(dying != true){
				if(!isAlive()) kill();
			}
			
			
			
			if(this.dying == true){
				animationState = "die";
				playFrame("stickman", animationState);
				if(this.grounded == true){
					this.removeFromCollisionList(objects);
					
				}
				
				
			}
			
			
		}
		
		public function playerExclusionList(item){
				switch(item){
					case "":
					break;
				}
			}
		
		function mouseMove(event:MouseEvent){
			
		}
		
		function mouseDown(event:MouseEvent){
			Global.MouseDown = true;			
		}
		
		function mouseUp(event:MouseEvent){			
			Global.MouseDown = false;			
		}
		
		override public function bottomBound(object:Obj){
			bringToGround(object);			
		}
		
		override public function boxBound(object:Obj){			
			object.boxBound(this);
		}
		
		override public function topBound(object:Obj){			
			if(this.vy < 0){
				var dif = object.y - (this.y ) ;
				this.vy = (this.vy / dif) * 0.8;
			}
			
		}
						
		
		
		override public function leftBound(object:Obj){
			object.leftBound(this);
		}
		
		override public function rightBound(object:Obj){
			object.rightBound(this);
		}
		
		function keyDownHandler(e:KeyboardEvent):void{
			if(e.keyCode == Keyboard.CONTROL){
				Global.MouseDown = true;				
			}
			if(e.keyCode == Keyboard.LEFT || e.keyCode == 65){
				leftPressed = true;
			
			} else if(e.keyCode == Keyboard.RIGHT || e.keyCode == 68){
				rightPressed = true;
			
			} else if(e.keyCode == Keyboard.UP || e.keyCode == 87 || e.keyCode == Keyboard.SPACE){
				upPressed = true;
			
			} else if(e.keyCode == Keyboard.DOWN || e.keyCode == 83){
				downPressed = true;
			}	
		}
		
		function keyUpHandler(e:KeyboardEvent):void{
			if(e.keyCode == Keyboard.CONTROL){
				Global.MouseDown = false;				
			}
			if(e.keyCode == Keyboard.LEFT || e.keyCode == 65){
				leftPressed = false;
			
			} else if(e.keyCode == Keyboard.RIGHT || e.keyCode == 68){
				rightPressed = false;
			
			} else if(e.keyCode == Keyboard.UP || e.keyCode == 87 || e.keyCode == Keyboard.SPACE){
				upPressed = false;
			
			} else if(e.keyCode == Keyboard.DOWN || e.keyCode == 83){
				downPressed = false;
			}	
		}
		
		function moveArm():void{
			var dir = this.getDirectionToObj(Display.myCursor);
			if(grabbingOnTo){	
				var Degrees = this.getDegreesByMouse();				
				grabbingOnTo.rotation = Degrees * this.direction;		
				this.direction = dir;
				//trace(direction, Degrees);
			}
		}		
		
		
		override public function kill(){
			if(dying == true) return;
			//this.removeFromCollisionList(objects);
			trace("kill " +  this.name);
			life = 0;
			this.drop();
			
			
			var enemy:Array = objects;
			for(var i=0; i < enemy.length; i++){
				enemy[i].stopFollowing();
			}
			
			//if(this.hasEventListener(Event.ENTER_FRAME)){
				
				
				Display.pDO.stage.removeEventListener(MouseEvent.MOUSE_MOVE, mouseMove);
				Display.pDO.stage.removeEventListener(MouseEvent.MOUSE_DOWN, mouseDown);
				Display.pDO.stage.removeEventListener(MouseEvent.MOUSE_UP, mouseUp);
							
				Display.pDO.stage.removeEventListener(KeyboardEvent.KEY_DOWN, keyDownHandler);
				Display.pDO.stage.removeEventListener(KeyboardEvent.KEY_UP, keyUpHandler);
				//Display.pDO.stage.removeEventListener(Event.ENTER_FRAME, updatePlayer);
				removeEventListener(Event.ENTER_FRAME, updateObject);
			//}
			
			var obj2 = getObjByName("death");
			if(!obj2.alpha) obj2.alpha = 0;
			var myTween:Tween = new Tween(obj2, "alpha",None.easeNone, obj2.alpha, 1, 0.5, true);
			
			die(7);
		}
		
		
		override public function deconstruct():void{
			
			var obj2 = getObjByName("death");
			trace(obj2.name);
			var myTween:Tween = new Tween(obj2, "alpha",None.easeNone, obj2.alpha, 0, 1, true);
			Display.cam.stopFocusing();
			if(Display.myCursor)Display.cam.attachTo(Display.myCursor);
			Display.cam.adjustBottomBound(-3000);
			
			Display.player = null;
			
			trace("Player Deconstruct:" + this.name);
			
									
		}
				
	}
}