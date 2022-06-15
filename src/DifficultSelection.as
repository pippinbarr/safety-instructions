package
{
	import flash.events.*;
	import flash.text.*;
	
	import org.flixel.*;
	
	public class DifficultSelection extends FlxState
	{
		
		private var _animation:FlxSprite;
		
		private var _difficultyText:TextField;
		private var _difficultyTextFormat:TextFormat;
		
		private var _menuFormat:TextFormat = new TextFormat("Silkscreen",24,0x000000,null,null,null,null,null,"center",null,null,null,null);
		private var _bad:TextField;
		private var _good:TextField;
		private var _nightmare:TextField;
		
		private var _upperText:TextField;
		private var _lowerText:TextField;
		private var _textFormat:TextFormat = new TextFormat("Silkscreen",24,0x000000,null,null,null,null,null,"center",null,null,null,null);
		private var _textTimer:FlxTimer;
		private var _texts:Array = new Array(
			"UH... FOLKS, I DON'T WANT TO ALARM YOU...",
			"BUT YOU NEED TO BUCKLE UP RIGHT NOW!\n\n(PRESS SPACE)");
		private var _currentTextIndex:uint = 0;
		private var _removeSettings:Boolean = false;
		
		private var _announceSound:FlxSound;

		
		public function DifficultSelection()
		{
			super();
		}
		
		public override function create():void {
			
			FlxG.mouse.hide();
			FlxG.bgColor = 0;
			
			_announceSound = new FlxSound();
			_announceSound.loadEmbedded(Assets.AnnounceSnd);

			_textTimer = new FlxTimer();
			
			_animation = new FlxSprite(0,0);
			_animation.loadGraphic(Assets.IntroductionSheet,true,false,Assets._introWidth,Assets._introHeight);
			_animation.addAnimation("takeoff",Assets._introPartTwoFrames,8,true);
			_animation.addAnimation("turbulence",Assets._introPartThreeFrames,8,true);
			_animation.play("takeoff");
			add(_animation);
			
			_upperText = Helpers.makeTextField(50,50,(Assets._crashWidth * 8) - 100,800,_texts[0],_textFormat);
			_lowerText = Helpers.makeTextField(50,260,(Assets._crashWidth * 8) - 100,800,_texts[1],_textFormat);
			
			_bad = Helpers.makeTextField(0,300,(Assets._crashWidth * 8),20,"(B)AD!",_menuFormat);
			_good = Helpers.makeTextField(0,320,(Assets._crashWidth * 8),20,"(G)OOD!",_menuFormat);
			if (GameState._nightmareUnlocked) _nightmare = Helpers.makeTextField(0,340,(Assets._crashWidth * 8),20,"I'M YOUR WORST (N)IGHTMARE!",_menuFormat);

			FlxG.stage.addChild(_bad);
			FlxG.stage.addChild(_good);
			if (_nightmare != null) FlxG.stage.addChild(_nightmare);
			
			_bad.visible = false;
			_good.visible = false;
			if (_nightmare != null) _nightmare.visible = false;
			
			_textTimer.start(1,1,displayDifficultySettings);
			
		}
		
		public override function update():void {
			super.update();	
		}
		
		private function displayText(timer:FlxTimer):void {
			_announceSound.play();
			FlxG.stage.addChild(_upperText);
			FlxG.stage.addChild(_lowerText);
			FlxG.stage.addEventListener(KeyboardEvent.KEY_UP,difficultyKeyUp);
		}
		
		private function nextStage(timer:FlxTimer):void {
			FlxG.switchState( new BuckleStage() );
		}
		
		public function difficultyKeyUp(e:KeyboardEvent):void {
			
			if (e.keyCode == 32) {
				FlxG.stage.removeEventListener(KeyboardEvent.KEY_UP, difficultyKeyUp);
				_upperText.text = "";
				_lowerText.text = "";
					_textTimer.start(1,1,nextStage);
			}
		}
		
		private function displayPostDifficultySelection(timer:FlxTimer):void {
			
			_bad.visible = false;
			_good.visible = false;
			if (_nightmare != null) _nightmare.visible = false;
			
			FlxG.stage.removeChild(_difficultyText);
			
			_textTimer.start(2,1,displayText);
			
			_animation.play("turbulence");
		}
		
		private function playGame(timer:FlxTimer):void {
			FlxG.switchState( new BuckleStage() );
		}
		
		private function easyButtonPressed():void {
			GameState._difficultyLevel = 0;
			displayPostDifficultySelection(null);
		}
		
		private function normalButtonPressed():void {
			GameState._difficultyLevel = 1;
			displayPostDifficultySelection(null);
		}
		
		private function nightmareButtonPressed():void {
			GameState._difficultyLevel = 2;
			displayPostDifficultySelection(null);
		}
		
		private function displayDifficultySettings(timer:FlxTimer):void {
			
			_difficultyText = new TextField();
			_difficultyTextFormat = new TextFormat("Silkscreen",32,0x000000,null,null,null,null,null,"center",null,null,null,null);
			_difficultyText.defaultTextFormat = _difficultyTextFormat;
			_difficultyText.x = 50; _difficultyText.y = 220;
			_difficultyText.width = (_animation.frameWidth * 8) - 100;
			_difficultyText.height = (_animation.frameHeight * 8) - 100;
			_difficultyText.wordWrap = true;
			_difficultyText.selectable = false;
			_difficultyText.embedFonts = true;
			_difficultyText.text = "HOW GOOD ARE YOU AT THIS KIND OF THING?";
			
			FlxG.stage.addChild(_difficultyText);
			
			_bad.visible = true;
			_good.visible = true;
			if (_nightmare != null) _nightmare.visible = true;
			
			FlxG.stage.addEventListener(KeyboardEvent.KEY_UP,keyUp);
			
		}
		
		private function keyUp(e:KeyboardEvent):void {
			
			if (e.keyCode == 66 || e.keyCode == 71 || (_nightmare != null && e.keyCode == 78)) {
				FlxG.stage.removeEventListener(KeyboardEvent.KEY_UP,keyUp);
			}
			
			if (e.keyCode == 66) easyButtonPressed();
			else if (e.keyCode == 71) normalButtonPressed();
			else if (_nightmare != null && e.keyCode == 78) nightmareButtonPressed();
		}
		
		public override function destroy():void {
			
			FlxG.stage.removeChild(_bad);
			FlxG.stage.removeChild(_good);
			if (_nightmare != null) FlxG.stage.removeChild(_nightmare);
			
			FlxG.stage.removeChild(_upperText);
			FlxG.stage.removeChild(_lowerText);
			
			_textTimer.destroy();
			_animation.destroy();
			
			FlxG.stage.focus = null;
			
			_announceSound.destroy();
			
			super.destroy();
			
		}
	}
}