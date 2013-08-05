package particles2{
	import flash.display.*; 
	import Global;
	import flash.geom.Point;
	import flash.filters.BitmapFilter;
	import flash.filters.BitmapFilterQuality;
	import flash.filters.BlurFilter;
	import flash.events.Event;
	public class Particle extends Sprite
	{	
		public var life : Number = 1;
		public var clip : DisplayObject;
		
		public var xVel : Number = 20; 
		public var yVel : Number = 0;
		
		public var drag : Number = 1; 
		
		public var gravity : Number = 0; 
		
		public var shrink : Number = 1; 
		public var fade : Number = 0; 
		public var spin : Number = 0;
		
		protected var update_i:Timer;
		
		// This is the constructor, a special function used 
		// to create this particle object.
		
		public function Particle(symbolclass:Class, target:DisplayObjectContainer, seed:Point) 
		{
			// make the particle clip
			clip = new symbolclass();
			
			// add it to the target (usually the stage)
			target.addChild(clip); 
			
			birth(seed);
			//filters = [new BlurFilter(0,4,BitmapFilterQuality.HIGH)];
			Display.pDO.addChild(this);
			this.addEventListener(Event.ENTER_FRAME, lifeCycle);
			
		}
		
		public function birth(seed){
			
			// and move it to its starting position
			clip.x = seed.x; 
			clip.y = seed.y; 
			
			
			
			// set our particle's life
			life = 10;
			
			// set our particle's velocity
			xVel += Global.randRange(-.5,1.2); 
			yVel = 0;
			
			// add drag
			drag = 1; 
			
			// add gravity
			gravity = Global.randRange(-0.5,-0.7); 
			
			// randomise initial particle size
			clip.scaleX = clip.scaleY = Global.randRange(.2, .4); 
			
			// add shrink
			shrink = +1.2; 
			
			// add spin
			spin += Global.randRange(-10,+10); 
			
			// add fade 
			fade = 0.015; 
			// set the particle's starting alpha
			
			clip.alpha = Global.randRange(0.6, 1); 
			
		//PARTICLE TYPE EDIT END///////////////////////////////////////////////////
			
			
		}
		
		public function lifeCycle(event:Event) : void
		{
			 // every day you live you die, so if we run one life cycle we take one life.
			// add the velocity to the clip's position
			clip.x += xVel; 
			clip.y += yVel; 
			
			// apply drag
			xVel *= drag; 
			yVel *= drag; 
			
			yVel += gravity; 
			
			clip.scaleX *= shrink;
			clip.scaleY *= shrink; 
			clip.alpha -=fade; 
			clip.rotation +=spin;
			life -= fade*100;
			trace(life);
			//life--;
		}
		
		
		
		// take the clip off the stage
		public function destroy():void
		{
			//if (stageRef.contains(this))
              //      stageRef.removeChild(this);
			//trace("particleDestroy");
			//clip.removeChild(clip); 
			
		}
		
	}
	
}