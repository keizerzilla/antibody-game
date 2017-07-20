package gamecode {
	
	import gamecode.assets.Assets;
	import flash.display.BlendMode;
	import gamecode.player.Antibody;
	import gamecode.player.VitalCell;
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Canvas;
	import net.flashpunk.graphics.Graphiclist;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.FP;
	import net.flashpunk.Sfx;
	import net.flashpunk.utils.Ease;
	
	public class Actor extends Entity {
		
		public const UP:String = "UP";
		public const DOWN:String = "DOWN";
		public const LEFT:String = "LEFT";
		public const RIGHT:String = "RIGHT";
		public const ACTION:String = "ACTION";
		public const SHOOT:String = "SHOOT";
		public const EXPLODE:String = "EXPLODE";
		public const COLLIDABLES:Array = ["enemy", "body"];
		public const EXPLOSION_SIZE:uint = 80;
		
		private var deathSFX:Sfx = new Sfx(Assets.VIRUS_DEATH);
		
		public var stamp:Image = null;
		public var vx:Number = 0.0;
		public var vy:Number = 0.0;
		public var maxhealth:int = 1;
		public var health:int = 1;
		public var power:uint = 1;
		public var speed:Number = 1.5;
		public var rotateSpeed:Number = 3;
		public var friction:Number = 0.97;
		public var scale:Number = 2;
		public var pulse:Number = 0.0;
		public var intensitiy:int = 5;
		public var sheen:Number = 1;
		public var glow:Image = new Image(Assets.GLOW_LIGHT);
		public var darkness:Canvas = null;
		public var glowScale:Number = 1;
		
		public function Actor(ACTOR_GRAPHICS:Class, hp:int, xpos:Number, ypos:Number, actorName:String, actorType:String, darkness:Canvas = null):void {
			stamp = new Image(ACTOR_GRAPHICS);
			type = actorType;
			name = actorName;
			setHitbox(16, 16);
			centerOrigin();
			stamp.centerOrigin();
			maxhealth = health = hp;
			graphic = stamp;
			
			x = xpos;
			y = ypos;
			
			this.darkness = darkness;
			glow.blend = BlendMode.SCREEN;
			glowScale = glow.scale = scale;
			glow.centerOrigin();
		}
		
		public function takeDamage(amount:uint):void {
			// take damage animaiton here
			health -= amount;
		}
		
		// helper function
		public function degreesToRadians(degrees:Number):Number {
			return degrees * Math.PI / 180;
		}
		
		public function die():void {
			deathSFX.play(0.1);
			kill();
		}
		
		public function angleToTarget(xTarget:Number, yTarget:Number):Number {
			return FP.angle(x, y, xTarget, yTarget) - 90;
		}
		
		// move the actor to some point (x, y) with the proper rotation
		// so the actor will point towards the target
		public function rotateMovement(xTarget:Number, yTarget:Number):void {
			stamp.angle = angleToTarget(xTarget, yTarget);
			moveTowards(xTarget, yTarget, speed, COLLIDABLES);
		}
		
		// default movement function
		public function move(forwad:Boolean, rotateRight:Boolean, rotateLeft:Boolean):void {
			if (forwad) {
				vy = Math.sin(degreesToRadians(stamp.angle + 90)) * speed;
				vx = Math.cos(degreesToRadians(stamp.angle + 90)) * speed;
			} else {
				vy *= friction;
				vx *= friction;
			}
			
			if (rotateRight) {
				stamp.angle -= rotateSpeed;
			} else if (rotateLeft) {
				stamp.angle += rotateSpeed;
			}
			
			//vy = FP.sign(vy) * Math.min(speed, Math.abs(vy));
			//vx = FP.sign(vx) * Math.min(speed, Math.abs(vx));
			
			moveBy(vx, -vy, COLLIDABLES);
		}
		
		public function kill():void {
			if (this.world != null) {
				world.remove(this);
			}
		}
		
		public function chaseAntibody():void {
			var antibody:Antibody = world.getInstance("antibody") as Antibody;
			if (antibody) {
				rotateMovement(antibody.x, antibody.y);
				if (collideWith(antibody, x, y)) {
					antibody.takeDamage(power);
					die();
				}
			}
		}
		
		public function chaseVitalCell():void {
			var vitalcell:VitalCell = world.getInstance("vitalcell") as VitalCell;
			if (vitalcell) {
				rotateMovement(vitalcell.x, vitalcell.y);
				if (collideWith(vitalcell, x, y)) {
					vitalcell.takeDamage(power);
					die();
				}
			}
		}
		
		override public function update():void {
			super.update(); // calls super class update method
			if (health > 0) {
				layer = -y; // zelda-like perspective
				pulse += intensitiy; // increment pulse by pulse intensity
				pulse %= 360; // crops pulse
				stamp.scale = scale + (Math.abs(Math.sin(degreesToRadians(pulse))) * 0.35); // make it bump
				glow.scale = glowScale + 0.5;
			} else {
				die();
			}
		}
		
		override public function render():void {
			super.render();
			if (darkness) {
				darkness.drawGraphic(x, y, glow);
			}
		}
		
	}
	
}