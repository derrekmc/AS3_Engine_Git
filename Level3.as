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
	import SpawnEnemies;
	import objects.Health;
	
	public class Level3 extends MovieClip {
		
		var key:KeyHandler;
		var cam:camera;
		var player:Player;
		var path:String;
		
		function Level3(){
			//Global.init();
			
			Display.init(this);
			Debug.init();
			cam = new camera("cam");
			cam.init();
			var world:World = new World();
			//this.addChild(world);
			
			Display.addWorld(world);
			Display.addCamera(cam);
			Display.addBackground();
			key = new KeyHandler();
			
			Debug.print("Hello", 2);		
			

			var imageFiles:Array = new Array();
			
			
			this.path = "pak/";
			
			
			
			world.startup();
			
			//var particles:ParticleSystem = new ParticleSystem("clouds", 0, -200, 10, false);
			//var particles:ParticleSystem = new ParticleSystem("WorldLargeFog", 0, 60, 10, false);
			var particles:ParticleSystem = new ParticleSystem("stage_clouds", 0, -380, 10, true);
			var particles2:ParticleSystem = new ParticleSystem("stage_clouds", 0, 40, 10, true);
			/*world.addBackgroundObj("house", path + "house.swf", 1800, -140);
			
			world.addBackgroundObj("tree1", path + "tree.png", 1600, -20);
			world.addBackgroundObj("tree2", path + "tree.png", 2400, -20);
			world.addBackgroundObj("tree3", path + "tree_small.png", 1500, 40);
			*/
			var housePos = 1300;
			var smoke:ParticleSystem = new ParticleSystem("smoke", housePos + 240, -320, 20, true);
			
			world.addBackgroundObj("house", path + "house.swf", housePos, -340);
			
			player = world.addPlayer("p1", path + "player.swf", 650, -200, -20);
			Display.addPlayer(player);
			world.add(new Weapon("flame_gun", path + "flame_gun.swf", -40, -10), 1800, -100);
			//world.add(particles2, true, 0, 0);
			
			//world.addFloor(path + "hover_floor.png", 2200, 100);
			//world.addFloor(path + "bridge2.png", 2220, 180);
			//world.add(new Health(path + "heart.swf"), 1300, -100);
			
			
			//world.addFloor(path + "enemy_spawn_point.png", 4200, -180);
			
			
			//world.addWater("water", path + "water.swf", 2290, 235, 10);
			//world.addFloor(path + "floor.png", 0, -260);
			//world.addFloor(path + "rocks.png", -40, 30);
			//world.addFloor(path + "rockend.png", 2600, 30);
			
			var loc = 0;
			
			for(var i=0 ; i< 10; i++){
				loc += 700;
				//world.addFloor(path + "hover_floor.png", loc, 200);
				//world.addFloor(path + "grass.png", loc, 0);
			}
			world.addFloor(path + "rocks.png", 0, -165);
			
			loc = -300;
			var grassArray:Array = new Array();
			//grassArray.push({filename:"grass_whole.png", width:293, height:126});
			grassArray.push({filename:"grass.png", width:155, height:125});
			//grassArray.push({filename:"mushrooms.png", width:155, height:126});
			grassArray.push({filename:"grass2.png", width:155, height:137});
			for(i=0 ; i< 80; i++){
				
				//world.addFloor(path + "hover_floor.png", loc, 0);
				var grass = Math.round(Global.randRange(0, grassArray.length-1));
				
				trace(grassArray[grass].width);
				world.addFloor(path + grassArray[grass].filename, loc, 10);
				loc += grassArray[grass].width;
				
			}
			
			world.addBackgroundObj("sign", path + "sign.png", 450, -60);
			
			loc = 0;
			grassArray = new Array();
			grassArray.push({filename:"mushrooms.png", width:155, height:126});
						
			for(i=0 ; i< 3; i++){
				loc += 1000;
				//world.addFloor(path + "hover_floor.png", loc, 0);
				grass = Math.round(Global.randRange(0, 0));
				
				trace(grassArray[grass].width);
				world.addBackgroundObj("mushrooms", path + grassArray[grass].filename, loc, -20);
				loc += grassArray[grass].width;
				
			}
			
			loc = 0;
			
			for(i=0 ; i< 10; i++){
				loc += 825;				
				world.addBackgroundObj("tree2", path + "tree.png", Global.randRange(loc, loc+200), -220, false);
				world.addBackgroundObj("tree3", path + "tree_small.png", Global.randRange(loc, loc+600), -180, false);
			}
			
			for(i=0 ; i< 10; i++){
				loc += 855;
				//world.addFloor(path + "hover_floor.png", loc, -100);
			}			
			
			//world.addBackgroundObj("tree1", path + "tree.png", 1600, -20);
			//world.addBackgroundObj("tree2", path + "tree.png", 2400, -20);
			//world.addBackgroundObj("tree3", path + "tree_small.png", 1500, 40);
			
			world.addFloor(path + "hover_floor.png", 1600, -400);
			world.addFloor(path + "hover_floor.png", 2550, -410);
			world.addFloor(path + "rockend.png", 4460, -190);
			var obj:Obj = new Obj();
			
			//world.addWater("water", path + "water.swf", 2290, 0, 10);
			//world.add(new Obj("bridge", path + "bridge2.png", "floor"), 2220, -50);			
			
			
			
			
			//world.add(new Obj("bridge", path + "bridge2.png", "floor"), true, 2220, 180);
			
			
			//var seed = new ParticleSeeder(2300, 0, 100)
			//var flame:Particle = new Particle("cloud", "bridge2.png", seed);
			//Display.addchild(flame);
			//world.add(seed, false, 2220, 0);
			//world.add(flame, false, 2220, 180);
			//world.add(new Obj("blue_flame", "particle"), path + "blue_flame_glow.png", 600, -200);
			
			//world.addFloor(path + "hover_floor.png", 3500, 100);
						
			//cam.addBackground(path + "bg.jpg", 0, 0);
			
			
			var spawnEnemy:SpawnEnemies = new SpawnEnemies(new Point(4140, -100), 8, 20, 4000);
			
			//world.add(new Enemy("zombie", path + "enemy.swf"), 4120, -380);
			//world.add(new Enemy("zombie", path + "enemy.swf"), 4820, -380);
			//world.add(new Enemy("zombie", path + "enemy.swf"), 4620, -380);
			//world.add(new Enemy("zombie", path + "enemy.swf"), 4920, -380);
			
			
			cam.addBackground(path + "stars.png", 0, -50, .03, BlendMode.ADD);
			cam.addBackground(path + "moon.png", 600, -200, .05, BlendMode.ADD);
			cam.attachTo(player);
			
			
			
			addEventListener(Event.ENTER_FRAME, updateScene);
			
		}
		
		function updateScene(e:Event){
			//cam.attachTo(player);
		}
		
		function createSpawnPoint(point:Point, amount:Number){
			
		}
		
		function spawnEnemy(){
			
		}
		
		function generateFloor(){
			for(var i = 0; i< 20 ;i++){
				world.add(new Obj("bridge", path + "bridge2.png", "floor"), x, y);			
			}
		}
		
		
		
	}
	
}
