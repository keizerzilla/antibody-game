package gamecode.player {
	
	import gamecode.Actor;
	import gamecode.assets.Assets;
	import net.flashpunk.graphics.Canvas;
	
	public class RedGlobulus extends Actor {
		
		public function RedGlobulus(xpos:Number, ypos:Number, darkness:Canvas):void {
			super(Assets.RED_GLOBULUS_GRAPHICS, 1, xpos, ypos, "red_globulus", "ally", darkness);
		}
		
		override public function update():void {
			super.update();
			var antibody:Antibody = collide("antibody", x, y) as Antibody;
			if (antibody) {
				antibody.restoreHealth();
				die();
			}
		}
		
	}

}