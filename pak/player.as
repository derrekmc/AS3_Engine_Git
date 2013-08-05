import objects;

class player extends objects{
	
		
	function player(){
	
	}
	
	function onEnterFrame(){
		
		if(Key.isDown(Key.RIGHT)){
			//this._x-=_global.bgspeed;
			
			_root.forground._x-=_global.bgspeed;
			_root.bg._x-=_global.bgspeed;
			//_root.clouds._x-=_global.bgspeed/10;
			this._xscale=+100;		
			this.gotoAndPlay("run");
			
		}
		
		if(Key.isDown(Key.LEFT)){
			
				//this._x+=_global.bgspeed;
				_root.forground._x+=_global.bgspeed;
				_root.bg._x+=_global.bgspeed;
				//_root.clouds._x+=_global.bgspeed/10;
				this._xscale=-100;
				this.gotoAndPlay("run");			
			
		}
		
		_root.playerx = _root.bg._x - this._x;
		//_root.playery = _root.bg._x - this._y;
		
		
	}
}