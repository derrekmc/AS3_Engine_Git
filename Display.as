package{	

	import flash.display.StageScaleMode;  
	import flash.display.StageAlign;
	import flash.display.MovieClip;
	import flash.display.Stage;  
	import flash.display.DisplayObject;
	import flash.events.Event;
	import flash.display.GradientType;
	import flash.display.SpreadMethod;
	import flash.display.InterpolationMethod;
	import flash.geom.Matrix; 
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.ui.Mouse;
	import flash.geom.Point;
	import flash.display.MovieClip;
	import flash.filters.BitmapFilter;
	import flash.filters.BitmapFilterQuality;
	import flash.filters.BlurFilter;
	import flash.utils.getQualifiedClassName;
		
	import Debug;
	import Global;
	import World;
	import Display;
	import camera;
	import Obj;
	import Layer;
	import ImageLoader;
	import flash.filters.DisplacementMapFilter;
	
	public class Display extends Obj{
		
		public static var pDO:MovieClip;
		public static var world:World;
		public static var cam:camera;
		public static var hud;
		public static var Background:MovieClip;
		public static var player:Player;
		public static var myCursor:Obj;
		
		public static var layers:Array;
			
		function Display(){		
			//myCursor = new MovieClip();
			super("display");
		}
		
		// Pass in the pDO i.e. the root display. This class is run once and stores the display singleton for future refrence
		public static function init(obj:MovieClip){
			pDO = obj;
			pDO.stage.align = StageAlign.TOP_LEFT;
			pDO.stage.scaleMode = StageScaleMode.NO_SCALE
			//this.addChild(pDO);
			switch(Global.GFXQuality){
				
				case Global.GFXHigh:
					//pDO.stage.addEventListener(Event.ADDED, onStageResize);
				//break;
				
				default:
				case Global.GFXLow:
					
				break;
				
			}
						
			//addchild(myCursor);
			pDO.stage.addEventListener(Event.RESIZE, onStageResize); 
			layers = new Array();
			Background = new MovieClip();
			addchild(Background);
			pDO.stage.addEventListener(Event.ENTER_FRAME, updateBackground);
		}	
		
		public static function addLayer(layerName:String, layerDepth:Number){
			// add to layer system
			var layer = new MovieClip();
			
			//layers.push([]);
			
		}
		
		public static function addToLayer(layerName:String){
			// add to layer system
			
		}
		
		
		
		public static function addchild(child:*){
			
			pDO.addChild(child);
			Debug.print("Display::addchild(" + child.name + ")", Debug.OBJECT_DETAILS);
			
				if(pDO.getChildByName("backgrounds")) pDO.setChildIndex(pDO.getChildByName("backgrounds"), pDO.numChildren-1);
				if(pDO.getChildByName("house")) pDO.setChildIndex(pDO.getChildByName("house"), pDO.numChildren-1);
				if(pDO.getChildByName("world")) pDO.setChildIndex(pDO.getChildByName("world"), pDO.numChildren-1);
				if(pDO.getChildByName("water")) pDO.setChildIndex(pDO.getChildByName("water"), pDO.numChildren-1);
				if(pDO.getChildByName("bridge")) pDO.setChildIndex(pDO.getChildByName("bridge"), pDO.numChildren-1);
				//if(pDO.getChildByName("jetpak")) pDO.setChildIndex(pDO.getChildByName("jetpak"), pDO.numChildren-1);
				if(pDO.getChildByName("p1")) pDO.setChildIndex(pDO.getChildByName("p1"), pDO.numChildren-1);
				
				if(pDO.getChildByName("flame_gun")) pDO.setChildIndex(pDO.getChildByName("flame_gun"), pDO.numChildren-1);
				if(pDO.getChildByName("plasma_rifle")) pDO.setChildIndex(pDO.getChildByName("plasma_rifle"), pDO.numChildren-1);
				if(pDO.getChildByName("foregrounds")) pDO.setChildIndex(pDO.getChildByName("foregrounds"), pDO.numChildren-1);
				if(pDO.getChildByName("particles")) pDO.setChildIndex(pDO.getChildByName("particles"), pDO.numChildren-1);
				if(pDO.getChildByName("particles2")) pDO.setChildIndex(pDO.getChildByName("particles2"), pDO.numChildren-1);
				if(pDO.getChildByName("hud"))	pDO.setChildIndex(pDO.getChildByName("hud"), pDO.numChildren-1);
				
				if(pDO.getChildByName("cursor")) pDO.setChildIndex(pDO.getChildByName("cursor"), pDO.numChildren-1);
				if(pDO.getChildByName("camera")) pDO.setChildIndex(pDO.getChildByName("camera"), pDO.numChildren-1);
				if(pDO.getChildByName("death")) pDO.setChildIndex(pDO.getChildByName("death"), pDO.numChildren-1);
				
				if(Debug.debugEnabled == true){
					if(pDO.getChildByName("Debug")) pDO.setChildIndex(pDO.getChildByName("Debug"), pDO.numChildren-1);
				}
			return pDO.numChildren - 1;
			
			
			
		}
		
		public static function moveToLayer(){
			
		}
		
		public static function getLastChild(){
			if(Debug.debugEnabled == true){
				return pDO.numChildren-1;
			}else{
				return pDO.numChildren;
			}
		}
		
		public static function addWorld(w:World){
			world = w;
		}
		public static function addCamera(Cam:camera){
			cam = Cam;
		}
		
		public static function addHud(h){
			hud = h;
		}
		
		public static function addPlayer(pl:Player){
			player = pl;
		}
		
		public static function get screenX(){
			return  cam.x;
		}
		
		public static function get screenY(){
			return  cam.y ;
		}
		
		public static function get screenW(){
			return  Display.pDO.stage.stageWidth /2 - Display.pDO.cam.width/2;
		}
		
		public static function get screenH(){
			return  Display.pDO.stage.stageHeight /2 - Display.pDO.cam.height/2;
		}
			
		public static function updateBackground(e:Event){
			
					
			
			if(myCursor){
				
				var myStage:Stage = pDO.stage;
			
			var point:Point = new Point(myStage.mouseX- myCursor.offSetX, myStage.mouseY- myCursor.offSetY);
			
				
				myCursor.visible = true;
				myCursor.x = point.x + cam.x;
				myCursor.y = point.y + cam.y;
				myCursor.rotation = myStage.mouseX - myStage.mouseY;
					//trace(myCursor.x, myCursor.y);
			}
		}
		
		public static function onStageResize(e:Event){
			
			addBackground();
			
		}
		public static function get screen():MovieClip{
			return pDO;
		}
		
		public static function addBackground(){
			
			////////////////Background gradient/////////////////////////
			//var sprite:MovieClip = new MovieClip();
			var matrix:Matrix = new Matrix();
			
			matrix.createGradientBox(Display.pDO.stage.stageWidth, Display.pDO.stage.stageHeight, Math.PI/2, 0, 0);
			Background.graphics.beginGradientFill("linear", [0x0b0912, 0x00131b, 0x001f27, 0x000000, 0x000000], [1,1,1,1,1], [0,200,255,200,0], matrix);
			Background.graphics.drawRect(0, 0, Display.pDO.stage.stageWidth+50, Display.pDO.stage.stageHeight+50);
			
			Background.graphics.endFill();
			
			
		}
		
		public static function drawObj(obj, color:uint=0x00ff00, alpha:Number=1){
			
			// define the line style 
			var box = new MovieClip();;
			obj.graphics.lineStyle(1, color, alpha); // define the fill 
			//obj.graphics.beginFill(0x666699) // set the starting point for the line g
			obj.graphics.drawRect(obj.offSetX,obj.offSetY,obj.width-1,obj.height-1);
			//obj.graphics.endFill(); // 
			obj.addChild(box);
			
			//graphics.lineTo(10,10)
			
		}
		
		

		public static function CreateCustomCursor(filename:String)
		{
			Mouse.hide();
			
			// this creates an instance of the library MovieClip with the
			// name, "MyCursorClass".  this contains your mouse cursor art
			//
			myCursor = new Obj("cursor", filename, "cursor", -17, -15,"NONE");
			//myCursor.addChild(new ImageLoader("pak/target.png", ));
			//Display.myCurosr.addChild();
			myCursor.mouseEnabled = true;
			myCursor.visible = true;
			//myCursor.filters = [new BlurFilter(0,4,BitmapFilterQuality.HIGH)];
			// you'll want to make sure the child is added above everything
			// else, possibly in its own container
			//
			addchild(myCursor);
			
			// respond to mouse move events
			pDO.stage.addEventListener(MouseEvent.MOUSE_MOVE, Display.mouseMoveHandler);
			pDO.stage.addEventListener(Event.MOUSE_LEAVE, Display.mouseLeaveHandler);
			return myCursor;
		}
		
		public static function mouseMoveHandler(evt:MouseEvent):void
		{
			//trace("moving", pDO.stage.mouseX, pDO.stage.mouseY);
			// whenever the mouse moves, place the cursor in the same spot
			
			
           // return point;
			
			
		}
		
		public static function mouseLeaveHandler(evt:Event):void
		{
			//trace("mouseLeaveHandler");
			//myCursor.visible = false;
		}

	}
}