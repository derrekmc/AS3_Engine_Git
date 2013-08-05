package  {
	//import flash.media.Sound;
	//import flash.media.SoundChannel;
	import flash.media.SoundTransform;
	import flash.net.URLRequest;
	import Global;
	
	import ca.organa.sound.FadeSound;
	import ca.organa.events.FadeSoundEvent;
	import fl.motion.easing.Sine;
	import flash.events.Event;
	import Display;
	
	public class PlaySound{
		
		public var urlRequest:URLRequest;
		//public var soundClip:Sound;
		//public var soundChannel:SoundChannel;
		public var soundTrans:SoundTransform;
		public var playingSoundFx:Boolean	= false;
		
		public var fadeSound:FadeSound = new FadeSound();
		
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
			//trace(Global.Path + "sounds/" + filename);
		}
		
		public function play(fadeIn:Number=1, vol:Number=1){
			if(playingSoundFx == true) return;
			//trace("playsound");
			playingSoundFx = true;
			
			//soundChannel.soundTransform = soundTrans;
			var pan = 0;
			if(Display.player) pan = Display.player.direction;
			//trace("vol:", vol, "pan", pan);
			fadeSound.playWithFadeIn(0, new SoundTransform(vol, pan), fadeIn, 0, Sine.easeOut);
			//soundChannel = soundClip.play();
		}
		
		public function stop(){			
			//if(playingSoundFx == false) return;
			//trace("stopsound");
			playingSoundFx = false;
			fadeSound.stopWithFadeOut();
			//soundChannel.stop();
		}
		
		function onMP3Loaded(e:Event):void {
			fadeSound.removeEventListener(Event.COMPLETE, onMP3Loaded);
			
			//fadeSound.addEventListener(FadeSoundEvent.SOUND_FADE_IN_COMPLETE, onSoundFadeEvent);
			fadeSound.addEventListener(FadeSoundEvent.SOUND_FADE_OUT_COMPLETE, onSoundFadeEvent);
			//fadeSound.addEventListener(FadeSoundEvent.SOUND_FADE_OUT_STARTED, onSoundFadeEvent);   
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
					//trace("SOUND has faded in.");
					break;
				case FadeSoundEvent.SOUND_FADE_OUT_COMPLETE:
					//trace("SOUND has faded out.");
					playingSoundFx = false;
					break;
				case FadeSoundEvent.SOUND_FADE_OUT_STARTED:
					//trace("SOUND has started to fade out.");
					break;
			}
		}
		
	}
	
}
