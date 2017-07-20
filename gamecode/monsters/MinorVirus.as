package gamecode.monsters {
	
	import gamecode.assets.Assets;
	import gamecode.Actor;
	import gamecode.player.RedGlobulus;
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Canvas;
	
	// the most common viruses, they chase the antibody until death!
	public class MinorVirus extends Actor {
		
		public function MinorVirus(xpos:Number, ypos:Number):void {
			super(Assets.MINOR_VIRUS_GRAPHICS, 2, xpos, ypos, "minor_virus", "enemy");
			power = 3;
			intensitiy = 18;
		}
		
		override public function die():void {
			super.die();
			world.add(new RedGlobulus(x, y, darkness));
		}
		
		override public function update():void {
			super.update();
			chaseAntibody();
		}
		
	}

}