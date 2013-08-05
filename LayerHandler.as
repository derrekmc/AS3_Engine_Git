package  {
	
	import Debug;
	import Display;
	import Obj;
	import World;
	import flash.display.MovieClip;
	import flash.display.BlendMode;
	import flash.filters.BitmapFilter;
	import flash.filters.BitmapFilterQuality;
	import flash.filters.BlurFilter;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.*;
	import fl.transitions.Tween;
	import fl.transitions.easing.*;
	import fl.transitions.TweenEvent;
	
	public class LayerHandler {
		var layers:Array;
		public function LayerHandler() {
			// constructor code
			layers = new Array();
		}
		
		public function createLayer(name){
			this.layers.push([name: name]);
		}

	}
	
}
