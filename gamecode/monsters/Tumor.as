package gamecode.monsters {
	
	import gamecode.Actor;
	import gamecode.assets.Assets;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Canvas;
	import net.flashpunk.graphics.Graphiclist;
	import net.flashpunk.graphics.Image;
	
	public class Tumor extends Actor {
		
		public static const MINOR_VIRUS:int = 2;
		public static const PURPLUS:int = 3;
		public static const GRAND_VIRUS:int = 8;
		public static const MEGA_VIRUS:int = 30;
		
		public var lifebar:Image;
		private var time:Number = 0;
		private var minionType:int;
		
		public function Tumor(minionType:int, xpos:Number, ypos:Number, darkness:Canvas):void {
			super(Assets.TUMOR_GRAPHICS, 200, xpos, ypos, "tumor", "tumor", darkness);
			scale = 3;
			this.minionType = minionType;
			setHitbox(37, 37);
			
			lifebar = Image.createRect(width * scale * (health / maxhealth), 5, 0xFF0000);
			lifebar.centerOrigin();
			lifebar.relative = false;
			lifebar.x = x;
			lifebar.y = y - height - 15;
			graphic = new Graphiclist(stamp, lifebar);
		}
		
		public function spawnMinion():void {
			switch(minionType) {
				case MINOR_VIRUS:
					world.add(new MinorVirus(x, y));
					break;
				case PURPLUS:
					world.add(new Purplus(x, y, darkness));
					break;
				case GRAND_VIRUS:
					world.add(new GrandVirus(x, y, darkness));
					break;
				case MEGA_VIRUS:
					world.add(new MegaVirus(x, y));
					break;
			}
		}
		
		public function updateTimer():void {
			time += FP.elapsed;
			if (time >= minionType) {
				time -= minionType;
				spawnMinion();
			}
		}
		
		override public function update():void {
			super.update();
			updateTimer();
			
			stamp.angle += 0.3;
			lifebar.clipRect.width = width * scale * (health / maxhealth);
			lifebar.clear();
			lifebar.updateBuffer();
			lifebar.x = x;
			lifebar.y = y - height;
		}
		
	}

}