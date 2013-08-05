//PLAY THIS FOR AT LEAST 30 SECONDS SEE HOW HIGH YOU CAN SCORE!@! Try and break 100 Then let me know how you liked the code =)




//INSTRUCTIONS: Drag and toss the ball for the initial speed.






package {
	
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	
	public class Main1 extends Sprite {
	
		private var ball:Ball;
		private var paddle:Paddle;
		private var lastMouse:Point = new Point();
		private var mouseMoved:Point = new Point();
				
		public function Main1() {
			var bounds:Rectangle = new Rectangle(0, 0, stage.stageWidth, stage.stageHeight);
			ball = new Ball(20, bounds);
			paddle = new Paddle(10, 80);
						
			ball.x = bounds.x + bounds.width/2;
			ball.y = bounds.y + bounds.height/2;
			//ball.addCollider(paddle);
			addChild(ball);
			addChild(paddle);
			
			ball.addCollider(paddle);
			
			ball.addEventListener(Event.ENTER_FRAME, checkPaddle);
			ball.addEventListener(MouseEvent.MOUSE_DOWN, grabBall);
			ball.addEventListener(MouseEvent.MOUSE_UP, releaseBall);
		}	
		
		private function checkPaddle(evt:Event):void {
			/*var shapeBounds:Rectangle = getBounds(parent);
		
			if (shapeBounds.left < bounds.left) {
				vector.x = Math.abs(vector.x);
			}else if (shapeBounds.right > bounds.right) {
				vector.x = -Math.abs(vector.x);
			}
			
			if (shapeBounds.top < bounds.top) {
				vector.y = Math.abs(vector.y);
			}else if (shapeBounds.bottom > bounds.bottom) {
				vector.y = -Math.abs(vector.y);
			}*/
			
		}
		
		private function grabBall(evt:MouseEvent):void {
			ball.toss(new Point(0,0));
			ball.startDrag();
			lastMouse = new Point(mouseX, mouseY);
			
			addEventListener(Event.ENTER_FRAME, moveBall);
			moveBall(new Event(Event.ENTER_FRAME));
		}
		
		private function releaseBall(evt:MouseEvent):void {
			ball.stopDrag();
			ball.toss(mouseMoved);
			
			removeEventListener(Event.ENTER_FRAME, moveBall);
		}
		
		private function moveBall(evt:Event):void {
			var currMouse:Point = new Point(mouseX, mouseY);
			mouseMoved = currMouse.subtract(lastMouse);
			lastMouse = currMouse;
		}
	}
}

import flash.display.Sprite;
import flash.events.Event;
import flash.geom.Point;
import flash.geom.Rectangle;
import flash.display.Stage;
import flash.display.DisplayObjectContainer;

class Ball extends Sprite {
	private var bouncy:Number = 0.04;
	
	private var bounds:Rectangle;
	private var vector:Point = new Point();
	private var gravity:Number = 0;
	private var friction:Number = 1;
	public var colliders:Array = new Array();
	
		
	public function Ball(size:Number, throwBounds:Rectangle) {
		bounds = throwBounds;
		graphics.lineStyle(1);
		graphics.beginFill(0xFF8000);
		graphics.drawCircle(0, 0, size/2);
		
		addEventListener(Event.ENTER_FRAME, soar);
	}
	
	public function toss(tossVector:Point):void {
		vector = tossVector;
	}
	
	public function addCollider(collider:*){
		colliders.push(collider);
	}
	
	private function soar(evt:Event):void {
		
		x += vector.x;
		y += vector.y;
		
		var shapeBounds:Rectangle = getBounds(parent);
		
		//Fake Collision Detection
		if (shapeBounds.right > bounds.right) {
			vector.x = -Math.abs(vector.x);
		}
		
		if (shapeBounds.top < bounds.top) {
			vector.y = Math.abs(vector.y);
		}else if (shapeBounds.bottom > bounds.bottom) {
			vector.y = -Math.abs(vector.y);
		}	
		
		//Real Object Collision Detection
		var maxNum = 10;
		var minNum = -10;
		for each(obj in colliders){
			if(this.hitTestObject(obj)){
				vector.x = Math.abs(vector.x) + (Math.floor(Math.random() * (4 - 1 )) + 1);
				vector.y = (Math.floor(Math.random() * (maxNum - minNum )) + minNum);
				//trace(vector.y);
				trace("Score: " + Math.floor(vector.x));
			}
		}
		
		vector.x *= friction;
		vector.y *= friction;//+bouncy;
		
		if (shapeBounds.left < bounds.left) {
			//var parent:DisplayObjectContainer = this.parent;
			//trace(parent.stage);
			vector.x = shapeBounds.width/2;
			//vector.y = shapeBounds.height/2;
			trace("Fail Try Again Hot Shot");
		}
		
		
		
		if(shapeBounds.bottom <= bounds.bottom){
			vector.y += gravity ;
		}
		
	}
}


class Paddle extends Sprite {
	private var bouncy:Number = 0.04;
	
	private var bounds:Rectangle;
	private var vector:Point = new Point();
	private var gravity:Number = 0;
	private var friction:Number = 1;
		
	public function Paddle(w:Number, h:Number) {
		
		graphics.lineStyle(1);
		graphics.beginFill(0xFF8000);
		graphics.drawRect(0, 0, w, h);
		
		addEventListener(Event.ENTER_FRAME, moveWithMouse);
	}
	
	public function toss(tossVector:Point):void {
		vector = tossVector;
	}
	
	private function moveWithMouse(evt:Event):void {
		this.x = 0;
		this.y = stage.mouseY;
		
	}
}