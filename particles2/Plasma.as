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
	import Display;
	import particles2.PlasmaSpark;
	
	public class Plasma extends Particle
	{	
		[Embed(source = "../pak/particles/plasma_bullet.png")]
        private var particleImage:Class;
		
		var collisionEffect:PlaySound;
		public function Plasma(seed:Point, canCollide="NONE") 
		{
			collisionEffect = new PlaySound("acid_burn_sizzle.mp3");
			soundFx = new PlaySound("plasma_pulse_pass_by.mp3");
			super("plasma", particleImage, seed, 0, -40, canCollide);
            attackStrength = 5;        
			
			//clip.filters = [new BlurFilter(4,4,BitmapFilterQuality.HIGH)];
			//filters = [new BlurFilter(0, 4, BitmapFilterQuality.HIGH)];
			this.blendMode = BlendMode.ADD;
		}
		
		
		override public function birth(seed){
			soundFx.play();
			// and move it to its starting position
			this.x = seed.x; 
			this.y = seed.y;
			//cliprotation = this.getDegreesByMouse();
			
			// set our particle's life
			life = 1060;
			
			// set our particle's velocity
			xVel += Global.randRange(17.5,55.8); 
			yVel += Global.randRange(7.5,15.8);
			
			// add drag
			drag = Global.randRange(0.99,1); 
			
			// add gravity
			gravity = Global.randRange(0.00, 0.00); 
			
			// randomise initial particle size
			this.scaleX = clip.scaleY = Global.randRange(.7, .9); 
			
			// add shrink
			shrink = Global.randRange(1.0, 1.0); 
			
			// add spin
			//spin += Global.randRange(-90,+90); 
			
			// add fade 
			fade = 10; 
			// set the particle's starting alpha
			
			this.alpha = Global.randRange(0.7, 1.0); 
			
			//PARTICLE TYPE EDIT END///////////////////////////////////////////////////
			
			
		}
		
		override public function lifeCycle() : void
		{
			 // every day you live you die, so if we run one life cycle we take one life.
			// add the velocity to the clip's position
			this.x += xVel; 
			this.y += yVel; 
			
			// apply drag
			xVel *= drag; 
			yVel *= drag; 
			
			yVel += gravity; 
			
			this.scaleX *= shrink;
			this.scaleY *= shrink; 
			this.alpha +=fade/100; 
			this.rotation +=spin;
			life -= (fade);
			//trace(life);
			//life--;
			/*if(life < 1){
				this.destroy();
			}*/
			
			
			
		}
		
		override public function boxBound(object:Obj){			
			if(dying == true) return;
			//trace("calling boxbound");
			var surfaceDifference = this.diff( ((this.x+this.width) + (this.y+this.height)), ((object.x+object.width) + (object.y+object.height)));
			var plasmaSurface = ((this.width) + (this.height))/2;
			this.scaleY = 4;
			//trace(object.name + " " + surfaceDifference , this.name + ": " + plasmaSurface  );
				if(plasmaSurface > surfaceDifference){
					filters = [new BlurFilter(10, 10, BitmapFilterQuality.MEDIUM)];
					this.attackStrength/=2;
					yVel *= (Global.randRange(0.2, 0.4));
					xVel *= (Global.randRange(0.2, 0.4));
					
					collisionEffect.play();
					this.die(0.4);
					
				}
				//scaleY = scaleX * .8; 
				
				//trace(this.direction);
				//var ps:PlasmaSpark = new PlasmaSpark(new Point(this.x + ((this.offSetX)), this.y+ this.offSetY), "NONE"); 
				//Display.screen.addChild(ps);
		}
		
		override public function deconstruct():void{
			collisionEffect.stop();
			collisionEffect = null;
			
		}
		
				
	}
	
}