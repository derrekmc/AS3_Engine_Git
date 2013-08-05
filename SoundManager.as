package  {
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.media.SoundTransform;
	import flash.net.URLRequest;
	
	public class SoundManager{
		
		public var urlRequest:URLRequest;
		public var soundClip:Sound;
		public var soundChannel:SoundChannel;
		public var soundTrans:SoundTransform;
		
		public var backgroundMusic:BackgroundMusic;
		public var bgmSoundChannel:SoundChannel;	//bgm for BackGround Music
		public var enemyAppearSound:EnemyAppearSound;
		public var sfxSoundChannel:SoundChannel;	//sfx for Sound FX
		
		public var sfxSoundChannel:SoundChannel;
		
		public function SoundManager(filename="pak/sounds/spooky.mp3") {
			// constructor code
			
			urlRequest = new URLRequest(filename);
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
