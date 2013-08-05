package  {
	
	import Debug;
	import Obj;
	
	public class Layer extends Obj{
		var layers:Array;
		public function Layer(name:String) {
			// constructor code
			super(name, "", "layer", 0, 0, "NONE");
			layers = new Array();
		}
			
		public function add(object:Object, pos:int=-1){ // -1 means on top 0 means at the begining pos is any order you wish to specify in between
			if(pos == -1){
				this.layers.push(object);
			}else if(pos == 0){
				this.layers.unshift(object);
			}else{
				this.layers.splice(pos, 0, object);
			}
			
		}

	}
	
}
