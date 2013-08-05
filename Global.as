package{

	
	public class Global{
		
		
		public static var GFXHigh = 5;
		public static var GFXLow = 1;
		public static var GFXQuality = GFXLow;
		//////////////////GUI COLORS///////////////////
		public static var outLineColor = 0x1c1c1c;
		public static var bgFillColor = 0x030303;
		public static var bodyTextColor = 0x777777;
		public static var bodyTextHighlightColor = 0xFFFFFF;
		
		public static var KeyboardLeft 	= false;
		public static var KeyboardRight = false;			
		public static var KeyboardUp 	= false;						
		public static var KeyboardDown 	= false;
		
		public static var MouseDown 	= false;
		public static var MouseMove 	= false;			
		////////////////Text Styles///////////////////
		
		public static var Path 	= "pak/";
		
		public static var Left 	= -1;
		public static var Right	= 1;			
		public static var Up 	= -1;
		public static var Down 	= 1;		
		
		public static var SOUND_LVL_MUSIC_BKG 			= 0.8;
		public static var SOUND_LVL_SOUND_EFFECTS		= 0.4;
		public static var SOUND_LVL_AMBIENCE_BKG		= 0.7;
		
		
		
		public static var fontSize = 15;
		
		public static var htmlBodyTextColor = "#777777";
		public static var htmlBodyTextHighlightColor = "#FFFFFF";
				
		public function Global(){
			
			
						
		}
		
		public static function init(){
			 
			 Global.GFXQuality = Global.GFXLow;
			
			 
			////////////////Text Styles///////////////////
			
			//non html
			 
			
			 Global.fontSize = 15;
			
			 Global.htmlBodyTextColor = "#777777";
			 Global.htmlBodyTextHighlightColor = "#FFFFFF";
		}
		
		// returns a random value between min and max
		public static function randRange(min:Number, max:Number):Number
		{
			return Math.random()*(max-min)+min; 
		}
		
		public static function in_array( needle:String, haystack:Array ):Boolean {
			for( var a = 0; a < haystack.length; a++ ) {
				if( haystack[a] == needle ) {
					return true;
				}else if( haystack[a] is Array ) {
					return in_array(needle, haystack[a]);
				}
			}
			return false;
		}
		
		
	}	
}
