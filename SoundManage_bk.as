package  {
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.media.SoundTransform;
	import flash.net.URLRequest;
	
	public class SoundManage{
		
		public var urlRequest:URLRequest;
		public var soundClip:Sound;
		public var soundChannel:SoundChannel;
		public var soundTrans:SoundTransform;
		
		public function SoundManage() {
			// constructor code
			
			urlRequest = new URLRequest("pak/sounds/flame_thrower.mp3");
			soundClip = new Sound();
			soundClip.load(urlRequest);
			soundChannel = soundClip.play();
			soundTrans = soundChannel.soundTransform;
			
			
			soundTrans.volume = .5;
			soundChannel.soundTransform = soundTrans;
			trace("sound");
			
		}
		
		public function loadSound(){
			
		}
		
	}
	
}
