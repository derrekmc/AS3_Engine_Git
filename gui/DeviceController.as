package {
	
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
	
	public class DeviceController extends Obj{		
	
		var leftPressed:Boolean = false;
		var rightPressed:Boolean = false;
		var upPressed:Boolean = false;
		var downPressed:Boolean = false;
		var MouseDown:Boolean = false;
		
	
				
		public function ui(name:String="ui", filename:String="", offSetX:Number=0, offSetY:Number=0){
			// constructor code
			super("start_screen", filename, "ui", 0, 0 , "NONE");
					startWatchingDevices();
		}
		
		public function startWatchingDevices(){
			trace("startWatchingDevices");
			Display.pDO.stage.addEventListener(MouseEvent.MOUSE_MOVE, _mouseMove);
			Display.pDO.stage.addEventListener(MouseEvent.MOUSE_DOWN, _mouseDown);
			Display.pDO.stage.addEventListener(MouseEvent.MOUSE_UP, _mouseUp);
						
			Display.pDO.stage.addEventListener(KeyboardEvent.KEY_DOWN, _keyDownHandler);
			Display.pDO.stage.addEventListener(KeyboardEvent.KEY_UP, _keyUpHandler);
		}
		
		override public function init(){
			trace("construct startScreen");
			
		}
		
				
		function _mouseMove(event:MouseEvent){
			mouseMove();
		}
		
		function _mouseDown(event:MouseEvent){
			MouseDown = true;			
			mouseDown();
		}
		
		function _mouseUp(event:MouseEvent){			
			MouseDown = false;			
			mouseUp();
		}
		
		function _keyDownHandler(e:KeyboardEvent):void{
			
			if(e.keyCode == Keyboard.LEFT || e.keyCode == 65){
				leftPressed = true;
			
			} else if(e.keyCode == Keyboard.RIGHT || e.keyCode == 68){
				rightPressed = true;
			
			} else if(e.keyCode == Keyboard.UP || e.keyCode == 87 || e.keyCode == Keyboard.SPACE){
				upPressed = true;
			
			} else if(e.keyCode == Keyboard.DOWN || e.keyCode == 83){
				downPressed = true;
			}	
			
			keyDownHandler();
		}
		
		function _keyUpHandler(e:KeyboardEvent):void{
			
			if(e.keyCode == Keyboard.LEFT || e.keyCode == 65){
				leftPressed = false;
			
			} else if(e.keyCode == Keyboard.RIGHT || e.keyCode == 68){
				rightPressed = false;
			
			} else if(e.keyCode == Keyboard.UP || e.keyCode == 87 || e.keyCode == Keyboard.SPACE){
				upPressed = false;
			
			} else if(e.keyCode == Keyboard.DOWN || e.keyCode == 83){
				downPressed = false;
			}	
			
			keyUpHandler();
		}
		
		public function mouseMove(){
			
		}
		
		public function mouseDown(){
			trace("construct kill");
			this.stopWatchingDevices();
			this.kill();
		}
		
		public function mouseUp(){			
			
		}
		
		public function keyDownHandler(){
			
		}
		
		public function keyUpHandler(){
			
		}
		
		public function stopWatchingDevices(){
			trace("stopWatchingDevices");
			Display.pDO.stage.removeEventListener(MouseEvent.MOUSE_MOVE, _mouseMove);
			Display.pDO.stage.removeEventListener(MouseEvent.MOUSE_DOWN, _mouseDown);
			Display.pDO.stage.removeEventListener(MouseEvent.MOUSE_UP, _mouseUp);
							
			Display.pDO.stage.removeEventListener(KeyboardEvent.KEY_DOWN, _keyDownHandler);
			Display.pDO.stage.removeEventListener(KeyboardEvent.KEY_UP, _keyUpHandler);		
			
		}
				
	}
	
}
