package  {
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.media.SoundTransform;
	import flash.net.URLRequest;
	
	public class SoundManager{
		
		
		public function SoundManager() {
			// constructor code
			var mySound:Sound = new Sound();
			mySound.load(new URLRequest("myFavSong.mp3"));
			mySound.play();
			
		}
		
		
	}
	
}
