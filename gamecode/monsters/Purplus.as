package gamecode.monsters {
	
	import gamecode.Actor;
	import gamecode.assets.Assets;
	import net.flashpunk.graphics.Canvas;
	
	public class Purplus extends Actor {
		
		public function Purplus(xpos:Number, ypos:Number, darkness:Canvas):void {
			super(Assets.PURPLUS_GRAPHICS, 6, xpos, ypos, "purplus", "enemy", darkness);
			power = 5;
			intensitiy = 12;
		}
		
		override public function update():void {
			super.update();
			chaseVitalCell();
		}
		
	}

}