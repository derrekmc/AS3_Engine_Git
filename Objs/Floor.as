package Objs {
	
	import Obj;
	//import ImageLoad
		
	public class Floor extends Obj{
				
		public function Floor(name:String="floor", filename="", offSetX=0, offSetY=0) {
			this.friction = 0.97;
			this.filename = filename;
			var array:Array = filename.split(".png");
			var newFilename = array[0] + "_map.png";
			//trace(newFilename);
			
			super(name, newFilename, "floor", offSetX, offSetY, "NONE");
			
			//collisionLayer = new Obj("collisionLayer", filename, "collisionLayer", offSetX, offSetY, "PER_PIXLE");
			//addChild(collisionLayer);
		}
		
		override public function onAppear(){
			var floorIamge = new Obj("floorImage", filename, "floor");
			
			addChild(floorIamge);
			//this.x += Global.randRange(10,1000);
			
		}
		
	}
}