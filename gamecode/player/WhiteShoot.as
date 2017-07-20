package gamecode.player {
	
	import gamecode.assets.Assets;
	import net.flashpunk.graphics.Canvas;
	import net.flashpunk.graphics.Image;
	
	public class WhiteShoot extends Shoot {
		
		public function WhiteShoot(angle:Number, xpos:Number, ypos:Number, darkness:Canvas):void {
			super(angle, xpos, ypos, darkness);
			stamp = new Image(Assets.WHITE_SHOOT);
		}
		
	}

}