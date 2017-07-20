package gamecode.player {
	
	import gamecode.assets.Assets;
	import gamecode.Actor;
	import net.flashpunk.graphics.Canvas;
	import net.flashpunk.Sfx;
	import net.flashpunk.utils.Input;
	import net.flashpunk.utils.Key;
	import net.flashpunk.FP;
	
	public class Antibody extends Actor {
		
		public static const MAX_WHITE_GLOBULUS:int = 5;
		
		private var shootSFX:Sfx =  new Sfx(Assets.ANTIBODY_SHOOT);
		
		public function Antibody(xpos:Number, ypos:Number, darkness:Canvas):void {
			super(Assets.ANTIBODY_GRAPHICS, 20, xpos, ypos, "antibody", "antibody", darkness);
			speed = 3;
			scale = 2;
			
			Input.define(UP, Key.UP, Key.W);
			Input.define(DOWN, Key.DOWN, Key.S);
			Input.define(LEFT, Key.LEFT, Key.A);
			Input.define(RIGHT, Key.RIGHT, Key.D);
			Input.define(SHOOT, Key.Z, Key.K);
			Input.define(ACTION, Key.X, Key.L);
		}
		
		public function restoreHealth():void {
			health += 2;
			if (health > maxhealth) {
				health = maxhealth;
			}
		}
		
		public function actionInput():void {
			if (Input.pressed(SHOOT)) {
				world.add(new Shoot(stamp.angle, x, y, darkness));
				shootSFX.play(0.2);
			}
			if (Input.pressed(ACTION)) {
				var wglobulusCount:int = world.classCount(WhiteGlobulus);
				if (wglobulusCount < MAX_WHITE_GLOBULUS) {
					world.add(new WhiteGlobulus(x, y, darkness));
				}
			}
		}
		
		override public function update():void {
			super.update();
			move(Input.check(UP), Input.check(RIGHT), Input.check(LEFT));
			actionInput();
		}
		
	}

}