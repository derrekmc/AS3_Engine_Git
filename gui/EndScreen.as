package gui {
	
	import gui.ui;
	
	public class ReplayScreen extends ui{		
				
		public function EndScreen(offSetX:Number=0, offSetY:Number=0){
			// constructor code
			super("start_screen", "", 0, 0);
			this.x = offSetX;
			this.y = offSetY;
					
		}
		
		override public function init(){
			trace("construct startScreen");
		}
		
		override public function mouseDown(){
			trace("construct kill");
			this.die(2);
		}
				
	}
	
}
