package{
	import Debug;
	import Display;
	import Obj;
	import World;

	import flash.display.MovieClip;
	import flash.display.BlendMode;
	import flash.filters.BitmapFilter;
	import flash.filters.BitmapFilterQuality;
	import flash.filters.BlurFilter;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.*;
	import fl.transitions.Tween;
	import fl.transitions.easing.*;
	import fl.transitions.TweenEvent;
	
	import flash.filters.GlowFilter;

	import Objs.TextObject;
	import Objs.Bound;
		
	class camera extends Obj{
		
		private static var backgrounds:Array;
		private static var ui:Array;
		
		//private var w:int = 500;
		//private var h:int = 240;
		
		//public static var bg:MovieClip;
		private static var cameraAttached:Boolean = false;
		private static var cameraAttachedToObj:Obj;
		
		public static var camSpeed:int;
		public static var camChangeX:int;
		public static var camChangeY:int;
		public static var camChangeZ:int;
		public static var bottomBoundsChange:int;
		public static var cameraFocus:Array;
		public static var primaryFocusItem:Obj;
				
		function camera(name:String, filename=""){
						
			if(camSpeed == 0){
				camSpeed = 12;
			}
			backgrounds = new Array();
			ui = new Array();
			cameraFocus = new Array();
			//backgrounds = new MovieClip();
			//addChild(backgrounds);
			//if(filename == "") filename = "pak/invisible.png";
			
			super(name, "invisible.png", "camera", 0, 0, "NONE");
			
			
		}
		
		public static function getCamera(Name:String){
			return Display.pDO.getChildByName(Name);			
		}
		
		override public function init(){
			//this.x = -400;
			//this.y = -500;
			
			//Display.addBackground();
			Display.addchild(this);
									
			Display.pDO.x = this.x * -1;
			Display.pDO.y = this.y * -1;
			
			this.width = Display.pDO.stage.stageWidth;
			this.height = Display.pDO.stage.stageHeight;
			//_root.camId = setInterval(this, "update", _root.appSpeed);
			//Display.drawObj(this, 0xff0000, 1);
			//trace("camera",this.width, this.height);
			
			watch();
			
		}
		
		override public function onAppear(){
			
		}
		
		override public function update(){		

			if(cameraAttached){
				//Debug.print("cameraAttached", 1);
				camChangeX = (cameraAttachedToObj.x * -1) + stage.stageWidth/2;
				camChangeY = stage.stageHeight/2 + (cameraAttachedToObj.y*-1);
				
				if(cameraFocus.length){
					var changeX = 0;
					var changeY = 0;
					for(i = 0; i < cameraFocus.length; i++){
						changeX += (cameraFocus[i].x * -1) + stage.stageWidth/2;
						changeY += (cameraFocus[i].y * -1) + stage.stageHeight/2
					}
					changeX = (changeX / cameraFocus.length ) - ((cameraAttachedToObj.x * -1) + stage.stageWidth/2 );
					changeY = (changeY / cameraFocus.length ) - ((cameraAttachedToObj.y * -1) + stage.stageHeight/2 );
					//trace(changeX);
					camChangeX -= changeX * -1 ;
					camChangeY -= changeY * -1 ;
					
				}
				
				//trace("attach: ",camChangeX, camChangeY);
			}
			
			var topBoundPadding = 70;
			var bottomBoundPadding = 50;
			var leftBoundPadding = 200;			
			var rightBoundPadding = 200;
			
			if(camChangeY > (Display.screen.stage.stageHeight-bottomBoundsChange - topBoundPadding)) camChangeY = Display.screen.stage.stageHeight-bottomBoundsChange - topBoundPadding;
			if(camChangeY < (Display.screen.stage.stageHeight - (bottomBoundPadding + topBoundPadding))) camChangeY = Display.screen.stage.stageHeight - (bottomBoundPadding + topBoundPadding);
						
			if(camChangeX > (Display.world.x + leftBoundPadding) ) camChangeX = Display.world.x + leftBoundPadding;
			if(camChangeX < (Display.world.x - Display.world.width  + Display.screen.stage.stageWidth + (rightBoundPadding+leftBoundPadding)) ) camChangeX = Display.world.x - Display.world.width + Display.screen.stage.stageWidth + (rightBoundPadding+leftBoundPadding);

			var currentx = this.x;
			var currenty = this.y;
			
			var finalx = currentx + camChangeX;
			var finaly = currenty + camChangeY;
			
			this.x = currentx-(finalx/camSpeed);	
			this.y = currenty-(finaly/camSpeed);	
			
			
			Display.pDO.x = this.x * -1;
			Display.pDO.y = this.y * -1;
			
			Display.Background.x = this.x-20;
			Display.Background.y = this.y-20;
			
			var bgX;
			var bgY;
			
			for(var i:int = 0; i < backgrounds.length; i++){
				bgX = backgrounds[i].startX;
				bgY = backgrounds[i].startY;
				backgrounds[i].x = this.x + bgX + ( this.x * backgrounds[i].speed) *-1;
				backgrounds[i].y = this.y + bgY + (this.y * backgrounds[i].speed/10) *-1;
				
			}
			
			for(i = 0; i < ui.length; i++){
				bgX = ui[i].offSetX;
				bgY = ui[i].offSetY;
				ui[i].x = bgX + this.x;
				ui[i].y = bgY + this.y;
				
			}
			
			
			
			 if(this.width != Display.pDO.stage.stageWidth) this.width = Display.pDO.stage.stageWidth;
			 if(this.height != Display.pDO.stage.stageHeight) this.height = Display.pDO.stage.stageHeight;
			 
			
			//trace(this.width, Display.pDO.stage.stageWidth);
		}
		
		public function adjustBottomBound(objY:Number):void{
			//trace("adjustBottomBound:" + bottomBoundsChange);
			bottomBoundsChange = objY;		 
		}
		
				
		public function setSpeed(speed:int):void{
			camSpeed = speed;		 
		}
		
		public function attachTo(obj:Obj):void{
			//addToFocus(obj);
			trace("attached to: ", obj.type, obj.name, obj.x, obj.y);
			camChangeX = obj.x-400;
			camChangeY = (obj.y)-300;
			cameraAttached= true;
			cameraAttachedToObj = obj;
			this.adjustBottomBound(obj.y);
		}
		
		public function createBound(x,y,w,h):void{
			var cameraBound:Bound = new Bound("camera_bounding_box", w, h);
			//trace("bound",x,y,w,h);
			cameraBound.moveTo(x,y);
			//cameraBound.x = x;
			//cameraBound.y = y;
			//cameraBound.width = w;
			//cameraBound.height = h;
			Display.drawObj(cameraBound, 0xFF0000);
			Display.addchild(cameraBound);
			//cameraBound.attach(Display.myCursor);
		}
		
		public function stopFocusing():void{
			cameraFocus = [];
		}
		
		public function setFocusOn(obj:Obj):void{
			//this.attachTo(obj);
		}
		
		public function addToFocus(obj:Obj):void{
			cameraFocus.push(obj);
		}
		
		public function moveR():void{
			camChangeX-= camSpeed;
		}
		
		public function moveL():void{
			//if( camChangeX < 0){
				camChangeX += camSpeed;
			//}
			
		}
		
		public function moveU():void{
			
			//if( camChangeY < 100){
				//Debug.print("Up", 1);
				camChangeY += camSpeed;		
			//}
			
		}
		
		public function moveD():void{
			//if( camChangeY < 600){
				//Debug.print("camChangeX: " + camChangeX + "camChangeY: " + camChangeY, 1);
				camChangeY -= camSpeed;		
				//Debug.print("camChangeX: " + camChangeX + "camChangeY: " + camChangeY, 1);
			//}
			
		}
		
		public function moveI():void{
			//if( camChangeZ < 140){
				camChangeZ += camSpeed;
			//}
		}
		
		public function moveO():void{
			
			//if( camChangeZ < 100){				
				camChangeZ -= camSpeed;
				Debug.print("Zoom Out" + camChangeZ + " : " + camSpeed, 1);
			//}
		}
		
		/*public function moveTo(x:int, y:int):void{
			Display.pDO.y = y + camSpeed;	
			Display.pDO.x = x + camSpeed;		
		}*/
		
		
		public function addBackground(filename:String, startX=0, startY=0, speed=1, blendmode=BlendMode.NORMAL){
						
			var bg = new MovieClip();		
			bg.addChild(new Obj("background", filename, "background"));		
			
			bg.startX = this.x + startX;
			bg.startY = this.x + startY;
			
			bg.speed = speed;
			bg.blendMode = blendmode;
			
			Display.addchild(bg);		
			
			//addChild(bg)
			//bg.x += startX;
			//bg.y += startY;
			backgrounds.push(bg);
			//Display.addchild(World.Background);
			return bg;
			
		}
		
		public function addForeground(object:Obj, startX=0, startY=0, blendmode=BlendMode.NORMAL, startAlpha:Number=1, filter:*=null){
						
			//fg.addChild(new ImageLoader(filename));		
			
			object.x = startX;
			object.y = startY;
			
			
			//object.filters = [new BlurFilter(0, 4, BitmapFilterQuality.HIGH)];
			object.blendMode = blendmode;
			
			object.alpha = startAlpha;
			//Display.addchild(bg);		
			
			Display.addchild(object);
			if(object.name == "death" ){
				object.filters = [new BlurFilter(8, 8, BitmapFilterQuality.HIGH)];
			}
			//object.filters.concat([filter]);
			//bg.x += startX;
			//bg.y += startY;
			ui.push(object);
			
			//Display.addchild(World.Background);
			return object;
			
		}
		
		public function addText(text:String, name:String, size:int, x:Number, y:Number){
			//var textobj:TextObject =;
			
			addForeground( new TextObject(text, name, size), x, y);
		}
		
		public function changeText(name:String, text:String, size:int, x:Number, y:Number){
			var textobj = this.getObjByName(name);
			textobj.text = size;
			//addForeground( new TextObject(text, name, size), x, y);
		}
		
		

			
	}
}