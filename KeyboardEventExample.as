package {
    import flash.display.Sprite;
    import flash.display.DisplayObject;
    import flash.events.*;
	import Display;

    public class KeyboardEventExample extends Sprite {
        private var bgColor:uint = 0x00CCFF;
        private var size:uint = 80;

        public function KeyboardEventExample() {
            var child:Sprite = new Sprite();
            child.graphics.beginFill(bgColor);
            child.graphics.drawRect(0, 0, size, size);
            child.graphics.endFill();
			Display.addchild(this);
            addChild(child);
            stage.focus = child;
            child.addEventListener(KeyboardEvent.KEY_DOWN, keyDownHandler);
            child.addEventListener(KeyboardEvent.KEY_UP, keyUpHandler);
        }

        private function keyDownHandler(event:KeyboardEvent):void {
            trace("keyDownHandler: " + event.keyCode);
            trace("ctrlKey: " + event.ctrlKey);
            trace("keyLocation: " + event.keyLocation);
            trace("shiftKey: " + event.shiftKey);
            trace("altKey: " + event.altKey);
        }

        private function keyUpHandler(event:KeyboardEvent):void {
            trace("keyUpHandler: " + event.keyCode);
        }
    }
}

