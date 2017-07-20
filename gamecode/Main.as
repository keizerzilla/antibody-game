package gamecode {
	
	[Frame(factoryClass = "Preloader")]
	
	import gamecode.states.MainMenu;
	import net.flashpunk.Engine;
	import net.flashpunk.FP;
	
	public class Main extends Engine {
		
		public function Main():void {
			super(760, 580, 60, false);
			FP.world = new MainMenu();
			FP.screen.color = 0x5E01C6;
		}
		
	}
	
}