/**************************************************
*
*
*
***************************************************/

package{	
	import fl.transitions.Tween;
	import fl.transitions.easing.*;
	import flash.display.StageScaleMode;
	import flash.display.StageAlign;
	import flash.display.MovieClip;
	import flash.display.DisplayObject;
	import flash.events.Event;
	import Debug;
	import Global;
	import Display;	
	import ImageLoader;
	import flash.ui.Mouse;
	import flash.filters.GlowFilter;
	import flash.display.BlendMode;
	import flash.filters.BitmapFilter;
	import flash.filters.BitmapFilterQuality;
	import flash.filters.BlurFilter;
	import flash.utils.Timer;
	import flash.events.TimerEvent;
	import flash.geom.Point;
	import GameScore;
	import fl.transitions.TweenEvent;
	import fl.motion.Color;
	import com.coreyoneil.collision.CollisionList;
	import World;
	import PlaySound;
	import flash.media.Sound;
	import flash.utils.Timer;
	import flash.events.TimerEvent;
	
	public class Obj extends MovieClip{
		public var soundFx:PlaySound;
		public var myTween						:Tween;
		public var glowing						:Boolean = false;
		public var ObjAsset;
		public static var objects				:Array;
		public static var enemies				:Array;
		public static var floors				:Array;
		public static var misc:Array;
		public var radius						:Number = 40;
		public var type							:String;
		public var passThrough					:Boolean = false;
		public var following					:Obj;
		public var grabbingOnTo					:*= null;
		public var isGrabbed					:Boolean = false;
		public var canGrab						:Boolean = false;
		public var attachedTo					:Obj = null;
		public var lockedRoationTo				:Obj;
		public var lockedRoationToOffSet		:Number;
		public var lockedRotationDegreesFrom	:Number;
		public var lockedRotationDegreesTo		:Number;
		public var life							:int = 100;
		public var origLife						:int = 100;
		public var collisionType				:String = "NONE";
		public var collisionLayer				:Obj;
		public var attackStrength				:Number = 0.1;
		
		public var lastCollissionObj:Obj;
		public var leftBumpPoint				:Point = new Point(-20, 35);
		public var rightBumpPoint 				:Point = new Point(20, 35);
		public var upBumpPoint 					:Point = new Point(20, 0);
		public var downBumpPoint 				:Point = new Point(20, 70);
		
		public var AllBumping					:Boolean 	= false;
		public var rightBumping					:Boolean 	= false;
		public var leftBumping					:Boolean 	= false;
		public var upBumping					:Boolean 	= false;
		public var downBumping					:Boolean 	= false;
		
		public var watching						:Boolean = false;
		
		private var deathTimer:Timer;
		
		public var Velocity:uint;
		
		public var grounded:Boolean=true;
		
		public var dying:Boolean = false;
		
		public var grabOffSetX:int;
		public var grabOffSetY:int;
		
		public var asset:ImageLoader;				
		
		public var color:uint;
		public var vx:Number = 0;
		public var vy:Number = 0;
		public var mass:Number = 120;
		public var xspeed:Number = 0;
		public var yspeed:Number = 0;
		public var friction:Number = .95;
		public var speed:Number= 0;
		
		public var filename:String;
		
		public var offSetX:int=0;
		public var offSetY:int=0;
		
		public var shakeTime:Number= 2;
		public var magnitude:Number= 2;
		
		public var skipFadin:Boolean = false;
		protected var glowFilter:GlowFilter;
		private var glowTimer:Timer;
		
		public var update_i:Timer;
		
		public function Obj(name:String="", filename:String="", type:String="object", offSetX:Number=0, offSetY:Number=0, collideType:String="NONE", skipFadin:Boolean=false ){
			
			if(!objects) objects = new Array();
			if(!floors) floors = new Array();
			if(!enemies) enemies = new Array();
			if(!misc) misc = new Array();
			
			this.skipFadin = skipFadin;
			var img = addImage(Global.Path + filename, offSetX, offSetY, skipFadin);		
			this.name = name;
			this.type = type;
			collisionLayer = this;
			this.radius = 50;		
			mass 	= radius * 600;
			speed	= 0;
			life = 100;
			//cdk = new CDK();
			this.offSetY = offSetY;
			this.offSetX = offSetX;
			this.collisionType = collideType;
			
			Debug.print("Type:["+type+"] Name:[" + name +"]" + "Type:["+type+"] OffSetX:[" + offSetX +"] offSetY:[" + offSetY +"] collideType:[" + collideType +"] skipFadin:[" + skipFadin +"]", 1);
			
		}
		
		public function _init(){
			
			this.radius = this.width + this.height;
			leftBumpPoint 	= new Point(offSetX, offSetY + (this.height/2)); // acount for image offset later
			upBumpPoint 	= new Point(offSetX + (this.width/2), offSetY);
			rightBumpPoint 	= new Point(offSetX + this.width, offSetY + (this.height/2));
			downBumpPoint 	= new Point(offSetX + (this.width/2), offSetY + this.height-(this.height * .1));
			
			init();
			this.origLife = this.life;
			var drawFrame = 0;
			
			if(drawFrame ){
				
				var square:MovieClip = new MovieClip();
			
				square.graphics.lineStyle(1,0x00ff00); 
				
				var w = 2;
				var h = 2;
				
				if(drawFrame == 1){
					square.graphics.drawRect(offSetX,offSetY,this.width,this.height);
				}
				
				if(drawFrame == 2){
					square.graphics.drawRect(offSetX,offSetY,this.width,this.height);
					square.graphics.drawRect(leftBumpPoint.x, leftBumpPoint.y, w, h);
					square.graphics.drawRect(upBumpPoint.x, upBumpPoint.y, w, h);
					square.graphics.drawRect(rightBumpPoint.x, rightBumpPoint.y, w, h);
					square.graphics.drawRect(downBumpPoint.x, downBumpPoint.y, w, h);
				}
				
				if(drawFrame == 3){
					if(this.collisionType == "POINT"){
						square.graphics.drawRect(leftBumpPoint.x, leftBumpPoint.y, w, h);
						square.graphics.drawRect(upBumpPoint.x, upBumpPoint.y, w, h);
						square.graphics.drawRect(rightBumpPoint.x, rightBumpPoint.y, w, h);
						square.graphics.drawRect(downBumpPoint.x, downBumpPoint.y, w, h);
					}
					if(this.collisionType == "BOUNDING_BOX"){
						square.graphics.drawRect(offSetX,offSetY,this.width,this.height);
					}		
					
					if(this.collisionType == "PER_PIXLE"){
						square.graphics.lineStyle(1,0xff0000); 
						square.graphics.drawRect(offSetX,offSetY,this.width,this.height);
					}		
				}				
				
				square.graphics.endFill();
				addChild(square);			
				
			}
						
			if(this.skipFadin == false){
				myTween = new Tween(this, "alpha",None.easeNone, 0, 1, 1, true);
				myTween.addEventListener(TweenEvent.MOTION_FINISH, _fadeIn);
			}else{
				this.onAppear();
			}			
			//trace("this.x", this.x, "this.y", this.y);
		}
		
		public function getObjByName(objName:String){
			return Display.pDO.getChildByName(objName);
		}
		
		private function _fadeIn(e:Event){
			onAppear();
		}
		
		
		public function onAppear(){
			//override function
		}
		
		public function init(){
			//override function			
		}
		
		/*public function watch(){
			if(watching != true){
				if(hasEventListener(Event.ENTER_FRAME)){
					removeEventListener(Event.ENTER_FRAME, updateObject);
				}				
				addEventListener(Event.ENTER_FRAME, updateObject);
				watching = true;
				//trace("watching: " + this.name);
			}
		}*/
		
		public function stopWatching(){
			if(watching == true){
				//trace("stop watching: " + this.name);
				//if(hasEventListener(Event.ENTER_FRAME)){
					removeEventListener(Event.ENTER_FRAME, updateObject);
					if(update_i)update_i.stop();
				//}
				watching = false;
			}
		}
		
		public function watch(fps:int=3){
			if(watching != true){
				watching = true;
				
				var fps_base = "FPS";
				
				switch(fps_base){
					
					case "FPS" :
						if(!hasEventListener(Event.ENTER_FRAME)){
							removeEventListener(Event.ENTER_FRAME, updateObject);
							addEventListener(Event.ENTER_FRAME, updateObject);
						}				
					break;
					
					case "TIMER" :				
						if(!hasEventListener(TimerEvent.TIMER)){
								update_i = new Timer(fps);
								update_i.start();
								update_i.addEventListener(TimerEvent.TIMER, updateObjectTimer, false, 0, true);						
								//trace("watching: " + this.name);
						}
					break;
				}
				
			}
		}
		
		public function loadingComplete(event:Event){
			_init();
			//ObjAsset = ObjAsset.getContentFromPreviousLoad();
			//trace("LoadingComplete", this.x, this.y, ObjAsset.url);
			if(hasEventListener("loading_complete")){				
				//trace("loading_complete Removed");
				
				
				removeEventListener("loading_complete", loadingComplete);
				
			}
		}
		
		//used in case you need to pass through update in an extended class @see Emitter.as @_update() + update()
		protected function _update(){
			//override function
		}
		
		public function update(){
			//override function
		}
		
		protected function updateObjectTimer(e:TimerEvent){	
			updateObject(new Event("event"));
		}
		
		protected function updateObject(e:Event){	
			
		
			var obj = this;
			if(attachedTo){
				obj = this.attachedTo;
				this.x = obj.x;
				this.y = obj.y;
				//if (Degrees > lockedRotationDegreesFrom && Degrees < lockedRotationDegreesTo) {
					//this.rotation = - this.lockedRoationToOffSet;
				//}
				this.direction = obj.direction ;
			}else if(grabbingOnTo){
				obj = this.grabbingOnTo;
				obj.x = this.x + this.grabOffSetX;
				obj.y = this.y + this.grabOffSetY;
				obj.direction = this.direction ;
			}else if(following){
				obj = this.following;				
				this.direction = getDirectionToObj(obj);
				
			}
			
			if (shakeTime > 0) {
				//trace("shaking");
				obj.x += Math.random()*obj.magnitude-Math.random()*magnitude;
				obj.y += Math.random()*obj.magnitude-Math.random()*magnitude;
				shakeTime--
			} 
			
			if(Math.abs(this.vx) < 0.5) this.vx = 0; //
			if(Math.abs(this.vy) < 0.5) this.vy = 0;
			
			_update();
			update();
			
			if(dying != true){
				if(!isAlive()) kill();
			}
			
		}
		
		public function damage(object:Obj){
			if(object.isAlive()){
				//trace("attack: " + object.name + " with " + this.name +  this.attackStrength);
				object.life -= this.attackStrength;
				object.vx += this.attackStrength/2 * this.direction;				
				//trace(this.attackStrength * this.direction, this.direction, object.direction);
			}			
			object.damaged();
		}
		
		public function damaged(){
			GameScore.addScore();			
		}
		
		
		public function setTint(color:uint=0xff0000, alpha:Number=1){
			var c:Color = new Color();
			c.setTint (color, alpha);			
			this.transform.colorTransform = c;
		}
		
		public function shake(shakeTime:Number, magnitude:Number){
			//if(shakeTime <= 0){
				this.shakeTime=shakeTime;
				this.magnitude=magnitude;
				watch();
			//}
		}
		
		public function glow(color=0xff0000, strength:Number=1, spread:Number=25, glowTime:Number=1, repeatCount:Number=1){
			if(!glowing){
				glowing = true;
				glowFilter = new GlowFilter();
				glowFilter.color = color;
				glowFilter.alpha = strength;
				glowFilter.blurX = spread;
				glowFilter.blurY = spread;
				glowFilter.quality = BitmapFilterQuality.HIGH;
								
				var filtersArray:Array = [glowFilter];			
				this.filters = filtersArray;
				
				glowTimer = new Timer(glowTime * 1000, 1);
				glowTimer.start();
				glowTimer.addEventListener(TimerEvent.TIMER_COMPLETE, this.stopGlow);
			}
			
		}
		
		public function stopGlow($e:TimerEvent){
			glowing = false;
			glowTimer.stop();
			glowTimer = null;
			this.filters = [];
			//trace("stopGlowing");
		}
		
		public function interact(obj:Obj):void{
			
		}
		
		public function drop(){
			if(this.grabbingOnTo){
				trace("Dropped:" + grabbingOnTo.name, grabbingOnTo.type);
				if(this.type == "weapon"){
					//Remove Display.CreateCustomCursor("pak/target.png"); // this goes in the weapons class
				}
				grabbingOnTo.dropped();
				this.grabbingOnTo.isGrabbed = false;
				this.grabbingOnTo = null;
			}
			
		}
		
		public function dropped(){
			
			trace("dropped: " + this.type);
		}
		
		//Made for the item grabbed
		public function grabbed(){ 
			//override function
			trace("grabbed: " + this.type, this.isGrabbed);
				
		}
		
		public function grab(obj:Obj, offSetX=0, offSetY=0){
			if(this.grabbingOnTo != obj && obj.isAlive()){
				if(this.grabbingOnTo) this.drop(); 
				trace("grab: " + obj.type);
				
				obj.isGrabbed = true;
				obj.grabbed();
				
				obj.removeFromCollisionList(objects); // this will probably go in grab
								
				trace(obj.name,obj.type);
				this.grabbingOnTo = obj;
				
				this.grabOffSetX = offSetX;
				this.grabOffSetY = offSetY;
										
				watch();
			}
		}
		
		public function attach(obj:Obj, objRotation=0){
			Debug.print("Obj::attach(" + obj.name + ")", Debug.OBJECT_CREATE);
			this.attachedTo = obj;
			this.x = obj.x;
			this.y = obj.y;
			this.rotation = objRotation;
			this.removeFromCollisionList(objects);
			watch();
		}
		
		public function detach(){
			Debug.print("Obj::detach(" + this.name + ")", Debug.OBJECT_DESTROY);
			this.attachedTo = null;
			//this.x = obj.x;
			this.y -= 2;
			this.rotation = 0;
			detached();
		}
		
		public function detached(){
			this.addToCollisionList();
			
		}
		
		public function lockRotationToObj(obj:Obj, offSetDegrees:Number, degreesFrom:Number=-90, degreesTo:Number=45){		 // not finished
			lockedRoationTo = obj;
			lockedRoationToOffSet = offSetDegrees;
			lockedRotationDegreesFrom = degreesFrom;
			lockedRotationDegreesTo = degreesTo;
			//obj.rotation += lockedRoationToOffSet;
		}
		
		
		
		public function isPointBoundingCollision(object:Obj):Boolean{
				
				
				if(object.hitTestPoint(this.x + leftBumpPoint.x, this.y + leftBumpPoint.y, true)){
					//trace("leftBumping");
					leftBumping = true;
				} else {
					leftBumping = false;
				}
				 
				if(object.hitTestPoint(this.x + rightBumpPoint.x, this.y + rightBumpPoint.y, true)){
					//trace("rightBumping");
					rightBumping = true;
				} else {
					rightBumping = false;
				}
				 
				if(object.hitTestPoint(this.x + upBumpPoint.x, this.y + upBumpPoint.y, true)){
					//trace("upBumping");
					upBumping = true;
				} else {
					upBumping = false;
				}
				
				if(object.hitTestPoint(this.x + downBumpPoint.x, this.y + downBumpPoint.y, true)){
					//if(this.type == "player") trace("downBumping: ", object.type);
					downBumping = true;
					//this.grounded = true;
				} else {
					downBumping = false;
					//this.grounded = false;
				}				
				
				if(upBumping) 		topBound(object);				
				if(downBumping)		bottomBound(object);				
				if(leftBumping)		leftBound(object);				
				if(rightBumping) 	rightBound(object);
				
				if(upBumping || downBumping || leftBumping || rightBumping) {
					//if(!downBumping) trace("PointBound Collision Between: " + this.type + " and " + object.type);
					lastCollissionObj = object;
					return true;
				}
			return false;
		}
		
		public function isBoxBoundingCollision(object:Obj):Boolean{
								
				if(object.hitTestObject(this)){
					AllBumping = true;					
				} else {
					AllBumping = false;
				}
				
				if(AllBumping) 	boxBound(object);
				
				if(AllBumping) {
					//trace("BoxBound Collision Between: " + this.type + " and " + object.type);
					lastCollissionObj = object
					return true;
				}else{
					return false;
				}
								
		}
		
		
		public function isPerPixleCollision(object:Obj){
		//if(!this.isPointBoundingCollision(object)) return;
		_collisionList = [];
		var _collisionList = new CollisionList(this.ObjAsset);	
		_collisionList.alphaThreshold = .35;
		_collisionList.addItem(object.ObjAsset);
		
		var collisions:Array = _collisionList.checkCollisions();
			
			if(collisions.length)
			{
				var collision:Object = collisions[0];
				var angle:Number = collision.angle;
				var overlap:int = collision.overlapping.length;
				
				var sin:Number = Math.sin(angle);
				var cos:Number = Math.cos(angle);
					
				var vx0:Number = this.vx * cos + this.vy * sin;
				var vy0:Number = this.vy * cos - this.vx * sin;
				
				// Unlike the other examples, here I'm choosing to calculate the amount
				// of bounce based on the objects' masses, with a default mass of 10000 (IMMOVABLE)
				// being used for the drawing the wheel is colliding with.  As such, the only
				// real variable in play here is the current vector of the wheel.
				vx0 = ((this.mass - World.IMMOVABLE) * vx0) / (this.mass + World.IMMOVABLE);
				
				this.vx = vx0 * cos - vy0 * sin;
				this.vy = vy0 * cos + vx0 * sin;
				
				this.vx -= cos * overlap /this.radius;
				this.vy -= sin * overlap / this.radius;
				
				//this.vx += speed;
				//bottomBound(this);
				
				/*if(this.vy > 0){
						//var dif = this.diff(this.y, object.y + overlap);
						//if(this.type=="player") trace("dif", dif);
						//trace("angle: ", angle, "overlap: ",overlap);
						object1.downBumping = true;
						object1.grounded = true;
						object1.vy -= overlap ;
						trace("angle: ", angle, "overlap: ",overlap);
					}else {
						//object1.downBumping = false;
						//object.grounded = false;
					}				
				*/
				Debug.print("Per Pixle Collision Between: " + object.type + " and " + this.type, 9);
				if(angle > 1 && angle < 2){
					downBumping = true;
				}else{
					downBumping = false;
				}
				//trace(angle, downBumping);
				//grounded = true;
				lastCollissionObj = object;
				
				//Display.hud.text1.text = object.collisionType;
				
				if(angle) {
					//trace("true");
					return true;
				}else{
					//trace("false");
					return false;
				}
			}else{
				//trace("else");
				downBumping = false;
				return false;
			}
			
		}
		
		public function isPerPixleCollision2(object:Obj){
			
			//if(this.isBoxBoundingCollision(object)){
				
				var _collisionList = new CollisionList(this.collisionLayer);	
				//_collisionList.alphaThreshold = .1;
				_collisionList.addItem(object.collisionLayer);
				
				var collisions:Array = _collisionList.checkCollisions();
				// Handle any collisions detected
				for(var i:int = 0; i < collisions.length; i++)
				{
					// Grab the next collision in the array
					var collision:Object = collisions[i];
				
					// Extract the information I need.
					// Note that I know that object1 is the ball (and not the words) because
					// object1 is always the smaller of the two objects involved in the collision.
					var angle:Number = collision.angle;
					var overlap:int = collision.overlapping.length;
					
					var object1:Obj = collision.object1;
					var object2:Obj = collision.object2;
					
					/*
						Here's the simplest method I'll use for quick physics incorporation.
						This approach is discussed in detail in the book ActionScript 3.0 Animation - Making Things Move!
						by Keith Peters.  It is an excellent book for those looking to get their feet wet in all
						things scripted animation.  In fact, it was a passage in that book that inspired me to
						write up the CDK.  So all in all, I highly recommend it.  :)
					*/
					/*var sin:Number = Math.sin(angle);
					var cos:Number = Math.cos(angle);
						
					var vx0:Number = object.vx * cos + object.vy * sin;
					var vy0:Number = object.vy * cos - object.vx * sin;
					*/
					// I'm reassigning vx0 here because I know the amount of bounce
					// I want in the collision regardless of mass.  I did this in most of the
					// examples because they use the same size ball.  
					//vx0 = 0;
					
					if(this.vy > 0){
						//var dif = this.diff(this.y, object.y + overlap);
						//if(this.type=="player") trace("dif", dif);
						//trace("angle: ", angle, "overlap: ",overlap);
						object1.downBumping = true;
						if(object2.type=="floor")object1.grounded = true;
						object1.vy -= overlap ;
						trace("angle: ", angle, "overlap: ",overlap);
					}else {
						object1.downBumping = false;
						//object.grounded = false;
					}				
						
					
					
					// Otherwise, vx0 would have been further calculated using both objects' masses and velocities, like so:
					// var vx1:Number = object2.vx * cos + object2.vy * sin;
					//vx0 = ((object.mass - object2.mass) * vx0 + 2 * object2.mass * vx1) / (object.mass + object2.mass);
					//this.bringToGround(object);
					
					
					//object.vx = vx0 * cos - vy0 * sin;
					//object.vy = vy0 * cos + vx0 * sin;
					
					//object.vx -= cos * overlap / object.radius;
					//object.vy -= sin * overlap / object.radius;
					
					//analyze(object);
					//Debug.print("object.type: " +  object.type, 1);
					//Debug.print("object.grounded: " +  object.grounded, 1);
					
				
				//}
				
				if(collisions.length) {
					//Display.drawObj(object2);
					trace("Per Pixle Collision Between: " + object2.type + " and " + object1.type);
					//bottomBound(object1);
					lastCollissionObj = object
					return true;
				}else{
					trace("NO Per Pixle Collision Between: " + object2.type + " and " + object1.type);
					object1.downBumping = false;
					object1.grounded = false;
				}
				trace("return false;");
				return false;
			}
		}
		
		public function isPerProxyCollision(object:Obj):Boolean{
			//this returns collision based on distance
			trace("Proxcimity Collision Between: " + this.type + " and " + object.type);
			//isCloseTo(object, 5);					
			lastCollissionObj = object;
			return false;
		}
		
		public function checkCollisionWith(object:Obj):Boolean{
				
				if(this.collisionType.toUpperCase() == "NONE") return false;
					//var collisionType = "POINT";
					//if(this.type == "particle") trace("checkCollisionWith: " + this.name + " and " + object.name);
					switch(collisionType){
						default:
						case "BOUNDING_BOX":
							return isBoxBoundingCollision(object);
						break;
						
						case "POINT":
							return isPointBoundingCollision(object);
						break;
						
						case "PER_PIXLE":
							return isPerPixleCollision(object);
						break;		
						
						case "PROXY":
							return isPerProxyCollision(object);
						break;		
					}
				
				return false;
									
		}
		
		public function adjustCollisionMiss(object:Obj){
			
		}
		
		public function boxBound(object:Obj){			
			
			if(this.vy < 0){
				this.vy *= -0.75;
			}
			
			if(this.vy > 0){
				this.bringToGround(this);
				
			}
						
			if(this.vx > 0){
				this.vx *= -0.75;
			}
			
			if(this.vx < 0){
				this.vx *= -0.75;
			}
		}
		
		public function topBound(object:Obj){			
			if(object.vy < 0){
				object.vy *= -0.6;
			}			
		}
						
		public function bottomBound(object:Obj){
			bringToGround(object);
			//object.adjustCollisionMiss(object);				
						
		}
		
		public function leftBound(object:Obj){
			if(object.vx < 0){
				object.vx *= -0.4;
			}
		}
		
		public function rightBound(object:Obj){
			if(object.vx > 0){
				object.vx *= -0.4;
			}
		}	
		
		/*public function removeFromCollisionList(collisionList:Array){
			if(this.collisionType=="NONE") return;
			var itemPosInArray = collisionList.indexOf(this);
			a
			if(itemPosInArray != -1){
				collisionList.splice(itemPosInArray, 1);
				Debug.print("Removed From Collision List: " + this.name, Debug.OBJECT_DETAILS);
				trace("Removed From Collision List: " + this.name);
				trace("itemPosInArray:" + itemPosInArray + " " + this.name);
			}
		}*/
		
		public function removeFromCollisionList(collisionList:Array){
			//if(this.collisionType=="NONE") return;
						
			//Display.hud.text1.text = collisionList.length;
			
			for(var j:int = 0; j < collisionList.length; j++)	{							
				if( collisionList[j] == this ){					
					//trace("Removed From Collision List: " + collisionList[j].name);
					collisionList.splice(j, 1);
				}
				
			}
			
			
		}
		
		public function addToCollisionList(){
			
			switch(this.type){					
				case "floor":	
					//objects.push(this);
					if(floors.indexOf(this) == -1) floors.push(this);
					//trace(" floor " + this.type);
				break;
				case "structure":
					if(misc.indexOf(this) == -1) misc.push(this);
					if(enemies.indexOf(this) == -1) enemies.push(this);
					
				break;
				case "enemy":
					if(enemies.indexOf(this) == -1) enemies.push(this);
					
				case "vehicle":					
				case "weapon":					
				case "water":				
				
				case "object":
				case "health":
				case "player":	
					if(objects.indexOf(this) == -1) objects.push(this);
					//objects.push(this);//.push(object);
				break;
				
				
				case "particle":		
				break;
				case "foreground":
				case "background":
				case "misc":
					if(misc.indexOf(this) == -1) misc.push(this);
				break;
				default:
				break;
					
			}
		}
		
		public function moveTo(x, y){
			this.vx = x;
			this.vy = y;
		}
		
		public function get vDirection(){
			if(this.vy < 0) {
				return Global.Up;
			}else if(this.vy > 0){
				return Global.Down;
			}else if(this.vy == 0){
				return 0;
			}
		}
		
		public function set vDirection(dir:Number ){
			this.scaleY = dir;				
		}
		
		public function turnAround(){
			if(!this.following){
			this.direction = this.direction * -1;
			this.xspeed = this.speed * direction;
			//trace("turning around");
			}
		}
		
		public function get direction(){
			if(this.scaleX > 0) {
				return Global.Right;
			}else{
				return Global.Left;
			}
		}
		
		public function set direction(dir:Number ){
			this.scaleX = dir;				
		}
		
		public function getDirectionToObj(obj:Obj){
			if(!obj) return;
			var directionValue = (this.x + this.width/2) -  (obj.x + obj.width/2 ) ;
			//trace(directionValue);
			if(directionValue > 0) {
				return -1;
			}else{
				return 1;
			}
		}
		
		public function isOnScreen():Boolean{
			/*var margin = 100;
			if(((this.x + this.width) > Display.cam.x - margin) && (this.x < (Display.cam.x + Display.cam.width + margin)) &&  ((this.y + this.height) > Display.cam.y - margin) && (this.y  < (Display.cam.y + Display.cam.height+Display.world.ATMOSPHERE_H))) { // +500 temporary fix for offscreen collision
				return true;
			}
			//trace("off screen: " + this.name);
			
			return false; //false to turn culling back on has collision glitches though
			*/
			
			var margin = 0;
			var marginX = this.width;			
			var marginY = this.height;			
			var floorMargin = 250;
			var objectMargin = 0;
						
			switch(this.type){
				case "floor":
					margin = floorMargin;
				break;
				default:
					margin = objectMargin;
				break;
			}
			
			
			if(((this.x + this.width) > Display.cam.x - margin - marginX) && (this.x < (Display.cam.x + Display.cam.width + margin + marginX)) &&  ((this.y + this.height) > Display.cam.y - margin - marginY) && (this.y  < (Display.cam.y + Display.cam.height+margin + marginY))) { // +500 temporary fix for offscreen collision
				return true;
			}
			return false;
		}
		
		public function diff(point1, point2){
			return Math.abs(Math.abs(point1) - Math.abs(point2));
		}
		
		public function bringToGround(object:Obj){
			if(this.vy > 0){
				var dif = this.diff(object.y, this.y + downBumpPoint.y);
				//if(this.type=="player")trace(dif);
				this.vy -= dif * 0.35;
			}
		}
		
		public function isWithInBoundsOf(object:Obj){
			
			var topMargin = 70;
			var bottomMargin = 50;
			var leftMargin = 200;			
			var rightMargin = 200;
			
			
			if( (this.x + this.width) > object.x - leftMargin) 		this.x = object.x - leftMargin
			if( this.x < (object.x + object.width + rightMargin)) 	this.x = object.x + object.width + rightMargin;
			if( (this.y + this.height) > object.y - topMargin) 		this.y = object.y - topMargin;
			if( this.y < (object.y + object.height + bottomMargin)) this.y = object.y + object.height + bottomMargin
				
			/*
			
			if(this.y > (object.height - bottomBoundsChange - topBoundPadding)) this.y = object.height-bottomBoundsChange - topBoundPadding;
			if(this.y < (object.height - (bottomBoundPadding + topBoundPadding))) this.y = object.height - (bottomBoundPadding + topBoundPadding);
						
			if(this.x > (object.x + leftBoundPadding) ) this.x = Display.world.x + leftBoundPadding;
			if(this.x < (Display.world.x - Display.world.width  + Display.screen.stage.stageWidth + (rightBoundPadding+leftBoundPadding)) ) this.x = Display.world.x - Display.world.width + Display.screen.stage.stageWidth + (rightBoundPadding+leftBoundPadding);
			*/
		}
		
		
		
		public function isCloseTo(obj:Obj, distanceFromObj=10){
			
			var directionValue = Math.abs(this.x - obj.x);
			//trace(directionValue);
			if(directionValue < distanceFromObj) {
				return 1;
			}else{
				return -1;
			}
		}
		
		public function follow(obj:Obj){
			if(obj){
				if(obj.isAlive()){
					following = obj;
					this.direction = getDirectionToObj(obj);
					
					Debug.print("Obj::following: " + obj.name + "(" + getDirectionToObj(obj) + ")", Debug.OBJECT_CREATE);
					watch();
					//this.xspeed = this.direction/5;
				}else{
					trace("object is not alive to follow");
				}
			}else{
					trace("object is null and not alive to follow");
				}
		}
		
		public function stopFollowing(){
			if(following){
			Debug.print("no longer following: " + following.type, Debug.OBJECT_DETAILS);
			this.xspeed = this.speed * this.direction;
			following = null;
			}
			//this.direction *= -1;
			
		}
		
		
		
		public function getAngle():void
		{
			/*var end=arrowEnd.getEndPoint();
			var start=arrowStart.getStartPoint();
			var angle = Math.atan((end.y - start.y) / (end.x - start.x));
			var angleInDegrees = angle * 180/Math.PI;
			return(angleInDegrees);*/
	
		}
		
		public function get content(){
			/*for (var i:uint = 0; i < this.numChildren; i++){				
				if(this.getChildAt(i).content){
					return this.getChildAt(i).content;
				}
			}*/
			return ObjAsset.content;
			//trace ('\t|\t ' +i+'.\t name:' + target_mc.getChildAt(i).name + '\t type:' + typeof (target_mc.getChildAt(i))+ '\t' + target_mc.getChildAt(i).content);
		}
		
		public function playFrame(objName, frameName:String):void{
			/*for (var i:uint = 0; i < this.numChildren; i++){				
				if(this.getChildAt(i).content){
					this.getChildAt(i).content[objName].gotoAndPlay(frameName);
				}
			}*/
			//trace ('\t|\t ' +i+'.\t name:' + target_mc.getChildAt(i).name + '\t type:' + typeof (target_mc.getChildAt(i))+ '\t' + target_mc.getChildAt(i).content);
			ObjAsset.content[objName].gotoAndPlay(frameName);
		}
		
		public function isCurrentFrameLabel(objName, frameName:String):Boolean{
			/*for (var i:uint = 0; i < this.numChildren; i++){				
				if( this.getChildAt(i).content[objName].currentLabel == frameName) {
					return true;
				}			
			}
			return false;*/
			if(ObjAsset.content[objName].currentLabel == frameName){
				//trace(ObjAsset.content[objName].currentLabel);
				//trace ('\t|\t ' +i+'.\t name:' + target_mc.getChildAt(i).name + '\t type:' + typeof (target_mc.getChildAt(i))+ '\t' + target_mc.getChildAt(i).content);
				return true;
			
			}
			return false;
			
		}
		
		/**
		 * Moves an object from its current position to a given point and stops.
		 * @param	obj 	The Object to be moved.
		 * @param	target 	The target Point where the object should stop.
		 * @param	speed 	How fast should the object travel per frame.
		 * @param	objRot	Do you want to rotate the object to face the direction of travel?
		 */
		public function moveToPoint(target:Point, speed:Number = 1, objRot:Boolean = false):void
		{
			var obj = this;
			// get the difference between obj and target points.
			var diff:Point = target.subtract(new Point(obj.x, obj.y)); 
			var dist = diff.length;
					
			if (dist <= speed)  // if we will go past when we move just put it in place.
			{
				obj.x = target.x;
				obj.y = target.y;
			}
			else // If we are not there yet. Keep moving.
			{ 
				diff.normalize(1);
				obj.x += diff.x * speed;
				obj.y += diff.y * speed;
						
				if (objRot) // If we want to rotate with our movement direction.
				{ 
					obj.rotation = Math.atan2(diff.y, diff.x) * (180 / Math.PI) + 90;
				}
			}
		}
		
		public function addImage(filename, offSetX, offSetY, skipFadIn:Boolean){
			if(filename){
				this.skipFadin = skipFadIn;
				Debug.print("Image Added: " + filename, 3);				
				
				//addChild(new ImageLoader( filename, offSetX, offSetY, 0, 0, true));		
				ObjAsset = new ImageLoader(filename, offSetX, offSetY);		
				addChild(ObjAsset);
				ObjAsset.addEventListener("loading_complete", loadingComplete);
			}
		}
		
		
		
		public function getDegreesByMouse(target:Obj=null){
			if(!target) target = this;
			var cy:Number = (target.mouseY + target.offSetX); 
			var cx:Number = (target.mouseX + target.offSetY) ;
				
				//var cy:Number = (this.mouseY) - ((this.y)- (Display.screenY + Display.cam.height/2)); 
				//var cx:Number = (this.mouseX) - ((this.x) - (Display.screenX + Display.cam.width/2));
				
				//trace(this.mouseX , this.x);
				//trace(cy , cx);
				// find out the angle
			var Radians:Number = Math.atan2(cy,cx);
				// convert to degrees to rotate
			var Degrees:Number = Radians * 180 / Math.PI;
				// rotate
				
			/*if (Degrees>-90 && Degrees<45) {
				this.rotation = Math.round(Degrees) * scaleX;
			}*/
			return Math.round(Degrees);
		}
		
		public function getDegreesByXY(_X,_Y){
			
			var cy:Number = (_X); 
			var cx:Number = (_Y) ;
				
				//var cy:Number = (this.mouseY) - ((this.y)- (Display.screenY + Display.cam.height/2)); 
				//var cx:Number = (this.mouseX) - ((this.x) - (Display.screenX + Display.cam.width/2));
				
				//trace(this.mouseX , this.x);
				//trace(cy , cx);
				// find out the angle
			var Radians:Number = Math.atan2(cy,cx);
				// convert to degrees to rotate
			var Degrees:Number = Radians * 180 / Math.PI;
				// rotate
				
			/*if (Degrees>-90 && Degrees<45) {
				this.rotation = Math.round(Degrees) * scaleX;
			}*/
			return Math.round(Degrees);
		}
		
		public function kill(){
			die(2);
		}
			
		public function die(dieTime:Number=0){
			if(this.dying == false){				
				this.dying = true;				
				//this.grounded = false;
				if(dieTime == 0){
					//this.alpha = 0;
					removeListenersAndChildren();
					return;
				}
				var myTween:Tween = new Tween(this, "alpha",None.easeNone, this.alpha, 0, dieTime, true);

				//trace(this.name + " Dying");
				deathTimer = new Timer(dieTime * 1000, 1);
				deathTimer.start();
				drop();
				GameScore.addScore();
				//burn
				//launch destroy timer
				deathTimer.addEventListener(TimerEvent.TIMER, this._removeListenersAndChildren);
				
			}
		}
						
		public function isAlive(){
			if(this.life > 0 ){
				return true;
			}else{
				return false;
			}
		}
		
		public function destroy():void{
			die(0);
		}
		public function _removeListenersAndChildren(e:TimerEvent):void{
			deathTimer.removeEventListener(TimerEvent.TIMER, _removeListenersAndChildren);
			deathTimer = null;
			removeListenersAndChildren();
		}
		
		public function removeListenersAndChildren():void{
			this.dying = true;			
			deconstruct();
			stopFollowing(); //stop following // go other direction
			detach();
			drop();
			
			
			
			stopWatching();
			if(this.soundFx) {
				this.soundFx.stop();
				this.soundFx = null;
			}
			//if(this.hasEventListener(Event.ENTER_FRAME)){
				removeEventListener(Event.ENTER_FRAME, updateObject);												
			//}
			
			this.removeFromCollisionList(objects);
			
			this.filters = [];
			
			if(this.ObjAsset){
				removeChild(this.ObjAsset);
			}
			
			while (this.numChildren > 0){
				//trace("child obj remove: " + this.getChildAt(0).name);
				var cls = this.getChildAt(0);
				if ( cls is Obj ) {
					Debug.print("Obj child found on destroyed Obj class(" + this.name + "), destroying child object.", Debug.OBJECT_DESTROY);
					//trace("Obj child found on destroyed Obj class(" + this.name + "), destroying child object("+cls.name+").");
					cls.destroy();
				}
				if ( cls is DisplayObject ) {
					//trace(cls.name + " removeAt(0)");
					this.removeChildAt(0);
				}
				
				if ( cls is Timer ) {
					//trace(cls.name + " time.stop()");
					cls.stop();
					cls = null;
				}
				
				if ( cls is PlaySound || cls is Sound ) {
					//trace(cls.name + " Sound.stop()");
					cls.stop();
					cls = null;
				}
			}		
			
			
			
			if(this.parent != null)	this.parent.removeChild(this);
			
			//trace(this.name);
		}
		
		
		public function deconstruct():void{
			
		}
		
		public function clone(...cloneable:Array){
			// Cloneable properties.
       
		

        /**
         * Returns a new Thing with the same properties.
         */
       // cloneable = ["x","y","life","ObjAsset","name","type"];
      				
			
				var t:Obj = new Obj();
				trace(cloneable);
				if(cloneable.length > 0){		
				
					trace("cloned only: ", cloneable);
					for each(var i:String in cloneable)
					{
						t[i] = this[i];
						trace(i + ": " + t[i]);
					}
					
				}else{
					trace("cloned everything");
					t = this;
					
				}
				
				t.addChild(t.ObjAsset);
				
				
				return t;
			
        }
		
		public function fadeToLife(){
			
			var s = (this.life/this.origLife) ;
			if(s < 1 && s > 0) this.alpha = s;
			if(s >= 1) this.alpha = 1;
		}
			
		public function addLayer(name:String, object:Obj=null){
			
			//layers.push(object);
			//this.addChild(object);			
		}
		
		public function addObjToLayer(object:Obj){
			//layers.push(object);
			//this.addChild(object);			
		}
		
	}
}