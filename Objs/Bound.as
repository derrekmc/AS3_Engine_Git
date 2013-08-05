package Objs {
	
	import Obj;

	public class Bound extends Obj{
		
		public var w;
		public var h;
			
		public function Bound(name:String="bound", w:int=400, h:int=400, offSetX:Number=0, offSetY:Number=0){
			// constructor code
			
			super(name, "invisible.png", "bound", offSetX, offSetY , "NONE");
			this.width = w;
			this.height = h;
		}
		
		override public function init(){
			
		}
				
				
	}
	
}
