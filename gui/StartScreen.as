package gui {
	
	import gui.ui;
	import Display;
	import gui.InstructionsScreen;
	
	public class StartScreen extends ui{		
				
		public function StartScreen(offSetX:Number=0, offSetY:Number=0){
			// constructor code
			super("start_screen", "start_screen.png", 0, 0);
			
					
		}
		
		override public function init(){
			trace("construct startScreen");
			var obj = this.getObjByName("plasma_rifle");
			trace(obj.type, obj.name, obj.x, obj.y);
			Display.cam.attachTo(obj);
		}
		
		override public function closed(){
			trace("construct kill");
			
			var screen:InstructionsScreen = new InstructionsScreen();
			Display.cam.addForeground(screen);
			
			this.kill();
		}
				
	}
	
}
