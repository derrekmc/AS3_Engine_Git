package particles2{
	import flash.display.*; 
	import Global;
	import flash.utils.Timer;
    import flash.events.TimerEvent;
	import flash.geom.Point;
	import flash.filters.BitmapFilter;
	import flash.filters.BitmapFilterQuality;
	import flash.filters.BlurFilter;
	import flash.events.Event;
	import Obj;
	public class Particle extends Obj
	{	
		//public var life : Number = 1;
		public var clip : DisplayObject;
		
		public var velocity : Point;
		public var position : Point;
		
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
		
		public function Particle(symbolclass:Class, target:DisplayObjectContainer, seed:Point, canCollide="NONE") 
		{
			// make the particle clip
			clip = new symbolclass();
			
			// add it to the target (usually the stage)
			target.addChild(this); 
			
			birth(seed);
			//filters = [new BlurFilter(0,4,BitmapFilterQuality.HIGH)];
			this.addChild(clip);
			//this.addEventListener(Event.ENTER_FRAME, lifeCycle);
			
			super("particle", "", "particle", 0, 0, canCollide);
			
			//filters = [new BlurFilter(0, 4, BitmapFilterQuality.HIGH)];
			//this.blendMode = BlendMode.ADD;
			//update_i = new Timer(25); //25ms for smooth movement
            
           // update_i.addEventListener(TimerEvent.TIMER, lifeCycle, false, 0, true);
           // update_i.start();
        
			
		}
		
		public function update($evt:TimerEvent):void{
           
            //Apply The Vector To The Position
            //this.x += vector.x;
            //this.y += vector.y;
           
            //Apply gravity
            //vector.y += gravity;
           
            //Apply Friction!
           // vector.x *= friction;
        }
		
		public function birth(seed){
			
			// and move it to its starting position
			clip.x = seed.x; 
			clip.y = seed.y;
			//cliprotation = this.getDegreesByMouse();
			
			
			// set our particle's life
			life = 20;
			
			// set our particle's velocity
			xVel += Global.randRange(-.5,.8); 
			yVel = 0;
			
			// add drag
			drag = .8; 
			
			// add gravity
			gravity = Global.randRange(-1.5,-0.7); 
			
			// randomise initial particle size
			clip.scaleX = clip.scaleY = Global.randRange(.8, 1.2); 
			
			// add shrink
			shrink = +1.1; 
			
			// add spin
			spin += Global.randRange(-10,+10); 
			
			// add fade 
			fade = 0.015; 
			// set the particle's starting alpha
			
			clip.alpha = Global.randRange(0.6, 1); 
			
		//PARTICLE TYPE EDIT END///////////////////////////////////////////////////
			
			
		}
		
		public function lifeCycle() : void
		{
			 // every day you live you die, so if we run one life cycle we take one life.
			// add the velocity to the clip's position
			clip.x += xVel; 
			clip.y += yVel; 
			
			// apply drag
			xVel *= drag; 
			yVel *= drag; 
			
			//yVel += gravity; 
			
			clip.scaleX *= shrink;
			clip.scaleY *= shrink; 
			clip.alpha -=fade; 
			clip.rotation +=spin;
			life -= (fade*100);
			//trace(life);
			//life--;
			/*if(life < 1){
				this.destroy();
			}*/
			
			
			
		}
		
		override public function boxBound(){			
			//trace("calling boxbound");
				yVel *= -0.05;
				xVel *= -0.05;
				
		}
		
		// take the clip off the stage
		override public function destroy():void
		{			
			if (this.contains(clip)){
				//trace("Particle Destroy");
				removeChild(clip); 
				clip = null;
			}			
		}
		
	}
	
}