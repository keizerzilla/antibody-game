package gamecode.player {
	
	import gamecode.Actor;
	import gamecode.assets.Assets;
	import net.flashpunk.graphics.Canvas;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Graphiclist;
	import net.flashpunk.graphics.Text;
	import net.flashpunk.Sfx;
	
	public class WhiteGlobulus extends Actor {
		
		public static const ATTACK_RADIUS:Number = 200;
		public static const SHOOT_DELAY:Number = 1.5;
		public static const MAX_SHOOTS:int = 8;
		
		private var shootTimer:Number = 0;
		private var shootCount:int = 0;
		private var shootSFX:Sfx = new Sfx(Assets.WHITE_GLOBULE_SHOOT);
		
		public function WhiteGlobulus(xpos:Number, ypos:Number, darkness:Canvas):void {
			super(Assets.WHITE_GLOBULUS_GRAPHICS, 4, xpos, ypos, "white_globulus", "ally", darkness);
			glowScale = 5;
		}
		
		override public function update():void {
			super.update();
			
			shootTimer += FP.elapsed;
			if (shootTimer >= SHOOT_DELAY) {
				shootSFX.play(0.2);
				for (var shootAngle:Number = 0; shootAngle <= 360; shootAngle += 45) {
					world.add(new Shoot(shootAngle, x, y, darkness));
				}
				shootTimer = 0;
				shootCount++;
			}
			
			if (collide("enemy", x, y) || shootCount == MAX_SHOOTS) {
				die();
			}
		}
		
	}

}