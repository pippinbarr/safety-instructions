package
{
	import flash.events.*;
	import flash.text.*;
	import flash.utils.getDefinitionByName;
	
	import org.flixel.*;
	
	public class PostPlay extends FlxState
	{
		
		private var _bg:FlxSprite;
		
		private var _informationText:TextField;
		private var _informationTextFormat:TextFormat = new TextFormat("Silkscreen",40,0x000000,null,null,null,null,null,"center",null,null,null,null);
		
		private var _gameOverText:TextField;
		private var _gameOverTextFormat:TextFormat = new TextFormat("Silkscreen",42,0xFF0000,null,null,null,null,null,"center",null,null,null,null);
		private var _gameOverExplanationText:TextField;
		private var _gameOverExplanationTextFormat:TextFormat = new TextFormat("Silkscreen",18,0x000000,null,null,null,null,null,"center",null,null,null,null);
		
		
		private var _animation:FlxSprite;
		
		private var _menuFormat:TextFormat = new TextFormat("Silkscreen",24,0x000000,null,null,null,null,null,"center",null,null,null,null);
		private var _menuInactiveFormat:TextFormat = new TextFormat("Silkscreen",24,0x999999,null,null,null,null,null,"center",null,null,null,null);
		private var _retry:TextField;
		private var _main:TextField;
		private var _new:TextField;
		
		private var _animationOffset:uint = 0;
		
		private var _announceSound:FlxSound;
		
		private var _timer:FlxTimer;
		
		private var _transitioning:Boolean = false;
		
		public function PostPlay() {
			super();
		}
		
		
		
		public override function create():void {
			
			FlxG.mouse.hide();
			FlxG.bgColor = 0;
			
			_timer = new FlxTimer();
			
			Assets._themeSong.pause();
			
			_announceSound = new FlxSound();
			_announceSound.loadEmbedded(Assets.AnnounceSnd);
			
			// DO SOME DEEPLY CRAZY SHIT TO GET THE POSTPLAY ANIMATION TO START AT THE RIGHT
			// POINT IN THE LOOP
			_animation = Globals._finalAnimation;
			if (_animation.frameWidth == 50) _animationOffset = 12;
			_animation.x += _animationOffset;
			var startFrameIndex:uint = Globals._finalAnimationFrames.indexOf(Globals._finalAnimationStartFrame);
			var tempFrames:Array = Globals._finalAnimationFrames.splice(0,startFrameIndex);
			for (var i:uint = 0; i < tempFrames.length; i++) {
				Globals._finalAnimationFrames.push(tempFrames[i]);
			} 
			_animation.addAnimation("postloop",Globals._finalAnimationFrames,6,true);
			_animation.play("postloop");
			add(_animation);
			
			// ADD THE ALPHAED BACKGROUND TO MAKE TEXT MORE VISIBLE
			_bg = new FlxSprite(0,0);
			_bg.x += _animationOffset;
			_bg.makeGraphic(FlxG.stage.width,FlxG.stage.height,0xBBFFFFFF);
			
			add(_bg);
			
			// Set up "completion" variables
			if (
				GameState._currentStageName == "SignalStage" && 
				Globals._winner && 
				!GameState._bonusUnlocked) {
				
				GameState._bonusUnlocked = true;
				Globals._firstTimeBonus = true;
				
			}
			else if (
				GameState._currentStageName == "SignalStage" && 
				Globals._winner && 
				GameState._bonusUnlocked && 
				!GameState._nightmareUnlocked) {
				
				GameState._nightmareUnlocked = true;
				Globals._firstTimeNightmare = true;
			}
			
			_informationText = Helpers.makeTextField((_animationOffset * 8), 25, (_animation.frameWidth * 8), (_animation.height * 8), "", _informationTextFormat);
			_gameOverText = Helpers.makeTextField(25 + (_animationOffset * 8), 50, (_animation.frameWidth * 8) - 50, (_animation.height * 8) - 50, "", _gameOverTextFormat);
			_gameOverExplanationText = Helpers.makeTextField(25 + (_animationOffset * 8), 100, (_animation.frameWidth * 8) - 50, (_animation.height * 8) - 50, "", _gameOverExplanationTextFormat);
			
			
			// NOW CONSTRUCT THE INFORMATION TEXT
						
			if (!Globals._winner) {
				if (GameState._currentStageName != "LostStage") {
					// They died in the course of the game
					_informationText.appendText("YOU'RE DEAD.\nSO SAD.\n\n");
					if (!GameState._inflateSuccess && (GameState._currentStageName == "DodgeStage" || GameState._currentStageName == "WhistleStage")) _gameOverExplanationText.appendText("INFLATE YOUR LIFE JACKET THIS TIME.\n\n");
				}
				else {
					// They finished on nightmare mode
					_informationText.appendText("GAME OVER");
					_gameOverExplanationText.appendText("BUT ONLY BECAUSE YOU TOTALLY WHIPPED ITS ASS.\n\nTHANKS FOR PLAYING!");
				}
			}
			else if (Globals._firstTimeBonus) {
				// They won the normal game and unlocked the bonus levels
				_informationText.appendText("GAME NOT OVER");
				_gameOverExplanationText.appendText("BONUS STAGES UNLOCKED!\nSTART A NEW GAME TO PLAY THEM!");
				Globals._firstTimeBonus = false;
			}
			else if (Globals._firstTimeNightmare) {
				// They won the bonus game and unlocked the nightmare mode
				_informationText.appendText("GAME NOT OVER");
				_gameOverExplanationText.appendText("NIGHTMARE DIFFICULTY MODE UNLOCKED!\nSTART A NEW GAME TO TRY IT OUT!");
				Globals._firstTimeNightmare = false;
			}
			else {
				// They won the normal/bonus game again (for some reason not on nightmare)
				_informationText.appendText("GAME NOT OVER");
				_gameOverExplanationText.appendText("MAYBE YOU SHOULD TRY NIGHTMARE MODE...");
			}
			
			
			// Now construct the menu
			if (GameState._currentStageName == "LostStage" || (GameState._currentStageName == "SignalStage" && Globals._winner)) {
				_retry = Helpers.makeTextField(_animationOffset*8,300,(_animation.frameWidth * 8),20,"(R)ETRY",_menuInactiveFormat);
				_new = Helpers.makeTextField(_animationOffset*8,320,(_animation.frameWidth * 8),20,"(N)EW GAME",_menuFormat);
			}
			else {
				_retry = Helpers.makeTextField(_animationOffset*8,320,(_animation.frameWidth * 8),20,"(R)ETRY",_menuFormat);
			}
			
			_main = Helpers.makeTextField(_animationOffset*8,340,(_animation.frameWidth * 8),20,"(M)AIN MENU",_menuFormat);
			
			
			FlxG.stage.addChild(_informationText);
			FlxG.stage.addChild(_gameOverExplanationText);
			FlxG.stage.addChild(_retry);
			FlxG.stage.addChild(_main);
			if ((GameState._currentStageName == "SignalStage" && Globals._winner)) {
				FlxG.stage.addChild(_new);
			}			
			_announceSound.play();
			
			FlxG.stage.addEventListener(KeyboardEvent.KEY_UP,keyUp);	
		}
		
		public override function update():void {
			
			super.update();
						
			if (GameState._currentStageName == "BuckleStage" || GameState._currentStageName == "BreatheStage" || GameState._currentStageName == "AssistStage" || GameState._currentStageName == "BraceStage") {
				FlxG.shake(0.01,60);
			}
			
		}
		
		
		private function gotoStartScreen(t:FlxTimer):void {
			GameState.flush();
			FlxG.switchState(new StartScreen() );		
		}
		
		private function newGame(t:FlxTimer):void {
			GameState.flush();
			FlxG.switchState(new DifficultSelection);
		}
		
		private function retryPreviousLevel(t:FlxTimer):void {
			if ((GameState._currentStageName != "DodgeStage" && GameState._currentStageName != "WhistleStage") || GameState._inflateSuccess) { 
				var PreviousStage:Class = Class(getDefinitionByName(GameState._currentStageName));
				FlxG.switchState(new PreviousStage());
			}
			else {
				FlxG.switchState(new InflateStage());
			}
		}
		
		private function keyUp(e:KeyboardEvent):void {
			
			if (e.keyCode == 77 || (e.keyCode == 78 && (GameState._currentStageName == "SignalStage" && Globals._winner)) || (e.keyCode == 82 && (GameState._currentStageName != "LostStage" && !(GameState._currentStageName == "SignalStage" && Globals._winner)))) {
				FlxG.stage.removeEventListener(KeyboardEvent.KEY_UP,keyUp);
				FlxG.stage.removeChild(_informationText);
				if (_gameOverExplanationText.text != null) {
					FlxG.stage.removeChild(_gameOverExplanationText);
				}
				if (GameState._currentStageName == "SignalStage" && Globals._winner) {
					FlxG.stage.removeChild(_new);
				}
				FlxG.stage.removeChild(_retry);
				FlxG.stage.removeChild(_main);
			}
			if ((e.keyCode == 82 && (GameState._currentStageName != "LostStage" && !(GameState._currentStageName == "SignalStage" && Globals._winner)))) {
				// R, so RETRY
				_timer.start(1,1,retryPreviousLevel);

			}
			else if (e.keyCode == 77) {
				// M for Main Menu
				if (GameState._currentStageName == "LostStage" || (GameState._currentStageName == "SignalStage" && Globals._winner)) {
					GameState._currentStageName = null;
				}
				_timer.start(1,1,gotoStartScreen);
			}
			else if (e.keyCode == 78) {
				// N for New Game
				if ((GameState._currentStageName == "SignalStage" && Globals._winner)) {
					GameState._currentStageName = null;
					_timer.start(1,1,newGame);
				}
			}
		}
		
		
		
		public override function destroy():void {
												
			_informationText = null;
			
			_bg.destroy();
			
			_animation.destroy();
			
			_timer.destroy();
			
			FlxG.stage.focus = null;
			
			super.destroy();
			
		}
		
		public override function kill():void {
			
			_bg.kill();

			
			super.kill();
		}
	}
}