package Objs {
	
	import Obj;
		
	public class Wall extends Obj{
				
		public function Wall(name:String="wall", filename="", offSetX=0, offSetY=0) {
			this.friction = 0.99;			
			
			var array:Array = filename.split(".png");
			var newFilename = array[0] + "_map.png";
			trace(newFilename);
			
			collisionLayer = new Obj("collisionLayer", newFilename, "collisionLayer", offSetX, offSetY, "NONE");
			addChild(collisionLayer);
						
			super(name, filename, "wall", offSetX, offSetY, "NONE");
			
		}
		
		override public function onAppear(){
			
		}
		
	}
}