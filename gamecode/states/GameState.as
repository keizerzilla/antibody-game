package gamecode.states {
	
	import flash.display.BlendMode;
	import flash.geom.Rectangle;
	import gamecode.Actor;
	import gamecode.assets.Assets;
	import gamecode.player.Antibody;
	import gamecode.assets.Body;
	import gamecode.monsters.Tumor;
	import gamecode.player.VitalCell;
	import gamecode.player.WhiteGlobulus;
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Canvas;
	import net.flashpunk.graphics.Text;
	import net.flashpunk.Sfx;
	import net.flashpunk.World;
	import net.flashpunk.FP;
	import net.flashpunk.utils.Input;
	import net.flashpunk.utils.Key;
	
	public class GameState extends World {
		
		private const tumorOffSet:int = 180;
		private const clock:int = 180;
		private const tileWidth:int = 80;
		private const tileHeight:int = 60;
		private const darknessLayer:int = -10000000;
		private const uiLayer:int = -100000001;
		
		private var hasFinished:Boolean = false;
		private var pulse:Number = 0;
		private var intensity:int = 1;
		private var alphaDarkness:Number = 0;
		
		private var width:int = 32 * tileWidth;
		private var height:int = 32 * tileHeight;
		
		private var darkness:Canvas;
		private var vitalcell:VitalCell;
		private var body:Body;
		private var antibody:Antibody;
		
		private var minorVirusTumor:Tumor;
		private var purplusTumor:Tumor;
		private var grandVirusTumor:Tumor;
		private var megaVirusTumor:Tumor;
		
		private var factor:Number = 0;
		private var minutes:int;
		private var seconds:int;
		private var timer:Number;
		
		private var time:Text;
		private var antibodyHP:Text;
		private var vitalcellHP:Text;
		private var finalMessage:Text;
		private var wglobulus:Text;
		
		private var backgroundSFX:Sfx;
		private var gameoverSFX:Sfx;
		
		public function GameState():void {
			darkness = new Canvas(width, height);
			darkness.blend = BlendMode.MULTIPLY;
			addGraphic(darkness, uiLayer);
			//var darknessEntity:Entity = new Entity(0, 0, darkness);
			//darknessEntity.layer = darknessLayer; // very depth!
			
			minorVirusTumor = new Tumor(Tumor.MINOR_VIRUS, tumorOffSet, tumorOffSet, darkness);
			purplusTumor = new Tumor(Tumor.PURPLUS, width - tumorOffSet, tumorOffSet, darkness);
			grandVirusTumor = new Tumor(Tumor.GRAND_VIRUS, tumorOffSet, height - tumorOffSet, darkness);
			megaVirusTumor = new Tumor(Tumor.MEGA_VIRUS, width - tumorOffSet, height - tumorOffSet, darkness);
			
			body = new Body(width, height);
			antibody = new Antibody((width / 2) - 8, (height / 2) + 32, darkness);
			vitalcell = new VitalCell((width / 2 - 32.5), (height / 2) - 17, darkness);
			
			timer = clock; // THE CLOCK!
			
			time = new Text("MEDICINE IN 00:00");
			time.size = 24;
			time.scrollX = time.scrollY = 0;
			addGraphic(time, uiLayer, FP.width - time.width, 0);
			
			antibodyHP = new Text("ANTIBODY: " + antibody.health + "/" + antibody.maxhealth);
			antibodyHP.size = 24;
			antibodyHP.scrollX =  antibodyHP.scrollY = 0;
			addGraphic(antibodyHP, uiLayer, 0, 25);
			
			vitalcellHP = new Text("VITALCELL: " + vitalcell.health);
			vitalcellHP.size = 24;
			vitalcellHP.scrollX = vitalcellHP.scrollY = 0;
			addGraphic(vitalcellHP, uiLayer, 0, 0);
			
			wglobulus = new Text("WHITE GLOBULES: " + Antibody.MAX_WHITE_GLOBULUS);
			wglobulus.size = 24;
			wglobulus.scrollX = wglobulus.scrollY = 0;
			addGraphic(wglobulus, uiLayer, FP.width - wglobulus.width, 25);
			
			finalMessage =  new Text("");
			finalMessage.size = 32;
			finalMessage.scrollX = finalMessage.scrollY = 0;
			
			add(body);
			add(antibody);
			add(vitalcell);
			
			add(minorVirusTumor);
			add(purplusTumor);
			add(grandVirusTumor);
			add(megaVirusTumor);
			
			addGraphic(finalMessage);
			
			gameoverSFX = new Sfx(Assets.GAME_OVER_SFX);
			backgroundSFX = new Sfx(Assets.BACKGROUND_MUSIC);
			backgroundSFX.loop();
		}
		
		public function updateCamera():void {
			FP.camera.x = (antibody.x - (FP.halfWidth - antibody.width));
			FP.camera.y = (antibody.y - (FP.halfHeight - antibody.height));
			FP.camera.x = FP.clamp(FP.camera.x, 0, width - FP.width);
			FP.camera.y = FP.clamp(FP.camera.y, 0, height - FP.height);
		}
		
		public function updateDarkness():void {
			/*pulse += intensity;
			pulse %= 360;
			alphaDarkness = factor + Math.abs(Math.sin(pulse * Math.PI / 180));*/
			alphaDarkness = 0.7;
		}
		
		public function leadingZero(number:int):String {
			if (number < 10) {
				return "0" + number;
			} else {
				return "" + number;
			}
		}
		
		public function killAllEnemies():void {
			var enemies:Array = [];
			FP.world.getType("enemy", enemies);
			for each(var e:Actor in enemies) {
				e.die();
			}
			
			var tumores:Array = [];
			FP.world.getType("tumor", tumores);
			for each(var t:Actor in tumores) {
				t.die();
			}
		}
		
		public function updateUIElements():void {
			timer -= FP.elapsed;
			minutes = (timer / 60) % 60;
			seconds = timer % 60;
			
			time.text = "MEDICINE IN " + leadingZero(minutes) + ":" + leadingZero(seconds);
			antibodyHP.text = "ANTIBODY: " + antibody.health + "/" + antibody.maxhealth;
			vitalcellHP.text = "VITALCELL: " + vitalcell.health;
			wglobulus.text = "WHITE GLOBULES: " + (Antibody.MAX_WHITE_GLOBULUS - this.classCount(WhiteGlobulus));
		}
		
		public function setFinalMessage(message:String):void {
			finalMessage.text = message + "\n press <ENTER> to restart";
			finalMessage.x = FP.halfWidth - finalMessage.width / 2;
			finalMessage.y = 75;
			factor = -1.0;
			hasFinished = true;
		}
		
		public function updateGameLogic():void {
			if (timer <= 0) {
				killAllEnemies();
				vitalcellHP.text = "VITALCELL: =D";
				antibodyHP.text = "ANTIBODY: =D";
				setFinalMessage("YOU SAVED THIS BODY!");
				
				backgroundSFX.stop();
				gameoverSFX.play(0.5);
			}
			
			if (vitalcell.health <= 0 || antibody.health <= 0) {
				vitalcellHP.text = "VITALCELL: DEAD";
				antibodyHP.text = "ANTIBODY: DEAD";
				antibody.die();
				setFinalMessage("THE DEATH HAS COME...");
				
				backgroundSFX.stop();
				gameoverSFX.play(0.5);
			}
		}
		
		public function renderDarkness():void {
			darkness.fill(new Rectangle(0, 0, width, height), 0xff000000, alphaDarkness);
		}
		
		override public function update():void {
			super.update();
			updateCamera();
			updateDarkness();
			updateUIElements();
			updateGameLogic();
			
			if (hasFinished) {
				if (Input.pressed(Key.ENTER)) {
					removeAll();
					FP.world = new GameState();
				}
			}
		}
		
		override public function render():void {
			super.render();
			renderDarkness();
		}
		
	}

}