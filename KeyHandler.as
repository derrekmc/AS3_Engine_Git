package{
	
	import Debug;
	import camera;
	import flash.ui.Keyboard;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.display.Sprite;
	import Display;
	import World;
	public class KeyHandler extends Sprite{
		private var cam:camera;
		
		private var speed:Number = 10;
		
		function KeyHandler(){
			
			
			//Debug.print("Key Handler On", 1);
		}
		
		public function init(){
			//addEventListener(Event.ENTER_FRAME, checkKeys);
			Display.addchild(this);
			cam = camera.getCamera("cam");
			stage.addEventListener(KeyboardEvent.KEY_DOWN, keyPressed);
			stage.addEventListener(KeyboardEvent.KEY_UP, keyReleased);
		}
		
		function keyboardEvent(event:KeyboardEvent){
			
			switch (event.keyCode) 
			{
				case 13:// enter
					//if(sendText.text != ''){
						stage.dispatchEvent(new sendEvent("keyPressed", event.keyCode));
						//sendText.text = "";
					//}
				break;
			}			
			//debug.print("keyCode: " + event.charCode, 5);
		}
		public function keyReleased(e:KeyboardEvent){		
			
			/*
			if(e.keyCode == Keyboard.LEFT)	Global.KeyboardLeft 	= false;
			if(e.keyCode == Keyboard.RIGHT) Global.KeyboardRight 	= false;			
			if(e.keyCode == Keyboard.UP) 	Global.KeyboardUp 		= false;						
			if(e.keyCode == Keyboard.DOWN)	Global.KeyboardDown 	= false;
			*/
			
			if(e.keyCode == Keyboard.LEFT)	{
				Global.KeyboardLeft = false;
				
			}
			if(e.keyCode == Keyboard.RIGHT) {
				Global.KeyboardRight = false;
				
			}
			if (e.keyCode == Keyboard.UP) {
				Global.KeyboardUp = false;
				 
			}
			
			if (e.keyCode == Keyboard.DOWN) {
				 Global.KeyboardDown = false;
			}
			
			if (e.keyCode == Keyboard.HOME) {
				
			}
			
			if (e.keyCode == Keyboard.END) {
				
			}
		}
		
		
		public function keyPressed(e:KeyboardEvent){	
		
			/*
			if(e.keyCode == Keyboard.LEFT)	Global.KeyboardLeft 	= true;
			if(e.keyCode == Keyboard.RIGHT) Global.KeyboardRight 	= true;			
			if(e.keyCode == Keyboard.UP) 	Global.KeyboardUp 		= true;						
			if(e.keyCode == Keyboard.DOWN)	Global.KeyboardDown 	= true;
			*/
						
			if(e.keyCode == Keyboard.LEFT)	{
				Global.KeyboardLeft = true;
				
			}
			if(e.keyCode == Keyboard.RIGHT) {
				Global.KeyboardRight = true;
				
			}
			if (e.keyCode == Keyboard.UP) {
				Global.KeyboardUp = true;
				 
			}
			
			if (e.keyCode == Keyboard.DOWN) {
				 Global.KeyboardDown = true;
			}
			
			if (e.keyCode == Keyboard.HOME) {
				
			}
			
			if (e.keyCode == Keyboard.END) {
				
			}
			
		}
	}

}

import flash.events.EventDispatcher;
import flash.events.Event;

class sendEvent extends Event{
	
	public var msg:String;
	public var username:String;
	public var color:String;
		
	public function sendEvent(type, info:*){
		
		super(type);
		
	}
}