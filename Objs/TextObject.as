package Objs {
	import Obj;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.text.TextFieldAutoSize;
	import flash.text.Font;
	
	public class TextObject extends Obj{
		public var myText:TextField;
		public var format:TextFormat;
		public var textSize:int;
		[Embed(source="../pak/fonts/Bruce Mikita.ttf", fontFamily="CustomFont", mimeType="application/x-font")]
		var CustomFont:Class;
		
		public function TextObject(text:String, name:String, size:int=20, offSetX:Number=0, offSetY:Number=0, skipFadin:Boolean=false){
			super(name, "", "text", 0, 0, "NONE", skipFadin);
			
			this.myText = new TextField();
			this.format = new TextFormat();
			this.textSize = size;
			
			myText.text = text;
			myText.x = offSetX;
			myText.y = offSetY;
			myText.alpha = 0.5;
			myText.textColor = 0xFFFFFF;
			myText.autoSize =  TextFieldAutoSize.LEFT ;
				
			
			format.size = size;
			format.font = "Bruce Mikita";
			
			myText.embedFonts = true;
			myText.cacheAsBitmap = true;
			myText.setTextFormat(format);
			myText.defaultTextFormat = format;
			addChild(myText);
		}
		
		override public function init(){
		}
		
		public function set text(txt:String){
			this.myText.text = txt;
		}
		
		public function get text(){
			return this.myText.text;
		}
		
		public function set size(newSize:int){
			this.format.size = newSize;
			myText.setTextFormat(this.format);
		}
		
		public function get size(){
			return (this.myText.text.length * textSize) + (8 *  this.myText.text.length);
		}
								
	}
}