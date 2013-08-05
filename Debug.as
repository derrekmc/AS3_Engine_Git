package{
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.text.AntiAliasType;
	import flash.display.MovieClip;
	import Display;
	import Global;
	
	public class Debug extends MovieClip{
		
		public static var Text:TextField;
		public static var textFormat:TextFormat;
		public static var debugDisplay:MovieClip;
		public static var debugLvl:int = 3;
		public static var debugEnabled:Boolean = false;
		
		public static var FUNCTION_NAMES:Number = 6;
		public static var OBJECT_DETAILS:Number = 6;
		
		public static var OBJECT_DESTROY:Number = 8;
		public static var OBJECT_CREATE:Number = 9;
		public static var P_ALL:Number = 999;
		
		function Debug(){
			this.name = "Debug";
		}
		
		public static function init():void{			
			if(debugEnabled == true){
				debugDisplay = new MovieClip();
				Display.addchild(debugDisplay);
				
				var X:int = 10;
				var Y:int = 10;
				var Width:int = 600;
				var Height:int = 700;
				
				textFormat = new TextFormat();
				textFormat.size = 12;
				textFormat.bold = false;
				textFormat.font = "Arial";
				
				Text = new TextField();
				Text.x = X;
				Text.y = Y;
				Text.defaultTextFormat = textFormat;
				Text.selectable = false;
				Text.antiAliasType = AntiAliasType.ADVANCED;
				Text.width = Width;
				Text.height = Height;
				Text.textColor = 0x000000;
				Text.multiline = true;
				Text.wordWrap = true;
				
				print("Entering Debug Mode", 1);
				
				debugDisplay.addChild(Text);			
			}
		}
		
		public static function print(_txt:String, lvl:int):void{
			
			
			if(lvl <= debugLvl && debugEnabled == true){
				Text.appendText("\n" + _txt);				
				trace(_txt);
			}
			
		}
	}
}