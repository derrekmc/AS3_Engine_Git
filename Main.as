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
	import ParticleSeeder;
	import Weapons;
	import flash.ui.Mouse;
	
	public class Main extends MovieClip {
		
		var key:KeyHandler;
		var cam:camera;
		var player:Player;
		var path:String;
		
		function Main(){
			Global.init();
			
			Display.init(this);
			Debug.init();
			cam = new camera("cam");
			cam.init();
			var world:World = new World();
			//this.addChild(world);
			Display.addCamera(cam);
			Display.addWorld(world);
			
			key = new KeyHandler();
			
			Debug.print("Hello", 2);		
			Display.addBackground();

			var imageFiles:Array = new Array();
			
			
			this.path = "pak/";
			
			
			
			world.startup();
			//generateFloor();
			
			//var particles1:ParticleSystem = new ParticleSystem("blue_flame", 400, 200, 10, true);
			//var particles1:ParticleSystem = new ParticleSystem("smoke", 2040, -100, 10, true);
			//var particles1:ParticleSystem = new ParticleSystem("flame", 2200, 200, 10, true);
			//var particles:ParticleSystem = new ParticleSystem("WorldLargeFog", 0, 200, 10, false);
			//cam.addBackground(path + "stars.png", 0, 0, 10, BlendMode.SCREEN);
			world.addBackgroundObj("house", path + "house.swf", 1800, -140);
			
			world.addBackgroundObj("tree1", path + "tree.png", 1600, -20);
			world.addBackgroundObj("tree2", path + "tree.png", 2400, -20);
			world.addBackgroundObj("tree3", path + "tree_small.png", 1500, 40);
			
			player = world.addPlayer("p1", path + "player.swf", 100, -100, -20);
			Display.addWorld(world);
			Display.addPlayer(player);
			//world.addFloor(path + "bridge2.png", 2220, 180);
			//world.addObject("health", path + "heart.png", 800, -300);
			//world.addWater("water", path + "water.swf", 2290, 235, 10);
			//world.addFloor(path + "floor.png", 0, -260);
			//world.addFloor(path + "bridge2.png", 2220, 180);
			
			
			//world.addFloor(path + "hover_floor.png", 600, -200);
			//world.addFloor(path + "hover_floor.png", 2550, 210);
			
			var obj:Obj = new Obj();
			world.addWater("water", path + "water.swf", 2290, 235, 10);
			world.add(new Obj("bridge", path + "bridge2.png", "floor"),2220, 180);			
			world.addFloor(path + "rocks.png", -40, 30);
			world.addFloor(path + "rockend.png", 2600, 30);
			world.add(new Obj("health", path + "heart.png", "object"), 800, -380);
			world.add(new Enemy("zombie", path + "enemy.swf"), 2120, -380);
			world.add(new Enemy("zombie", path + "enemy.swf"), 2820, -380);
			world.add(new Enemy("zombie", path + "enemy.swf"), 2620, -380);
			world.add(new Enemy("zombie", path + "enemy.swf"), 2920, -380);
			
			//world.addEnemy("zombie", path + "enemy.swf", 1620, -380);
			//world.addEnemy("zombie", path + "enemy.swf", 1720, -380);
			//world.addEnemy("zombie", path + "enemy.swf", 1920, -380);
			
			//world.add(new Enemy("zombie", path + "enemy.swf"), true, 2120, -380);
			
			world.add(new Weapon("flame_gun", path + "flame_gun.png", -20, -10), 1800, 180);
			
			
			//world.add(new Obj("target", path + "target.png", "object"), false, Mouse.x, Mouse.y);
			//world.add(new Weapons("flame_fun", path + "plasma_gun.png"), true, 1800, -180);
			
			
			//var seed = new ParticleSeeder(2300, 0, 100)
			//var flame:Particle = new Particle("cloud", "bridge2.png", seed);
			//Display.addchild(flame);
			//world.add(seed, false, 2220, 0);
			//world.add(flame, false, 2220, 180);
			//world.add(new Obj("blue_flame", "particle"), path + "blue_flame_glow.png", 600, -200);
			
			world.addFloor(path + "hover_floor.png", 0, 100);
			
			var particles:ParticleSystem = new ParticleSystem("stage_clouds", 0, -220, 10, true);
			var particles2:ParticleSystem = new ParticleSystem("stage_clouds", 0, 220, 10, true);
			//world.add(particles, true, 2220, 0);
			//cam.addBackground(path + "bg.jpg", 0, 0);
			
			
			cam.addBackground(path + "moon.png", 300, -200);
			
			
			
			cam.attachTo(player);
			addEventListener(Event.ENTER_FRAME, updateScene);
		}
		
		
		
		function updateScene(e:Event){
			
			//cam.attachTo();
		}
		
		
		
	}
	
}
