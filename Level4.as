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
	import particles.Particle;
	import LoadGame;
	import KeyHandler;
	import camera;
	import World;
	
	import ParticleSeeder
	import SpawnEnemies;
	import Objs.Health;
	import Objs.Floor;
	import Objs.House;
	import EventWatcher;
	import gui.StartScreen;
	import flash.filters.BlurFilter;
	import flash.filters.BitmapFilterQuality;
	import Objs.TextObject;
	import weapons.FlameGun;
	import weapons.PlasmaRifle;
	import Weapon;
	import vehicles.JetPak;
	import PlaySound;
	import flash.utils.Timer;
	import flash.events.TimerEvent;
	import gui.Hud;
	import GameScore;
	import PlayerController;
	import gui.TitleScreen;
	
	public class Level4 extends MovieClip {
		public var controller:PlayerController;
		var key:KeyHandler;
		var cam:camera;
		var player:Player;
		var path:String;
		public var hudScreen:Hud;
		var winLoseText;
		
		function Level4(){
			//Global.init();
			Global.Path = "pak/";
			Display.init(this);
			Debug.init();
			cam = new camera("camera");
			cam.init();
			var world:World = new World();
			//this.addChild(world);
			var gameScore = new GameScore();
			Display.addWorld(world);
			Display.addCamera(cam);
			Display.addBackground();
			controller = new PlayerController();
			key = new KeyHandler();
			
			Debug.print("Hello", 2);		
			

			var imageFiles:Array = new Array();
			
			
			this.path = "";
			
			world.startup();
			
			
								
			var floor1 = -800;
			var floor2 = -600;
									
			//var e:Emitter = new Emitter("particle emitter", path + "fire.png", 1, 60, 0, false, "POINT");
			//e.emit();
			var startScreen:TitleScreen = new TitleScreen();
			Display.cam.addForeground(startScreen);
			
			
			
			
			
			world.addForegroundObj("sign", path + "sign.png", 260, floor1 -65);
			world.addFloor(path + "hover_floor.png", -300, floor1);
			
			world.addForegroundObj("sign", path + "sign.png", 1090, floor2-80, 0, 0, -1);
			world.addFloor(path + "hover_floor.png", 800, floor2);
			world.addFloor(path + "hover_floor_small.png", 5300, -350);
			
			world.addFloor(path + "hover_floor_small.png", 5800, -750);
			world.addFloor(path + "hover_floor_small.png", 6300, -350);
			world.addForegroundObj("mushrooms", path + "mushrooms.png", 1200, floor2-40);
			
			
			cam.addBackground(path + "stars2.png", 0, -70, .025, BlendMode.ADD);
			cam.addBackground(path + "stars.png", 0, -50, .015, BlendMode.ADD);
			cam.addBackground(path + "moon.png", 600, -200, .035, BlendMode.ADD);
			
			
			//world.add(new Health(path + "heart.swf"), 1090, floor2-100);
			
			world.addForegroundObj("sign", path + "sign.png", 520, -60, 0, 0 );
			world.addForegroundObj("sign", path + "sign.png", 810, -60, 0, 0 );
			//world.addBackgroundObj("sign", path + "sign.png", 1300, -80, 0, 0 );
			
			
			
			var loc = 0;
			
			for(var i=0 ; i< 8; i++){
				loc += 4450;
				//world.addFloor(path + "hover_floor.png", , 200);
				//world.addFloor(path + "grass.png", loc, 0);
				world.addForegroundObj("sign", path + "sign.png", loc, -60);
				world.add(new Health(path + "heart.swf"), loc - 100, -100);
				
			}
			
			//world.add(new Obj("enemy_spawn_point", path + "enemy_spawn_point.png"), 680, -165);
			world.addFloor(path + "rocks.png", 0, -165);
			world.addFloor(path + "rockend.png", 10460, -165);
			
			//world.add(new Obj("house", path + "house.swf", "object"), housePos, -340);
			
			
			
			loc = -400;
			var grassArray:Array = new Array();
			//grassArray.push({filename:"grass_whole.png", width:293, height:126});
			grassArray.push({filename:"grass.png", width:155, height:125});
			//grassArray.push({filename:"mushrooms.png", width:155, height:126});
			grassArray.push({filename:"grass2.png", width:155, height:125});
			
			for(i=0 ; i< 75; i++){
				var grass = Math.round(Global.randRange(0, grassArray.length-1));
				world.addFloor(path + grassArray[grass].filename, loc, 10);
				loc += grassArray[grass].width;
				
			}
			var bridge = 30;
			
			//world.add(new Obj("water", path + "water.swf", "floor"), 7290, bridge , true);
			//world.add(new Obj("bridge", path + "bridge2.png", "floor"),7220, bridge - 30, true);			
						
			//world.addFloor(path + grassArray[grass].filename, loc+600, 10);
			
			loc = 400;
			grassArray = new Array();
			grassArray.push({filename:"mushrooms.png", width:155, height:126});
						
			for(i=0 ; i< 5; i++){
				loc += 1000;
				//world.addFloor(path + "hover_floor.png", loc, 0);
				grass = Math.round(Global.randRange(0, 0));
				
				//trace(grassArray[grass].width);
				world.addForegroundObj("mushrooms", path + grassArray[grass].filename, loc, -20);
				loc += grassArray[grass].width;
				
			}
			
			loc = 800;
			
			for(i=0 ; i< 10; i++){
				loc += 925;				
				world.addForegroundObj("tree1", path + "forgroundtree.png", Global.randRange(loc-500, loc-300), -245, false);
				world.addBackgroundObj("tree2", path + "tree.png", Global.randRange(loc, loc+200), -205, false);
				world.addBackgroundObj("tree3", path + "tree_small.png", Global.randRange(loc, loc+600), -155, false);
			}
			
			for(i=0 ; i< 10; i++){
				loc += 855;
				//world.addFloor(path + "hover_floor.png", loc, -100);
			}			
			
			//world.addFloor(path + "hover_floor.png", 1600, -400);
			//world.addFloor(path + "hover_floor.png", 2550, -410);
			
			//var obj:Obj = new Obj();
			
			//var spawnEnemy:SpawnEnemies = new SpawnEnemies(new Point(440, -150), 12, 40, 2000);
			

			
			//var particles3:ParticleSystem = new ParticleSystem("stage_clouds", 0, 20, 4, true);
			//particles3.name = "particles";
			
			var particles4:ParticleSystem = new ParticleSystem("screen_clouds", 0, 20, 8, true);
			
			
			//var particles1:ParticleSystem = new ParticleSystem("stage_clouds", 0, -380, 5, true);
			//particles1.name = "particles2";
			
			//var particles2:ParticleSystem = new ParticleSystem("stage_clouds", 0, 40, 5, true);
			
			var housePos = 8200;
			
			//var fire:ParticleSystem = new ParticleSystem("star_glow", 2000, -200, 20, true);
			
			world.addFloor(path + "hover_floor.png", housePos/2, -400);
			//world.add(new Health(path + "heart.swf"), housePos/2 + 300, -500);
			
			world.addForegroundObj("sign_second", path + "secondweapon.png", housePos + 400, -468);
			world.addFloor(path + "hover_floor.png", housePos + 400, -400);
			//world.add(new Health(path + "heart.swf"), housePos + 600, -500);
			world.add(new Health(path + "heart.swf"), housePos + 700, -500);
			world.add(new Health(path + "heart.swf"), housePos + 800, -500);
			world.add(new Health(path + "heart.swf"), housePos + 900, -500);
			//world.addBackgroundObj("house", path + "house.swf", housePos, -340);
			/*var house = new House(path + "house.swf");
			
			world.addChild(house);
			
			house.x =  housePos;
			house.y = -325;
			house.addToCollisionList();*/
			
			world.add(new House(path + "house.swf"), housePos, -325);
			player = world.addPlayer("p1", path + "player.swf", -100, floor1-350, -20);
			Display.addPlayer(player);
			//world.add(new JetPak(), 4600, floor1 - 200);
			world.add(new JetPak(), 6050, -1000 );
			world.add(new FlameGun("flame_gun", -40, -15), 5500,  floor2-100 );
			
			//world.add(new Vehicle("vehicle", "torch.png"), 96, floor1 - 200);
			//world.add(new PlasmaRifle("plasma_rifle"), 8740, floor1 - 400);
			
			//world.addFloor(path + "hover_floor.png", 7000, floor1 );
			//world.addFloor(path + "hover_floor.png", 8000, floor2 );
			
			world.add(new PlasmaRifle("plasma_rifle"), 6500, floor2-150);
			world.addFloor(path + "hover_floor.png", 7000, floor2 );
			
			hudScreen = new Hud();
			Display.addHud(hudScreen);
			
			var e:EventWatcher = new EventWatcher(Obj.enemies[0], "dying", true, this.LevelComplete);
			var e1:EventWatcher = new EventWatcher(player, "dying", true, this.LevelUnsuccessful);
			
			//var e1:EventWatcher = new EventWatcher(startScreen, "dying", true, this.LevelUnsuccessful);
			//addEventListener(Event.ENTER_FRAME, updateScene);
			
			var levelStart:Timer = new Timer(4000, 1);
			levelStart.start()
			levelStart.addEventListener(TimerEvent.TIMER_COMPLETE, startLevel);
			var s:PlaySound = new PlaySound("darkknightrises.mp3");
			s.play(60, Global.SOUND_LVL_MUSIC_BKG);
		}
		
		function startLevel($evt:TimerEvent){
			cam.addForeground(new Obj("death", path + "death.jpg", "background", 0, 0, "NONE", true), 0, 0, BlendMode.OVERLAY, 0, new BlurFilter(8,8,BitmapFilterQuality.HIGH));
			//startScreen.attach(cam);
			hudScreen.watch();
			Display.cam.addForeground(hudScreen);
			
			
			
			var d:PlaySound = new PlaySound("SpookyAmbience.mp3");
			d.play(220, Global.SOUND_LVL_AMBIENCE_BKG);
			
		}
		
		function LevelComplete(){
			//winLoseText = new TextObject("You Win", "game_text", 200, 240, 200); //addForeground( , x, y); //cam.addText("You Win", "winning", 200, 240, 200);
			//winLoseText.alpha = 0;
			//cam.addForeground(winLoseText);
			//trace("Portal Has Been Opened");
			Display.hud.gameStatus.visible = true;
			if(GameScore.score > 0) Display.hud.gameStatus.text = "Exellent!";
			if(GameScore.score > 5000) Display.hud.gameStatus.text = "You Win";
			if(GameScore.score > 10000) Display.hud.gameStatus.text = "Thats Ok";
			if(GameScore.score > 20000) Display.hud.gameStatus.text = "Awesome!";
			if(GameScore.score > 35000) Display.hud.gameStatus.text = "Great!!";
			if(GameScore.score > 50000) Display.hud.gameStatus.text = "Perfect";
			var xpos = Display.hud.gameStatus.text.length / 2;
			trace("sxpos",xpos);
			Display.hud.gameStatus.x += xpos;
			Display.hud.finaleScoreText.visible = true;
			Display.hud.finaleScoreText.text = "Your Score: " + GameScore.score;
		}
		
		function LevelUnsuccessful(){
			//trace("Portal Has Been Closed");
			Display.hud.gameStatus.visible = true;
			Display.hud.gameStatus.text = "You Lose";
			Display.hud.gameStatus.x-=50;
			//cam.attachTo(player);
		}
		
		
		function createSpawnPoint(point:Point, amount:Number){
			
		}
		
		function spawnEnemy(){
			
		}
		
		function generateFloor(){
			for(var i = 0; i< 20 ;i++){
				//world.add(new Obj("bridge", path + "bridge2.png", "floor"), x, y);			
			}
		}
		
		
		
	}
	
}
