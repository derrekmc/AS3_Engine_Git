package
{
	import flash.display.*; 
	
	public class Particle
	{	
		public var clip : DisplayObject;
		
		public var xVel : Number = 0; 
		public var yVel : Number = 0;
		
		public var drag : Number = 1; 
		
		public var gravity : Number = 0; 
		
		public var shrink : Number = 1; 
		public var fade : Number = 0; 
		public var spin : Number = 0;
		
		// This is the constructor, a special function used 
		// to create this particle object.
		
		public function Particle(symbolclass:Class, target:DisplayObjectContainer, xpos:Number, ypos:Number)
		{
			// make the particle clip
			clip = new symbolclass();
			
			// add it to the target (usually the stage)
			target.addChild(clip); 
			
			// and move it to its starting position
			clip.x = xpos; 
			clip.y = ypos; 
			
			
		}
		
		public function update() : void
		{
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
			
		}
		
		// take the clip off the stage
		public function destroy():void
		{
			clip.parent.removeChild(clip); 
			
		}
		
	}
	
}