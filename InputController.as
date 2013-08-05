package {
	
	import fl.transitions.Tween;
	import fl.transitions.easing.*;
	
	import flash.geom.Point;
	
	import flash.events.Event;
	
	import flash.ui.Keyboard;
	import flash.events.KeyboardEvent;
	
	import flash.ui.Mouse;
	import flash.events.MouseEvent;
	
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	
	import Obj;
	
	import Display;
	import Debug;
	
	public class InputController{		
	
		public var leftPressed		:Boolean = false;
		public var rightPressed		:Boolean = false;
		public var upPressed		:Boolean = false;
		public var downPressed		:Boolean = false;
		public var MouseDown		:Boolean = false;
		public var MouseMove		:Boolean = false;
		public var MousePoint		:Point = new Point(0, 0);
		public var ShiftDown		:Boolean = false;
		public var controlDown		:Boolean = false;
		
		public var keyboardInUse	:Boolean = false;
		public var MouseInUse		:Boolean = false;
		public var inputMap			:Array = new Array();
				
		public function InputController(){
			startWatchingDevices();
		}
		
		public function mapKey(mapItem, keyCode){
			//inputMap.push(mapName: mapItem, key: keyCode)
		}
		
		public function startWatchingDevices(){
			//trace("startWatchingDevices");								
			
			startKeyboard();
			startMouse();
		}
		
		public function startKeyboard(){
			stopWatchingKeyboard();
			//trace("startKeyboard");		
			Debug.print("InputController::startKeyboard()", Debug.OBJECT_CREATE);
			Display.pDO.stage.addEventListener(KeyboardEvent.KEY_DOWN, _keyDownHandler);
			Display.pDO.stage.addEventListener(KeyboardEvent.KEY_UP, _keyUpHandler);
		}
			
		public function startMouse(){
			stopWatchingMouse();
			//trace("startMouse");			
			Debug.print("InputController::startMouse()", Debug.OBJECT_CREATE);
			if(MouseInUse == false){
				Display.pDO.stage.addEventListener(MouseEvent.MOUSE_MOVE, _mouseMove);
				Display.pDO.stage.addEventListener(MouseEvent.MOUSE_DOWN, _mouseDown);
				Display.pDO.stage.addEventListener(MouseEvent.MOUSE_UP, _mouseUp);
			}			
		}		
						
		public function _mouseMove(event:MouseEvent){
			MousePoint.x = event.target.mouseX;
			MousePoint.y = event.target.mouseY;
			mouseMove();
		}
		
		public function _mouseDown(event:MouseEvent){
			MouseDown = true;			
			mouseDown();
		}
		
		public function _mouseUp(event:MouseEvent){			
			MouseDown = false;			
			mouseUp();
		}
		
		public function _keyDownHandler(e:KeyboardEvent):void{
			
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
		
		public function _keyUpHandler(e:KeyboardEvent):void{
			
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
			
		}
		
		public function mouseUp(){			
			
		}
		
		public function keyDownHandler(){
			
		}
		
		public function keyUpHandler(){
			
		}
		
		public function stopWatchingKeyboard(){
			//trace("stopWatchingKeyboard");
			Debug.print("InputController::stopWatchingKeyboard()", Debug.OBJECT_DESTROY);
			Display.pDO.stage.removeEventListener(KeyboardEvent.KEY_DOWN, _keyDownHandler);
			Display.pDO.stage.removeEventListener(KeyboardEvent.KEY_UP, _keyUpHandler);		
			
		}
		
		public function stopWatchingMouse(){
			//trace("stopWatchingMouse");
			Debug.print("InputController::stopWatchingKeyboard()", Debug.OBJECT_DESTROY);
			Display.pDO.stage.removeEventListener(MouseEvent.MOUSE_MOVE, _mouseMove);
			Display.pDO.stage.removeEventListener(MouseEvent.MOUSE_DOWN, _mouseDown);
			Display.pDO.stage.removeEventListener(MouseEvent.MOUSE_UP, _mouseUp);
			
		}
		
		public function stopWatchingDevices(){
			//trace("stopWatchingDevices");
			stopWatchingKeyboard();
			stopWatchingMouse();
			
		}
					
	}
	
}
