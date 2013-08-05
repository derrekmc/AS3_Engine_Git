package Objs {
	import Obj;
	import flash.display.MovieClip;
	import Debug;
	import Display;
	import flash.ui.Keyboard;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	//import flash.ui.Mouse;
	import com.coreyoneil.collision.CollisionList;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	import ImageLoader;
	
	public class TextObject extends Obj{
				
		public function TextObject(name:String="", filename="", offSetX=0, offSetY=0) {
			this.friction = 0.95;
			
			var array:Array = filename.split(".png");
			var newFilename = array[0] + "_map.png";
			trace(newFilename);
			var image;
			image = new ImageLoader(newFilename, offSetX, offSetY, 0, 0, true);
			if(image){
				this.collisionLayer = image;
				addChild(collisionLayer);
			}
			this.collisionType = "BOUNDING_BOX";
			super(name, filename, "floor", offSetX, offSetY, "POINT");
			
		}
		
		override public function init(){
			
			//ObjAsset.alpha = 0.5;
		}
		
		
		override public function removeListenersAndChildren(e:TimerEvent):void{
			
			trace("removeListenersAndChildren:" + this.name);
			
			Display.cam.attachTo(Display.myCursor);
			while (this.numChildren > 0){
				this.removeChildAt(0);
			}			
			
			if(this.hasEventListener(Event.ENTER_FRAME)){
				removeEventListener(Event.ENTER_FRAME, updateObject);
				this.removeFromCollisionList(objects);
				//delete(Display.player);
			}
						
		}
		
		override public function destroy():void{
			if(this.dying!=false) return;
			this.dying = true;
			trace("Player Dead" );
			
			//this.drop();
			
			
			this.removeFromCollisionList(objects);
			
			
			//removeListenersAndChildren();			
			
		}
		
		
	}
}