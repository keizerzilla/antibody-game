package gamecode.player {
	
	import gamecode.assets.Assets;
	import gamecode.Actor;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Canvas;
	
	public class Shoot extends Actor {
		
		private var angle:Number;
		
		public function Shoot(angle:Number, xpos:Number, ypos:Number, darkness:Canvas):void {
			super(Assets.SHOOT_GRAPHICS, 1, xpos, ypos, "simple_shoot", "shoot", darkness);
			this.angle = angle;
			speed = 2;
			power = 1;
			scale = glowScale = 2;
			setHitbox(12, 12);
		}
		
		override public function update():void {
			super.update();
			vy += Math.sin(degreesToRadians(angle + 90)) * speed;
			vx += Math.cos(degreesToRadians(angle + 90)) * speed;
			stamp.angle = angle;
			
			y -= vy;
			x += vx;
			
			if (collide("body", x, y)) {
				kill();
			}
			
			var enemy:Actor = collide("enemy", x, y) as Actor;
			if (enemy) {
				enemy.takeDamage(power);
				kill();
			}
			
			var tumor:Actor = collide("tumor", x, y) as Actor;
			if (tumor) {
				tumor.takeDamage(power);
				kill();
			}
		}
		
	}

}