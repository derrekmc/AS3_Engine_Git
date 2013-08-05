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
	import flash.display.Sprite;
	import flash.utils.getQualifiedClassName;
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
		
		public var seed : Point ;
		
		//protected var update_i:Timer;
		
		// This is the constructor, a special function used 
		// to create this particle object.
		//public function Particle(symbolclass:Class, seed:Point, name:String="particle", offSetX:Number=0, offSetY:Number=0, canCollide="NONE", skipFadin:Boolean=true ) 
		public function Particle(name:String, symbolClassOrFileName:*, seed:Point, offSetX:Number=0, offSetY:Number=0,canCollide="NONE" ) 
		{
			this.seed = seed;
			this.x = seed.x; 
			this.y = seed.y;
			
			// add it to the target (usually the stage)
			var filename="particles/";
			switch(true){
				case symbolClassOrFileName is String: 
					filename += symbolClassOrFileName;
				break;
				default:		
					// make the particle clip
					clip = new symbolClassOrFileName();
					clip.x = offSetX;
					clip.y = offSetY;
					this.addChild(clip);
				break;
			} 
			
			//clip.filters = [new BlurFilter(4,4,BitmapFilterQuality.HIGH)];
			
			//this.addEventListener(Event.ENTER_FRAME, lifeCycle);
			
			super(name, filename, "particle", offSetX, offSetY, canCollide, true);
			birth(seed);
			//filters = [new BlurFilter(0, 4, BitmapFilterQuality.HIGH)];
			//this.blendMode = BlendMode.ADD;
			//update_i = new Timer(25); //25ms for smooth movement
            attackStrength = 0.00005;
           // update_i.addEventListener(TimerEvent.TIMER, lifeCycle, false, 0, true);
           // update_i.start();
        	//Display.drawObj(this, 0xff0000, 0.5);
			watch();
			
		}
		
		//public function update($evt:TimerEvent):void{
           
            //Apply The Vector To The Position
            //this.x += vector.x;
            //this.y += vector.y;
           
            //Apply gravity
            //vector.y += gravity;
           
            //Apply Friction!
           // vector.x *= friction;
       // }
	   
	   override public function update(){
			if(this.isAlive()){
				lifeCycle();
			}else{
				destroy();
			}
           
	   }
		
		public function birth(seed){
			
			// and move it to its starting position
			this.x = seed.x; 
			this.y = seed.y;
			//cliprotation = this.getDegreesByMouse();
			
			
			// set our particle's life
			life = 20;
			
			// set our particle's velocity
			xVel += Global.randRange(17.5,55.8); 
			yVel += Global.randRange(7.5,15.8);
			
			// add drag
			drag = Global.randRange(0.7,.8); 
			
			// add gravity
			gravity = Global.randRange(-3.4, -3.8); 
			
			// randomise initial particle size
			clip.scaleX = clip.scaleY = Global.randRange(.8, 1.2); 
			
			// add shrink
			shrink = Global.randRange(1.1, 1.1); 
			
			// add spin
			spin += Global.randRange(-10,+10); 
			
			// add fade 
			fade = 0.014; 
			// set the particle's starting alpha
			
			clip.alpha = Global.randRange(0.0, 0); 
			
		//PARTICLE TYPE EDIT END///////////////////////////////////////////////////
			
			
		}
		
		public function lifeCycle() : void
		{
			 // every day you live you die, so if we run one life cycle we take one life.
			// add the velocity to the clip's position
			this.x += xVel; 
			this.y += yVel; 
			
			// apply drag
			xVel *= drag; 
			yVel *= drag; 
			
			yVel += gravity; 
			
			clip.scaleX *= shrink;
			clip.scaleY *= shrink; 
			//clip.alpha +=fade*10; 
			clip.rotation +=spin;
			life -= fade;
			
			this.fadeToLife();
			//trace(life);
			//life--;
			
			
			
		}
		
		override public function boxBound(object:Obj){			
				//trace("calling boxbound");
				//if()
				yVel *= -0.45 * (Global.randRange(0.5, 1.0));
				xVel *= -0.45 * (Global.randRange(0.5, 1.0));
				//scaleY = scaleX * .8; 
				
				
		}
		
		override public function kill(){
				
			//update_i.stop();
			//update_i.removeEventListener(TimerEvent.TIMER, updateParticle);
			destroy();
		}
		// take the clip off the stage
				
	}
	
}