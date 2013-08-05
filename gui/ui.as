package gui {
	
	import Obj;
	import fl.transitions.Tween;
	import fl.transitions.easing.*;
	import flash.ui.Keyboard;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.ui.Mouse;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	//import flash.utils.Timer;
	import InputController;
	
	public class ui extends Obj{		
		
		public var controller:InputController;
		
		public function ui(name:String="ui", filename:String="", offSetX:Number=0, offSetY:Number=0, skipFadeIn:Boolean=false){
			// constructor code
			super(name, filename, "ui", 0, 0 , "NONE", skipFadeIn);
			controller = new InputController();
			watch();
		}
		
		override public function update(){
			if(controller.MouseDown == true){
				//trace("workin");				
				this.close();				
			}
		}
		
		public function close(){
			if(dying==true) return;
			controller.stopWatchingDevices();
			closed();
			this.kill();
		}
		
		public function closed(){
			
		}
			
		override public function init(){
			trace("construct startScreen");
			
		}
		
		
	}
	
}
