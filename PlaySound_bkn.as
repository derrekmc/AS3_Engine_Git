package  {
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.media.SoundTransform;
	import flash.net.URLRequest;
	import Global;
	
	import ca.organa.sound.FadeSound;
	import ca.organa.events.FadeSoundEvent;
	import fl.motion.easing.Sine;
	import flash.events.Event;
	
	public class PlaySound{
		
		public var urlRequest:URLRequest;
		public var soundClip:Sound;
		public var soundChannel:SoundChannel;
		public var soundTrans:SoundTransform;
		public var playingSoundFx:Boolean	= false;
		
		var fadeSound:FadeSound = new FadeSound();
		
		public function PlaySound(filename:String="spooky.mp3") {
			// constructor code			
			/*urlRequest 		= new URLRequest(Global.Path + "sounds/" + filename);
			trace(Global.Path + "sounds/" + filename);
			soundClip 		= new Sound();
			soundChannel 	= new SoundChannel();
			soundTrans 		= new SoundTransform();
			
			soundClip.load(urlRequest);
			
			soundTrans.volume = .5;
			soundChannel.soundTransform = soundTrans;
						
			trace("sound");
			*/
			fadeSound.addEventListener(Event.COMPLETE, onMP3Loaded);
			fadeSound.load(new URLRequest(Global.Path + "sounds/" + filename));
		}
		
		public function play(){
			if(playingSoundFx == true) return;
			trace("playsound");
			playingSoundFx = true;
			soundChannel = soundClip.play();
		}
		
		public function stop(){
			if(playingSoundFx == false) return;
			trace("stopsound");
			playingSoundFx = false;
			soundChannel.stop();
		}
		
		function onMP3Loaded(e:Event):void {
			fadeSound.removeEventListener(Event.COMPLETE, onMP3Loaded);
			fadeSound.playWithFadeIn(1, null, 3, 2, Sine.easeOut);
			fadeSound.addEventListener(FadeSoundEvent.SOUND_FADE_IN_COMPLETE, onSoundFadeEvent);
			fadeSound.addEventListener(FadeSoundEvent.SOUND_FADE_OUT_COMPLETE, onSoundFadeEvent);
			fadeSound.addEventListener(FadeSoundEvent.SOUND_FADE_OUT_STARTED, onSoundFadeEvent);   
		}
		//
		//fade05.addEventListener(MouseEvent.CLICK, onButtonClick);
		//fade3.addEventListener(MouseEvent.CLICK, onButtonClick);
		//
		/*function onButtonClick(e:MouseEvent):void {
			switch (e.target){
				case fade05:
					fadeSound.stopWithFadeOut(0.5, Sine.easeIn);
					break;
				case fade3:
					fadeSound.stopWithFadeOut(3, Sine.easeIn);
					break;			
			}
		}*/
		//
		function onSoundFadeEvent(e:Event):void {
			switch (e.type){
				case FadeSoundEvent.SOUND_FADE_IN_COMPLETE:
					trace("SOUND has faded in.");
					break;
				case FadeSoundEvent.SOUND_FADE_OUT_COMPLETE:
					trace("SOUND has faded out.");
					break;
				case FadeSoundEvent.SOUND_FADE_OUT_STARTED:
					trace("SOUND has started to fade out.");
					break;
			}
		}
		
	}
	
}
