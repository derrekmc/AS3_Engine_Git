/*package{
	
	import Debug;
	import _Loader;
		
	class LoadGame{
			
		private var myLoader:MovieClipLoader;
		private var Swf:_Loader;
		
		private var debug:Debug;
		
		function LoadGame(){
			debug = new Debug();		
			myLoader = new MovieClipLoader();
		}		
		
		function init(){		
			
			debug.print("Loading Game");
			
			_root.assets = [{name: "Lucifer", file: "player.swf", type: "Player"}];
			
			for (var i=0; i < _root.assets.length; i++){			
							
				debug.print("Asset:" + 		_root.assets[i].name);
				debug.print("File:" + 		_root.assets[i].file);	
				debug.print("Type:" + 		_root.assets[i].type);	
														
				Swf = new _Loader();
				Swf.initLoad(_root.assets[i].name, _root.assets[i].file, 200, 270, true, false);
				
				debug.print("Loading Complete");
			}
		}
				
	}
}*/
package{
 
	import Display;
	import Debug;
	import Global;
	import ImageLoader;
	import Obj;
	import World;
	
	public class LoadGame {
		
		
		var debug:Debug = new Debug();
		
		static var movies:Array = new Array();
				
				
		function Room(){			
			
		}
						
		function init(){
			
		}
		
		static function set state(s){
		}
		
		static function get state(){
			return ;
		}
		
	}
	
}