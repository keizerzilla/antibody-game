package gamecode.assets {
	
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Tilemap;
	
	public class Body extends Entity {
		
		private var tile:Tilemap;
		private var gamemap:Map;
		
		public function Body(wlen:int, hlen:int):void {
			type = "body";
			tile = new Tilemap(Assets.BODY_TILESET, wlen, hlen, 32, 32);
			gamemap = new Map();
			tile.loadFromString(gamemap.toString());
			graphic = tile;
			mask = tile.createGrid([1, 2]);
		}
		
	}

}