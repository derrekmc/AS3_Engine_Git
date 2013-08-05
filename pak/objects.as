import World;
import Debug;

class objects extends World{
	private var x:Number 			= 0;
	private var y:Number 			= 0;
	private var w:Number 			= 0;
	private var h:Number 			= 0;
	private var yspeed:Number 		= 0;
	private var xspeed:Number 		= 0;
	private var wind:Number 		= 0.00;
	private var power:Number 		= 0.65;
	private var gravity:Number 		= 0.1;
	private var upconstant:Number 	= 0.75;
	private var friction:Number 	= 0.99;
	private var debug:Debug;
	
	function objects(){
		debug = new Debug();
	}
	
	
	function onEnterFrame() {
		/*if (Key.isDown(Key.LEFT)) {
			 xspeed = xspeed - power;
		}
		if (Key.isDown(Key.RIGHT)) {
			 xspeed = xspeed + power;
		}
		if (Key.isDown(Key.UP)) {
			 yspeed = yspeed - power * upconstant;
		}
		*/
		/*if (Key.isDown(Key.DOWN)) {
			 yspeed = yspeed + power * upconstant;
		}*/
		
		xspeed = ( xspeed + wind ) * friction;
		yspeed = yspeed + gravity;
		_y = _y + yspeed;
		_x = _x + xspeed;
		_rotation = _rotation + xspeed;
		
		/*if (_root.wall.hitTest(_x, _y, true)) {
			xspeed = 0;
			yspeed = 0;
			_x = 120;
			_y = 120;
		}*/
		
	} 
	
}