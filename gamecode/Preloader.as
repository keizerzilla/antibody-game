package gamecode {
	
    import com.newgrounds.*;
    import com.newgrounds.components.*;
    import flash.display.MovieClip;
	import flash.media.SoundTransform;

    public class Preloader extends MovieClip {
		
		private const id:String = "secret";
		private const key:String = "secret";
		
        public function Preloader():void {
            var apiConnector:APIConnector = new APIConnector();
            apiConnector.className = "Main";
            apiConnector.apiId = id;
            apiConnector.encryptionKey = key;
            addChild(apiConnector);
			
            if(stage) {
                apiConnector.x = (stage.stageWidth - apiConnector.width) / 2;
                apiConnector.y = (stage.stageHeight - apiConnector.height) / 2;
            }
        }
    }
}