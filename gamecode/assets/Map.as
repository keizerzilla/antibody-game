package gamecode.assets {
	
	import flash.utils.ByteArray;
	
	[Embed(source = "../../assets/gamemap.txt", mimeType = "application/octet-stream")]
	public class Map extends ByteArray {
		public function Map():void {}
	}

}