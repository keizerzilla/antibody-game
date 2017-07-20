package gamecode.monsters {
	
	import gamecode.Actor;
	import gamecode.assets.Assets;
	import net.flashpunk.graphics.Canvas;
	
	public class GrandVirus extends Actor {
		
		public function GrandVirus(xpos:Number, ypos:Number, darkness:Canvas):void {
			super(Assets.GRAND_VIRUS_GRAPHICS, 6, xpos, ypos, "grandvirus", "enemy", darkness);
			power = 6;
			intensitiy = 29;
			scale = glowScale = 3;
		}
		
		override public function update():void {
			super.update();
			chaseVitalCell();
		}
		
	}

}