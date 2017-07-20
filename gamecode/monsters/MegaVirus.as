package gamecode.monsters {
	
	import gamecode.Actor;
	import gamecode.assets.Assets;
	
	public class MegaVirus extends Actor {
		
		public function MegaVirus(xpos:Number, ypos:Number):void {
			super(Assets.MEGA_VIRUS_GRAPHICS, 8, xpos, ypos, "megavirus", "enemy");
			power = 8;
			intensitiy = 12;
			scale = glowScale = 4;
		}
		
		override public function update():void {
			super.update();
			chaseAntibody();
		}
		
	}

}