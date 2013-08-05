package gui {
	
	import Obj;
	import fl.transitions.Tween;
	import fl.transitions.easing.*;
	import flash.ui.Keyboard;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.ui.Mouse;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	//import flash.utils.Timer;
	import InputController;
	import gui.ui;
	import HealthBar;
	import GameScore;
	import FPSTimer;
	import Display;
	
	import Objs.TextObject;
	
	public class Hud extends ui{		
		
		//var controller:InputController;
		public var healthBar:HealthBar;
		public var score:TextObject;
		public var finaleScoreText:TextObject;
		
		public var credits:TextObject;
		public var gameStatus:TextObject;
		public var fps:TextObject;
		
		public var text1:TextObject;
		public var text2:TextObject;
		//public var credits:TextObject;
		
		public function Hud(filename:String="invisible.png", offSetX:Number=0, offSetY:Number=0){
			// constructor code
			super("hud", filename, 0, 0, false);			
			stopWatching();
		}
		
		override public function init(){
			healthBar = new HealthBar(100, 20, 560, 400, 30);
			this.addChild(healthBar);
			
			credits = new TextObject("Created by Derrek Cordova", "credits", 20, 0, 0);
			this.addChild(credits);
			
			score = new TextObject("SCORE: ", "score", 40, 0, 0);
			this.addChild(score);
			
			text1 = new TextObject("Slayed: 0 of 40", "", 40, 0, 0);
			this.addChild(text1);
			
			gameStatus = new TextObject("", "game_status", 200, 280, 160);
			
			this.addChild(gameStatus);
			
			
			var timer = new FPSTimer();
			fps = new TextObject("FPS: " + FPSTimer.fps, "fps", 20, 1120, 0);
			//moveTo
			this.addChild(fps);
			
			//text1 = new TextObject("Per Pixle: ", "text1", 20, 1120, 20);
			//this.addChild(text1);
			
			//text2 = new TextObject("text2: ", "text2", 20, 1120, 40);
			//this.addChild(text2);
			
			
			finaleScoreText = new TextObject("Your Score: " + GameScore.getFinalScore(), "finale_score", 80, 280, 360);
			finaleScoreText.visible = false;
			this.addChild(finaleScoreText);
			
			
			//Display.cam.addText("HEALTH", "health_text", 21,  26, 555);
		}
		override public function onAppear(){
						
		}
		override public function update(){
			
			healthBar.y = Display.cam.height - 50;
			
			score.x = Display.cam.width - 280
			score.y = Display.cam.height - 80;
			
			text1.x = Display.cam.width /2 - 120;
			text1.y = 20;
			
			credits.x = Display.cam.width - 280
			credits.y = Display.cam.height - 40;
			
			fps.text = "FPS: " + FPSTimer.fps;
			score.text = "SCORE: " + GameScore.score;
			text1.text = " Slayed: " + GameScore.enemiesKilled + " of 40";
			//death overlay
			if(Display.player != null){
				if(Display.player.isAlive()){
					var obj2 = this.getObjByName("death");
					var thugLife:Number = 1 - (Display.player.life/100);
					if(obj2.alpha != thugLife){
						obj2.alpha = thugLife;
						healthBar.updateHealth(Display.player.life);
						
					}
				}
			}
		}
		
				
		override public function closed(){
			
		}
			
		
	}
	
}
