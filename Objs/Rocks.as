﻿package Objs {
	
	import Obj;
		
	public class RocksWall extends Obj{
				
		public function RocksWall(name:String="rockswall", filename="rocks.png", offSetX=0, offSetY=0) {
			this.friction = 0.95;
			
			var array:Array = filename.split(".png");
			var newFilename = array[0] + "_map.png";
			trace(newFilename);
			
			collisionLayer = new Obj("collisionLayer", newFilename, "collisionLayer", offSetX, offSetY, "NONE");
			addChild(collisionLayer);
						
			super(name, filename, "floor", offSetX, offSetY, "NONE");
			
		}
		
		override public function onAppear(){
			
		}
		
	}
}