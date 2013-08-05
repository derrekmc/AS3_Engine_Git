
package {
    import flash.display.Loader;
    import flash.display.LoaderInfo;
    import flash.display.Sprite;
    import flash.events.*;
    import flash.net.URLRequest;
	import flash.events.EventDispatcher;
	import Display;
	import Debug;

    public class ImageLoader extends Loader {
       
		public var loader:Loader;
		public var completed:Boolean = false;
			
		public function ImageLoader(url:String, _x=0, _y=0, _w=0, _h=0, _visible=true) {
            //loader = new Loader();
			this.x = _x;
			this.y = _y;
			//this.width = _w;
			//this.height = _h;
			
			this.visible = _visible;
			
            this.contentLoaderInfo.addEventListener(Event.INIT, initHandler);
			this.contentLoaderInfo.addEventListener(Event.COMPLETE, completeHandler);
            this.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, ioErrorHandler);
            
			var request:URLRequest = new URLRequest(url);
			Debug.print("Loading: " + url, 2);
            
			load(request);
						
	    }	
		
		private function completeHandler(event:Event):void {
			var loader:Loader = Loader(event.target.loader);			
            Debug.print("Loading completeHandler", 4);
			completed = true;
			
			//this.x = 0;
			//this.y = 2;
			
			//this.width = 520;
			//this.height = 740;
			//this.width = this.height-40;
			
			//this.width = 520;
			//this.height = 766;
			
			dispatchEvent(new Event("loading_complete", true, true));
        }

        private function initHandler(event:Event):void {
            var loader:Loader = Loader(event.target.loader);
            var info:LoaderInfo = LoaderInfo(loader.contentLoaderInfo);
			
			//loader.visible = false;
			//loader.alpha = 0;
			
          //  Debug.print("initHandler: loaderURL=" + info.loaderURL + " url=" + info.url, 4);
        }

        private function ioErrorHandler(event:IOErrorEvent):void {
            Debug.print("ioErrorHandler: " + event, 4);
        }
    }
}