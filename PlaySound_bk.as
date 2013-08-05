package  {
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.media.SoundTransform;
	import flash.net.URLRequest;
	import Global;
	import flash.utils.Timer;
	import flash.events.TimerEvent;
	
	public class PlaySound{
		
		public var urlRequest:URLRequest;
		public var soundClip:Sound;
		public var soundChannel:SoundChannel;
		public var soundTrans:SoundTransform;
		public var playingSoundFx:Boolean	= false;
		
		public function PlaySound(filename:String="spooky.mp3") {
			// constructor code			
			urlRequest 		= new URLRequest(Global.Path + "sounds/" + filename);
			trace(Global.Path + "sounds/" + filename);
			soundClip 		= new Sound();
			soundChannel 	= new SoundChannel();
			soundTrans 		= new SoundTransform();
			
			soundClip.load(urlRequest);
									
			trace("sound");
			
		}
		
		public function play(vol:int=1, fadeIn:int=1){
			if(playingSoundFx == true) return;
			trace("playsound");
			playingSoundFx = true;
			soundChannel = soundClip.play();
			soundTrans.volume = vol;
			//soundChannel.soundTransform = soundTrans;
			if(fadeIn != 0){
				var time:Timer = new Timer(fadeIn * 1000, 1);
				//time.addEventListener(TimerEvent.TIMER_COMPLETE, fadeInSoundFx);
			}
		}
		
		public function stop(){
			if(playingSoundFx == false) return;
			trace("stopsound");
			playingSoundFx = false;
			soundChannel.stop();
		}
		
	}
	
}
