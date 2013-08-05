package gui {
	
	import gui.ui;
	import Display;
	
	
	public class InstructionsScreen extends ui{		
				
		public function InstructionsScreen(offSetX:Number=0, offSetY:Number=0){
			// constructor code
			super("start_screen", "instructions.png", 0, 0);
			
					
		}
		
		override public function init(){
			trace("construct startScreen");
			Display.cam.attachTo(Display.player);
			Display.player.addToCollisionList();
			//Display.world.watch(); this should go here but if it does it will cause serious lag in anything attached to the player
		}
		
				
	}
	
}
