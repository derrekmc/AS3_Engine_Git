package  {
	
	import Obj;
	import InputController;
	
	public class Vehicle extends Obj{
		
		var controller:InputController;
		var passengers:Array = new Array();
		
		public function Vehicle(name:String="vehicle", filename:String="jetpak.png", offSetX:Number=0, offSetY:Number=0) {
			// constructor code
			super(name, filename, "vehicle", offSetX, offSetY, "POINT");
			
		}
		override public function init(){
			//this.xspeed += 0.1;
			//watch();
		}
		
		/*override public function update(){
			if(passengers.length){
				trace("update");
			}
		}*/
		
		override public function interact(object:Obj):void{
			if(object.type == "player"){
				//object.controller.stopKeyboard();
				this.attach(object);
				this.removeFromCollisionList(objects);
				//controller = new InputController();
			}
		}
		
		public function addPassenger(object:Obj):void{
			trace("adding passenger");
			passengers.push(this);
		}
		
	}
	
}
