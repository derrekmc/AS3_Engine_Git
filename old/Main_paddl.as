package {
	
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	
	public class Main extends Sprite {
	
		private var ball:TossableBall;
		private var paddle:Paddle;
		private var lastMouse:Point = new Point();
		private var mouseMoved:Point = new Point();
				
		public function Main() {
			var bounds:Rectangle = new Rectangle(0, 0, stage.stageWidth, stage.stageHeight);
			ball = new TossableBall(20, bounds);
			paddle = new Paddle(10, 80);
			
			ball.x = bounds.x + bounds.width/2;
			ball.y = bounds.y + bounds.height/2;
			addChild(ball);
			addChild(paddle);
			
			ball.addEventListener(Event.ENTER_FRAME, checkPaddle);
			ball.addEventListener(MouseEvent.MOUSE_DOWN, grabBall);
			ball.addEventListener(MouseEvent.MOUSE_UP, releaseBall);
		}	
		
		private function checkPaddle(evt:Event):void {
			
			
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

class TossableBall extends Sprite {
	private var bouncy:Number = 0.04;
	
	private var bounds:Rectangle;
	private var vector:Point = new Point();
	private var gravity:Number = 0;
	private var friction:Number = 1;
		
	public function TossableBall(size:Number, throwBounds:Rectangle) {
		bounds = throwBounds;
		graphics.lineStyle(1);
		graphics.beginFill(0xFF8000);
		graphics.drawCircle(0, 0, size/2);
		
		addEventListener(Event.ENTER_FRAME, soar);
	}
	
	public function toss(tossVector:Point):void {
		vector = tossVector;
	}
	
	private function soar(evt:Event):void {
		x += vector.x;
		y += vector.y;
		var shapeBounds:Rectangle = getBounds(parent);
		
		if (shapeBounds.left < bounds.left) {
			vector.x = Math.abs(vector.x);
		}else if (shapeBounds.right > bounds.right) {
			vector.x = -Math.abs(vector.x);
		}
		
		if (shapeBounds.top < bounds.top) {
			vector.y = Math.abs(vector.y);
		}else if (shapeBounds.bottom > bounds.bottom) {
			vector.y = -Math.abs(vector.y);
		}
		vector.x *= friction;
		vector.y *= friction;//+bouncy;
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