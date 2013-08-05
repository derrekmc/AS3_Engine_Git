package{	

	import flash.display.MovieClip; 
	//import com.coreyoneil.collision.CollisionList;
	import Display;
	import ImageLoader;
	import flash.events.Event;
	import flash.display.BlendMode;
	
	import Obj;
	import Player;
	import Enemy;
	import Objs.Floor;
	
	class World extends Obj{	
		
		public static var wind		:Number		= 0.00;
		
		private var _speed			:Number;
		
		public const GRAVITY		:Number 	= .75;
		public const FRICTION		:Number 	= 1.5;
		public static const IMMOVABLE		:Number 	= 10000;
		
		public const ATMOSPHERE_H		:int 	= 4000; // Height of the world or the end of the top portion of the map
		
		private var Level		:*;				
		private static var backgrounds:MovieClip;		
		private static var foregrounds:MovieClip;		
		public var debug:Debug;
		
		public var player:Player;
		//public var enemies:Array;
		//public var floors:Array;
		//public var misc:Array;
		
		var windFactor;
		
		//public static var _collisionList	:CollisionList;
		
		public function World():void{
			//display.addChild(this);
			this.radius = 100;		
			mass 	= radius * 400;
			name = "world";
			type = "floor";
			super(name, "", type);
			
			
		}
			
		function startup(){
					
			//World.Level = 
			objects = new Array();
			Display.addchild(this);
			backgrounds = new MovieClip();
			foregrounds = new MovieClip();
			Display.addchild(backgrounds);
			Display.addchild(foregrounds);
			
			backgrounds.name = "backgrounds";
			foregrounds.name = "foregrounds";
		//	misc = new Array();
			//enemies = new Array();
			//floors = new Array();
			
			
			// Creating a bunch of balls and adding them to the collision list
			//blendMode = BlendMode.ADD;
			this.windFactor = Global.randRange(0.03, 0.17);
		}
		
		override public function update(){		
			var objectsOnScreen = 0;
			var floorsOnScreen=0;
			//trace("before: " + objectsOnScreen);
			for(var i:int = 0; i < objects.length; i++)
			{
				
					var floorCollisionFound=false;
					objectsOnScreen=0;
					floorsOnScreen=0;
					
					if(objects[i].type == 'structure') continue;
				
					for(var j:int = 0; j < floors.length; j++)
					{
						if(floors[j].isOnScreen()){
								//floors[i].y--;
								if(floors[j].visible != true) floors[j].visible = true;
								objects[i].checkCollisionWith(floors[j]);
								if(objects[i].downBumping == true){
									floorCollisionFound=true;
									
									break;
								}else{
									
								}
								floorsOnScreen++;
								objectsOnScreen++;
						}else{
							floors[j].visible = false;							
						}
					}
					
					if(floorCollisionFound == true){
						objects[i].grounded = true;
					}else if((objects[i].isOnScreen() || objects[i].type == "player") && floorCollisionFound == false ){
						objects[i].grounded = false;
					}
					
					if(objects[i].grounded == true){
						
					}else{
						if(objects[i].visible == true || objects[i].type == "player") objects[i].vy += GRAVITY ;		
					}
					//trace("objectsOnScreen.length" + objectsOnScreen);
					objects[i].vy += objects[i].yspeed;
					objects[i].vx += objects[i].xspeed;
					
					//objects[i].vx += this.windFactor;
					
					
					objects[i].vy *= objects[i].friction;				
					objects[i].vx *= objects[i].friction;
					objects[i].y += objects[i].vy;
					objects[i].x += objects[i].vx;		
					//trace(this.x, this.y);
					
					if(objects[i].isOnScreen()){
						objects[i].visible = true;
						objectsOnScreen++;
					}else{
						objects[i].visible = false;
						//objectsOnScreen--;
					}
					
					
					
					if(objects[i].y > Display.world.y + Display.world.height + 40 || Math.abs(objects[i].y) > this.ATMOSPHERE_H + 750){
						objects[i].kill();
					}
			}
			
			for(var k:int = 0; k < misc.length; k++){
				if(misc[k].isOnScreen()){
					misc[k].visible = true;
					objectsOnScreen++;
					
				}else{
					//trace(" misc.visible: false" +  misc[k].name);
					misc[k].visible = false;
						//objectsOnScreen--;
				}
			}
			
			//trace("after: " + enemies.length);
			
			
			//trace("after: " + objectsOnScreen);
			
		}
		
		override public function leftBound(object:Obj){
			if(object.vx < 0){
				object.vx *= -0.2;
			}
		}
		
		override public function rightBound(object:Obj){
			if(object.vx > 0){
				object.vx *= -0.2;
			}
		}
		
		override public function bottomBound(object:Obj){
			//if(object.vy > 0){
				bringToGround(object);
			//}
		}
		
		override public function topBound(object:Obj){			
			bringToGround(object);
		}
		
		public function add(object:Obj, startX=0, startY=0, inFrontOfFloor:Boolean=true){			
				
				//this.addChild(obj);
				object.x += startX;
				object.y += startY;
				Display.addchild(object);	
				if(inFrontOfFloor == true){
					
					if(Display.pDO.getChildByName(object.name)) Display.pDO.setChildIndex(Display.pDO.getChildByName(object.name), Display.pDO.getChildIndex(Display.pDO.getChildByName("world"))-1);
				}			
				
				object.addToCollisionList();
									
				return object;
			
		}
						
		public function addObject(name:String, filename:String, startX=0, startY=0, offSetX=0, offSetY=0){
			
			if(filename){
				Debug.print(filename, 1);
				//Display.pDO.addChild(this);
				var obj:Obj = new Obj();		
				obj.addChild(new ImageLoader( filename, offSetX, offSetY, 0, 0, true));		
				//this.addChild(obj);
				obj.x += startX;
				obj.y += startY;
				Display.addchild(obj);		
				//player._collisionList.addItem(obj);
				//_collisionList.addItem(obj);
				objects.push(obj);
				return obj;
			}
		}
		
		public function addWater(name:String, filename:String, startX=0, startY=0, offSetX=0, offSetY=0){
			
			if(filename){
				Debug.print(filename, 1);
				//Display.pDO.addChild(this);
				var obj:Obj = new Obj(name, filename, "water");		
				
				//obj.addChild(new ImageLoader( filename, offSetX, offSetY, 0, 0, true));		
				//this.addChild(obj);
				obj.x += startX;
				obj.y += startY;
				Display.addchild(obj);		
				
				//player._collisionList.addItem(obj);
				objects.push(obj);
				return obj;
			}
		}
		
		public function addPlayer(name, filename:String, startX=0, startY=0, offSetX=0, offSetY=0){
			
			if(filename){
				Debug.print(filename, 1);
				player = new Player(name, filename, offSetX, offSetY);				
				player.x += startX;
				player.y += startY;
				Display.addchild(player);
				
				return player;
			}
		}
		
		
		public function addEnemy(name, filename:String, startX=0, startY=0, offSetX=0, offSetY=0){
			
			/*if(filename){
				Debug.print(filename, 1);
				//this.addChild(this);
				enemies.push(new Enemy(name, filename, offSetX, offSetY));				
				var i = enemies.length-1;
				enemies[i].x += startX;
				enemies[i].y += startY;
				Display.addchild(enemies[i]);
				floor.addToCollisionList();
				return enemies[i];
			}*/
		}
		
		public function addFloor(filename:String, startX=0, startY=0, offSetX=0, offSetY=0){
			
			var floor:Floor = new Floor("floor", filename, offSetX, offSetY);
			this.addChild(floor);
			floor.x = startX;
			floor.y = startY;
			floor.addToCollisionList();
		}
		
		
		
		public function analyze(_obj):void {
			var item:Object;
			switch (typeof(_obj)){
				case "object":
					write("<object>");
					write(_obj.toString());
					for each (item in _obj){
						analyze(item);
					};
					write("</object>");
				break;
				case "xml":
					write("<xml>");
					write(_obj);
					write("</xml>");
				break;
				default:
					write(_obj + " (" + typeof(_obj) + ")");
				break;
			};
		} // analyze()
		
		public function write(_obj):void{
		trace(_obj);
		} 
		
		public function addScene(){
		
		}
		
		public function addBackgroundObj(name:String, filename:String, startX=0, startY=0, offSetX=0, offSetY=0, direction:Number=1){
			if(filename){
				Debug.print(filename, 1);
				var obj:Obj = new Obj(name, filename, "background", 0, 0, "NONE");		
				obj.direction = direction;
				//Display.drawObj(obj);
				backgrounds.addChild(obj);
				obj.x += startX;
				obj.y += startY;
				obj.addToCollisionList();
				return obj;
			}
		}
		
		public function addForegroundObj(name:String, filename:String, startX=0, startY=0, offSetX=0, offSetY=0, direction:Number=1){
			if(filename){
				Debug.print(filename, 1);
				//Display.pDO.addChild(this);
				var obj:Obj = new Obj(name, filename, "foreground", 0, 0, "NONE");		
				//Display.drawObj(obj);
				obj.direction = direction;
				//obj.addChild(new ImageLoader( filename, offSetX, offSetY, 0, 0, true));	
				foregrounds.addChild(obj);
				//this.addChild(obj);
				obj.x += startX;
				obj.y += startY;
				//Display.addchild(obj);		
				obj.addToCollisionList();
				//player._collisionList.addItem(obj);
				//objects.push(obj);
				return obj;
			}
		}
			
		
		
	}
}