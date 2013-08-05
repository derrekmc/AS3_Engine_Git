
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
        static var loader_buffer:Array;
		static var loader_buffer_requests:Array;
		static var loader_buffer_content:Array;
		
		public var completed:Boolean = false;
		public var url;
		public function ImageLoader(_url:String, _x=0, _y=0, _w=0, _h=0, _visible=true) {
            this.url = _url;
			this.x = _x;
			this.y = _y;
			//this.width = _w;
			//this.height = _h;
			
			this.visible = _visible;
			
			if(!loader_buffer) 			loader_buffer = new Array();
			if(!loader_buffer_requests) loader_buffer_requests = new Array();			
			if(!loader_buffer_content) loader_buffer_content = new Array();			
           
		  
            
			
			//Debug.print("Loading: " + url, 2);
            var isLoader = isInLoadBuffer(url);
			
			if(isLoader == false && url != "pak/"){
				trace("not in load buffer " + url);
				
				
				var request:URLRequest = new URLRequest(url);
				load(request);				
								
				//this.contentLoaderInfo.addEventListener(Event.INIT, initHandler);
			   
               // this.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, ioErrorHandler);
				
				loader_buffer_requests.push(url);
				
				
			//}else{
				
			}
			this.contentLoaderInfo.addEventListener(Event.COMPLETE, completeHandler);
			this.addEventListener("loading_complete", workingh);
			loader_buffer_content.push(this);
						
	    }	
				
		public function completeHandler(event:Event):void {
			
           // Debug.print("Loading completeHandler", 4);
			// trace("completeHandler", this.url);
			//loader_buffer_content.push(this);
			
			for(var j=0; j < loader_buffer_requests.length; j++){
				//trace("loader working" + Request.url);
				if(loader_buffer_requests[j] == event.target.loader.url){
					
					for(var i=0; i < loader_buffer_content.length; i++){
						//trace("loader_buffer_content working::" + this.url, loader_buffer_content[i].content);
						if(loader_buffer_content[i].url == loader_buffer_requests[j]){
							
							loader_buffer_content[i] = event.target.loader;
							trace("loader working" + loader_buffer_content[i].content,  j, i, loader_buffer_content[i].parent);
							loader_buffer_content[i].parent.ObjAsset = event.target.loader;
							//loader_buffer_content[i].completed = true;
							loader_buffer_content[i].dispatchEvent(new Event("loading_complete", true));
						}
					}
				
				}
			}
				
			
				//contentT.dispatchEvent(new Event("loading_complete", true, true));
			//this.x = 0;
			//this.y = 2;
			
			//this.width = 520;
			//this.height = 740;
			//this.width = this.height-40;
			
			//this.width = 520;
			//this.height = 766;
			
			
        }
		
		public function workingh(e:Event){
			trace("working");
		}
		
		public function isInLoadBuffer(Request):Boolean{
			for(var i=0; i < loader_buffer_requests.length; i++){
				//trace("loader working" + Request.url);
				if(loader_buffer_requests[i] == Request){
					
					return true;//loader_buffer[i];
				}
			}
			return false;
		}


		public function getContentFromPreviousLoad(){
			for(var i=0; i < loader_buffer_content.length; i++){
				//trace("loader working" + loader_buffer_content[i].url);
				if(loader_buffer_content[i].url == this.url){
					//trace("loader_buffer_content working" + Request);
					return loader_buffer_content[i];//loader_buffer[i];
				}
			}
			
		}

        private function initHandler(event:Event):void {
           // var loader = Loader(event.target.loader);
           // var info:LoaderInfo = LoaderInfo(loader.contentLoaderInfo);
			
			//loader.visible = false;
			//loader.alpha = 0;
			
          //  Debug.print("initHandler: loaderURL=" + info.loaderURL + " url=" + info.url, 4);
        }

        private function ioErrorHandler(event:IOErrorEvent):void {
            Debug.print("ioErrorHandler: " + event, 4);
        }
    }
}