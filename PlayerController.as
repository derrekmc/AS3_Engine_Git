package {
	
	import InputController;
	import flash.ui.Keyboard;
	import flash.events.KeyboardEvent;
	
	public class PlayerController extends InputController{		

				
		public function PlayerController(){		
			super();
		}
		
		override public function _keyDownHandler(e:KeyboardEvent):void{
			//trace("keydown" + e.keyCode);
			if(e.keyCode == Keyboard.CONTROL){
				Global.MouseDown = true;				
			}
			if(e.keyCode == Keyboard.LEFT || e.keyCode == 65){
				leftPressed = true;
			
			} else if(e.keyCode == Keyboard.RIGHT || e.keyCode == 68){
				rightPressed = true;
			
			} else if(e.keyCode == Keyboard.UP || e.keyCode == 87 || e.keyCode == Keyboard.SPACE){
				upPressed = true;
			
			} else if(e.keyCode == Keyboard.DOWN || e.keyCode == 83){
				downPressed = true;
			}	
		}
		
		override public function _keyUpHandler(e:KeyboardEvent):void{
			if(e.keyCode == Keyboard.CONTROL){
				Global.MouseDown = false;				
			}
			if(e.keyCode == Keyboard.LEFT || e.keyCode == 65){
				leftPressed = false;
			
			} else if(e.keyCode == Keyboard.RIGHT || e.keyCode == 68){
				rightPressed = false;
			
			} else if(e.keyCode == Keyboard.UP || e.keyCode == 87 || e.keyCode == Keyboard.SPACE){
				upPressed = false;
			
			} else if(e.keyCode == Keyboard.DOWN || e.keyCode == 83){
				downPressed = false;
			}	
		}
						
		/*function mouseDown(event:MouseEvent){
			Global.MouseDown = true;			
		}
		
		function mouseUp(event:MouseEvent){			
			Global.MouseDown = false;			
		}*/
					
	}
	
}
