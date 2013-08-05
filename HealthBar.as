package
{
	import flash.display.*;
	import fl.transitions.Tween;
	import fl.transitions.easing.*;
	import Obj;
	import Objs.TextObject;
	
	public class HealthBar extends Obj
	{
		var bar:Sprite;
		var ins:Graphics;
		var healthText:TextObject;
		
		
		public function HealthBar(health:int = 100, xLoc:Number=0, yLoc:Number=0, wid:Number = 100, high:Number = 15, bc:uint = 0x333333, fc:uint = 0xbb0000)
		{
			
			this.x = xLoc;
			this.y = yLoc;
			
			var hbol:Sprite = new Sprite();
			addChild(hbol);

			var ol:Graphics = hbol.graphics;
			ol.lineStyle(2, 0x000000, 1);
			ol.beginFill(bc, 0.3);
			ol.lineTo(wid,0);
			ol.lineTo(wid,high);
			ol.lineTo(0,high);
			ol.lineTo(0,0);
			ol.endFill();
			
			var hb:Sprite = new Sprite();
			hbol.alpha = 0.5;
			hbol.addChild(hb);
			bar = hb;
			
			ins = hb.graphics;
			ins.lineStyle(0, 0x000000);
			ins.beginFill(fc, 1);
			ins.lineTo(wid,0);
			ins.lineTo(wid,high);
			ins.lineTo(0,high);
			ins.lineTo(0,0);
			ins.endFill();
			
			healthText = new TextObject("HEALTH", "health_text", 21, 0, 0);
			this.addChild(healthText);
			
			super("health_bar", "", "ui");
			this.origLife = health;
		}
		override public function onAppear(){
			this.alpha = 0;
			
			//Display.cam.addText("HEALTH", "health_text", 21,  26, 555);
			
		}
			public function updateHealth(life:Number)
			{
				//var myTween:Tween = new Tween(this, "alpha",None.easeNone, 0, 0.5, 1, true);
				var scaleChange = bar.scaleX;
				var s = (life/this.origLife) ;
				//trace(s,life);
				if(s < 1 && s > 0) bar.scaleX = s;
				if(s >= 1) bar.scaleX = 1;
				//myTween = new Tween(this, "alpha",None.easeNone, 0.5, 0, 1, true);
				//if(scaleChange == bar.scaleX) glow(0xff0000,0.5);
			}
			public function addHealth(life:Number)
			{
				bar.scaleX += life/100;
			}
			public function getHealth():Number
			{
				return bar.scaleX*100;
			}
		}
}