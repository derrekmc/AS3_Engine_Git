package gui {
	
	import gui.ui;
	import Display;
	import gui.InstructionsScreen;
	
	public class TitleScreen extends ui{		
				
		public function TitleScreen(offSetX:Number=0, offSetY:Number=0){
			// constructor code
			super("title_screen", "title_screen.png", 0, 0);
								
		}
		
		override public function init(){
			
		}
		
		override public function closed(){
			trace("construct kill");			
			var nextScreen:StartScreen = new StartScreen();
			Display.cam.addForeground(nextScreen);
			
			this.kill();
		}
				
	}
	
}
