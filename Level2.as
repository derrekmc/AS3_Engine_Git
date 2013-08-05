package {
		
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.display.BlendMode;
	import Obj;
	import Display;
	import Debug;
	import Global;
	import Particle;
	import LoadGame;
	import KeyHandler;
	import camera;
	import World;
	import Flame;
	import ParticleSeeder
	
	public class Level2 extends MovieClip {
		
		var key:KeyHandler;
		var cam:camera;
		var player:Player;
		var path:String;
		
		function Level2(){
			//Global.init();
			
			Display.init(this);
			Debug.init();
			cam = new camera("cam");
			cam.init();
			var world:World = new World();
			//this.addChild(world);
			
			Display.addWorld(world);
			Display.addCamera(cam);
			key = new KeyHandler();
			
			Debug.print("Hello", 2);		
			

			var imageFiles:Array = new Array();
			
			
			this.path = "pak/";
			
			
			
			world.startup();
			
			//var particles:ParticleSystem = new ParticleSystem("clouds", 0, -200, 10, false);
			var particles:ParticleSystem = new ParticleSystem("WorldLargeFog", 0, 60, 10, false);
			
			var particles2:ParticleSystem = new ParticleSystem("stage_clouds", 0, -0, 30, true);
			
			/*world.addBackgroundObj("house", path + "house.swf", 1800, -140);
			
			world.addBackgroundObj("tree1", path + "tree.png", 1600, -20);
			world.addBackgroundObj("tree2", path + "tree.png", 2400, -20);
			world.addBackgroundObj("tree3", path + "tree_small.png", 1500, 40);
			*/
			player = world.addPlayer("p1", path + "player.swf", 1800, -300, -20);
			//world.add(particles2, true, 0, 0);
			
			//world.addFloor(path + "hover_floor.png", 2200, 100);
			//world.addFloor(path + "bridge2.png", 2220, 180);
			world.addObject("health", path + "heart.png", 1900, -300);
			
			//world.addWater("water", path + "water.swf", 2290, 235, 10);
			//world.addFloor(path + "floor.png", 0, -260);
			//world.addFloor(path + "rocks.png", -40, 30);
			//world.addFloor(path + "rockend.png", 2600, 30);
			var loc = 0;
			for(var i=0 ; i< 10; i++){
				loc += 1345;
				world.addFloor(path + "hover_floor.png", loc, 0);
			}
			//world.addFloor(path + "hover_floor.png", 600, -200);
			//world.addFloor(path + "hover_floor.png", 2550, 210);
			
			var obj:Obj = new Obj();
			
			//world.add(new Obj("bridge", path + "bridge2.png", "floor"), true, 2220, 180);
			
			
			//var seed = new ParticleSeeder(2300, 0, 100)
			//var flame:Particle = new Particle("cloud", "bridge2.png", seed);
			//Display.addchild(flame);
			//world.add(seed, false, 2220, 0);
			//world.add(flame, false, 2220, 180);
			//world.add(new Obj("blue_flame", "particle"), path + "blue_flame_glow.png", 600, -200);
			
			//world.addFloor(path + "hover_floor.png", 3500, 100);
						
			//cam.addBackground(path + "bg.jpg", 0, 0);
			//cam.addBackground(path + "stars.png", 0, 0, 10);
			
			cam.addBackground(path + "moon.png", 200, -200);
			
			
			addEventListener(Event.ENTER_FRAME, updateScene);
		}
		
		function updateScene(e:Event){
			cam.attachTo(player);
		}
		
		
		
	}
	
}
