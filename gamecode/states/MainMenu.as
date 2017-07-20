package gamecode.states {
	
	import flash.events.TextEvent;
	import flash.geom.Rectangle;
	import gamecode.monsters.GrandVirus;
	import gamecode.monsters.MegaVirus;
	import gamecode.monsters.MinorVirus;
	import gamecode.monsters.Purplus;
	import gamecode.player.WhiteGlobulus;
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Canvas;
	import net.flashpunk.graphics.Text;
	import net.flashpunk.World;
	import net.flashpunk.FP;
	import net.flashpunk.utils.Key;
	import net.flashpunk.utils.Input;
	import flash.display.BlendMode;
	
	public class MainMenu extends World {
		
		private var darkness:Canvas;
		private var purplus:Purplus;
		private var minorvirus:MinorVirus;
		private var grandvirus:GrandVirus;
		private var megavirus:MegaVirus;
		
		private var title:Text = new Text("#ANTIBODY");
		private var subtitle:Text = new Text("A inner world game by KeizerZilla\nProtect the Cell until the medicine arrives!");
		private var commands:Text = new Text("MOVE >> WASD or ARROWS\nSHOOT >> K or Z\nTURRET >> L or X");
		private var start:Text = new Text("PRESS [ENTER] TO KILL THE VIRUSES!");
		
		public function MainMenu():void {
			title.size = 96;
			title.x = (FP.screen.width - title.width) / 2;
			title.y = 50;
			addGraphic(title);
			
			subtitle.size = 32;
			subtitle.x = (FP.screen.width - subtitle.width) / 2;
			subtitle.y = 160;
			addGraphic(subtitle);
			
			commands.size = 22;
			commands.x = (FP.screen.width - commands.width) / 2;
			commands.y = 450;
			addGraphic(commands);
			
			start.size = 32;
			start.x = (FP.screen.width - start.width) / 2;
			start.y = 540;
			addGraphic(start);
			
			darkness = new Canvas(FP.width, FP.height);
			darkness.blend = BlendMode.MULTIPLY;
			var darknessEntity:Entity = new Entity(0, 0, darkness);
			add(darknessEntity);
			
			add(new WhiteGlobulus(40, 40, darkness));
			addGraphic(new Text(" TURRET\n8 SHOOTS", 5, 55));
			
			minorvirus = new MinorVirus(100, 300);
			add(minorvirus);
			addGraphic(new Text("CHASES YOU", 85, 380));
			
			purplus = new Purplus(250, 300, darkness);
			add(purplus);
			addGraphic(new Text("CHASES CELL", 235, 380));
			
			grandvirus = new GrandVirus(400, 300, darkness);
			add(grandvirus);
			addGraphic(new Text("CHASES CELL", 385, 380));
			
			megavirus = new MegaVirus(550, 300);
			add(megavirus);
			addGraphic(new Text("CHASES YOU", 535, 380));
		}
		
		override public function update():void {
			super.update();
			if (Input.check(Key.ENTER)) {
				FP.world = new GameState();
			}
			
			minorvirus.move(true, true, true);
			purplus.move(true, true, true);
			grandvirus.move(true, true, true);
			megavirus.move(true, true, true);
		}
		
		override public function render():void {
			super.render();
			darkness.fill(new Rectangle(0, 0, FP.width, FP.height), 0xff000000, 0.5);
		}
		
	}

}