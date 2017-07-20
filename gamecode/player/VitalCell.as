package gamecode.player {
	
	import gamecode.Actor;
	import gamecode.assets.Assets;
	import net.flashpunk.graphics.Canvas;
	
	public class VitalCell extends Actor {
		
		public function VitalCell(xpos:Number, ypos:Number, darkness:Canvas):void {
			super(Assets.VITAL_CELL, 200, xpos, ypos, "vitalcell", "bodypart", darkness);
			width = 65;
			height = 34;
			scale = 4;
			glowScale = 7;
		}
		
	}

}