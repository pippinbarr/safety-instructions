package
{
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.text.*;
	
	import org.flixel.*;
	
	public class Introduction extends FlxState
	{
		private const FRAMERATE:int = 6;	
		private const TEXT_DELAY:Number = 0.5;
		
		// INTRO ANIMATIONS
		
		private var _animations:FlxSprite;
		
		// INTRO TEXT FIELDS
		
		private var _upperText:TextField;
		private var _lowerText:TextField;
		private var _textFormat:TextFormat = new TextFormat("Silkscreen",24,0x000000,null,null,null,null,null,"center",null,null,null,null);
		private var _titleFormat:TextFormat = new TextFormat("Silkscreen",36,0x000000,null,null,null,null,null,"center",null,null,null,null);
		
		private var _introTextTimer:FlxTimer;
		private var _introTextTimerRunning:Boolean = false;
		
		private var _titleDisplayed:Boolean = false;
		
		// INTRO TEXTS
				
		private var _currentTextIndex:int = 0;
		
		private var _partOneTexts:Array = new Array("LADIES AND GENTLEMEN, THIS IS YOUR CAPTAIN SPEAKING. I'D LIKE TO WELCOME YOU ABOARD ON BEHALF OF THE CREW AND MYSELF.\n\n(press space)",
			"IT'S A PERFECT DAY FOR FLYING AND I'M VERY PLEASED TO BE WITH YOU, SO I HOPE YOU'LL SIT BACK, RELAX, AND ENJOY.\n\n(press space)",
			"CABIN CREW, PREPARE THE CABIN FOR TAKEOFF.\n\n(press space)");		
				

		// TUTORIAL VARIABLES
		
		private var _resultTimer:FlxTimer;
		private var _resultTimerStarted:Boolean = false;
		
		private var _tutorialText:TextField;
		private var _tutorialTextFormat:TextFormat = new TextFormat("Silkscreen",20,0x000000,null,null,false,null,null,"center",null,null,null,null);
		private var _inputTextFormat:TextFormat = new TextFormat("Silkscreen",20,0x00FF00,null,null,false,null,null,"center",null,null,null,null);
		private var _highlightTextFormat:TextFormat = new TextFormat("Silkscreen",20,0x000000,null,null,true,null,null,"center",null,null);
		private var _failTextFormat:TextFormat = new TextFormat("Silkscreen",20,0xFF0000,null,null,false,null,null,"center",null,null,null,null);
		private var _resultText:TextField;
		private var _resultTextFormat:TextFormat = new TextFormat("Silkscreen",70,0x000000,null,null,null,null,null,"center",null,null,null,null);
		private var _continueText:TextField;
		private var _continueTextFormat:TextFormat = new TextFormat("Silkscreen",32,0x000000,null,null,null,null,null,"center",null,null,null,null);
		private var _currentInputIndex:int = 0;
				
		private var _currentAnimation:String = "";
		
		protected var _bg:FlxSprite;

		
		private var _timer:FlxTimer;
		
		private var _announceSound:FlxSound;
		private var _successSound:FlxSound;
		private var _wrongSound:FlxSound;
		private var _impactSound:FlxSound;
		private var _impactFrame:uint;
		
		public function Introduction()
		{
			super();
		}
		
		public override function create():void {			
			
			FlxG.bgColor = 0;
			FlxG.mouse.hide();
			
			_announceSound = new FlxSound();
			_announceSound.loadEmbedded(Assets.AnnounceSnd);
			_successSound = new FlxSound();
			_successSound.loadEmbedded(Assets.SuccessSnd);
			_wrongSound = new FlxSound();
			_wrongSound.loadEmbedded(Assets.WrongSnd);
			_impactSound = new FlxSound();
			_impactSound.loadEmbedded(Assets.ImpactSnd);

			_timer = new FlxTimer();
			
			_animations = new FlxSprite(0,0);
			
			_animations.loadGraphic(Assets.IntroductionSheet,true,false,Assets._introWidth,Assets._introHeight,false);
			_animations.addAnimation("introPartOne",Assets._introPartOneFrames,FRAMERATE,true);
			_animations.addAnimation("tutorialLoop",Assets._tutorialPreLoopFrames,FRAMERATE,false);
			_animations.addAnimation("tutorialWin",Assets._tutorialWinFrames,FRAMERATE,false);
			_animations.addAnimation("tutorialFail",Assets._tutorialFailFrames,FRAMERATE,false);
			_animations.addAnimation("tutorialPostWin",Assets._tutorialPostWinFrames,FRAMERATE,true);
			_animations.addAnimation("tutorialPostFail",Assets._tutorialPostFailFrames,FRAMERATE,true);
			
			_bg = new FlxSprite(0,0);
			_bg.x += 0;
			_bg.makeGraphic(FlxG.stage.width,FlxG.stage.height,0x88FFFFFF);
			
			_upperText = new TextField();
			_upperText.defaultTextFormat = _textFormat;
			_upperText.text = "";
			_upperText.wordWrap = true;
			_upperText.selectable = false;
			_upperText.embedFonts = true;
			_upperText.width = (Assets._introWidth * 8) - 100;
			_upperText.height = 800;
			_upperText.x = 0 + 50;
			_upperText.y = 0 + 50;
			
			_lowerText = new TextField();
			_lowerText.defaultTextFormat = _textFormat;
			_lowerText.text = "";
			_lowerText.selectable = false;
			_lowerText.wordWrap = true;
			_lowerText.embedFonts = true;
			_lowerText.width = (Assets._introWidth * 8) - 100;
			_lowerText.height = 800;
			_lowerText.x = 0 + 50;
			_lowerText.y = (Assets._introHeight * 8) - 100;
			
			_tutorialText = new TextField();
			_tutorialText.defaultTextFormat = _tutorialTextFormat;
			_tutorialText.text = "RETURN SEAT TO ITS UPRIGHT POSITION";// "RETURN SEATBACK TO UPRIGHT POSITION";
			_tutorialText.wordWrap = true;
			_tutorialText.selectable = false;
			_tutorialText.embedFonts = true;
			_tutorialText.width = (Assets._introWidth * 8) - 40;
			_tutorialText.x = 0 + 20;
			_tutorialText.y = (Assets._introHeight * 8) + 10;
			
			_resultText = new TextField();
			_resultText.defaultTextFormat = _resultTextFormat;
			_resultText.wordWrap = true;
			_resultText.selectable = false;
			_resultText.embedFonts = true;
			_resultText.text = "";
			_resultText.width = (Assets._introWidth * 8) - 40;
			_resultText.height = 200;
			_resultText.x = 0 + 20;
			_resultText.y = (Assets._introHeight * 8)/2 - 50;
			
			_continueText = new TextField();
			_continueText.defaultTextFormat = _continueTextFormat;
			_continueText.wordWrap = true;
			_continueText.selectable = false;
			_continueText.embedFonts = true;
			_continueText.text = "";
			_continueText.width = (Assets._introWidth * 8) - 40;
			_continueText.height = 200;
			_continueText.x = 0 + 20;
			_continueText.y = (Assets._introHeight * 8)/2;
			
			_introTextTimer = new FlxTimer();
			_resultTimer = new FlxTimer();
			
			add(_animations);
			FlxG.stage.addChild(_upperText);
			FlxG.stage.addChild(_lowerText);
			FlxG.stage.addChild(_resultText);
			FlxG.stage.addChild(_continueText);
			
			_animations.play("introPartOne");
			_currentAnimation = "introPartOne";
			
			_bg.visible = false;
			add(_bg);
			
		} 
		
		
		
		public override function update():void {
			super.update();
						
			if (Assets._tutorialImpactFrames.indexOf(_animations.frame) != -1) {
				if (_impactFrame == 0) {
					_impactSound.play();
					_impactFrame = _animations.frame;
				}
				else if (_impactFrame != _animations.frame) {
					_impactFrame = 0;
				}
			}
			
			if (_currentAnimation == "introPartOne" && !_introTextTimerRunning) {
				_introTextTimer.start(TEXT_DELAY,1,displayText);
				_introTextTimerRunning = true;
				FlxG.stage.addEventListener(KeyboardEvent.KEY_UP, keyUp);	
			}
			else if (_currentAnimation == "tutorialWin") {
				if (_animations.finished) {
					_animations.play("tutorialPostWin");
					_currentAnimation = "tutorialPostWin";
				}
			}
			else if (_currentAnimation == "tutorialFail") {
				if (_animations.finished) {
					_animations.play("tutorialPostFail");
					_currentAnimation = "tutorialPostFail";
				}
			}
			else if ((_currentAnimation == "tutorialPostWin" || _currentAnimation == "tutorialPostFail") &&
					 (!_resultTimerStarted)) {

					_resultTimer.start(TEXT_DELAY,1,displayResult);
					_resultTimerStarted = true;	
			}
		}
		
		public function displayText(timer:FlxTimer):void {
			if (_currentAnimation == "introPartOne") {
				if (_currentTextIndex == 0) _announceSound.play();
				_upperText.text = _partOneTexts[_currentTextIndex];
				_currentTextIndex++;
			}
		}
		
		public function playTutorial(timer:FlxTimer):void {
			_impactFrame = 0;
			_animations.play("tutorialLoop");
			_currentAnimation = "tutorialLoop";
			
			_introTextTimer.start(1,1,startTutorial);

			
		}
		
		public function startTutorial(t:FlxTimer):void {
			_bg.visible = false;
			_tutorialText.setTextFormat(_tutorialTextFormat);
			_tutorialText.setTextFormat(_highlightTextFormat,0,1);
			FlxG.stage.addChild(_tutorialText);
			_resultText.text = "TYPE THE INSTRUCTION BELOW!";
			_resultTimerStarted = false;
		}
		
		public function returnToStartScreen(timer:FlxTimer):void {
			FlxG.switchState( new StartScreen() );
		}
		
		public function playWin():void {
			_animations.play("tutorialWin");
			_currentAnimation = "tutorialWin";
		}
		
		
		public function playFail():void {
			_animations.play("tutorialFail");
			_currentAnimation = "tutorialFail";
		}
		
		public function displayResult(timer:FlxTimer):void {
			
			_bg.visible = true;;

			if (_currentAnimation == "tutorialPostWin") {
				_resultText.text = "THAT'S IT!";
			}
			else if (_currentAnimation == "tutorialPostFail") {
				_resultText.text = "OOPS!";
			}
			
			_resultTimer.start(TEXT_DELAY,1,displayContinue);
		}
		
		public function displayContinue(timer:FlxTimer):void {
			if (_currentAnimation == "tutorialPostWin") {
				_continueText.text = "READY FOR TAKEOFF!\n\n(PRESS SPACE)";
			}
			else if (_currentAnimation == "tutorialPostFail") {
				_continueText.text = "(PRESS SPACE)";
			}
			
			FlxG.stage.addEventListener(KeyboardEvent.KEY_UP,tutorialKeyUp);
			
		}
		
		public function keyUp(e:KeyboardEvent):void {
			
			if (_currentAnimation != "tutorialLoop" && e.keyCode == 32) {
				
				// HANDLE THE VARIOUS TIMES YOU COULD HIT SPACE TO CONTINUE
				if (_currentAnimation == "introPartOne") {
					if (_currentTextIndex == _partOneTexts.length) {
						_upperText.text = "";
						_introTextTimer.start(TEXT_DELAY,1,playTutorial);
					}
					else {
						_upperText.text = "";
						_introTextTimer.start(TEXT_DELAY,1,displayText);
					}
				}
			}
			
			else if (_currentAnimation == "tutorialLoop") {				
				
				_resultText.text = "";
				
				// HANDLE KEYPRESSES FOR TYPING TEST IN THE TUTORIAL
				if (e.keyCode == _tutorialText.text.charCodeAt(_currentInputIndex)) {
					if (_currentInputIndex+2 <= _tutorialText.text.length)
						_tutorialText.setTextFormat(_highlightTextFormat,_currentInputIndex+1,_currentInputIndex+2);
					_tutorialText.setTextFormat(_inputTextFormat,0,_currentInputIndex+1);
					_currentInputIndex++;
					if (_currentInputIndex == _tutorialText.text.length) {
						_successSound.play();
						playWin();
						FlxG.stage.removeEventListener(KeyboardEvent.KEY_UP,keyUp);
					}
				}
				else {
					_wrongSound.play();
					playFail();
					_tutorialText.setTextFormat(_failTextFormat,_currentInputIndex,_currentInputIndex + 1);
					FlxG.stage.removeEventListener(KeyboardEvent.KEY_UP,keyUp);
				}	
			}
		}
		
		
		public function tutorialKeyUp(e:KeyboardEvent):void {
			
			if (e.keyCode == 32) {
				FlxG.stage.removeChild(_tutorialText);
				_continueText.text = "";
				_resultText.text = "";
				_currentInputIndex = 0;
				
				if (_currentAnimation == "tutorialPostWin") {
					trace("Going to tutorial post win timer...");
					_timer.start(1,1,returnToStartScreen);
				}
					
				else if (_currentAnimation == "tutorialPostFail") {
					_timer.start(1,1,playTutorial);
				}
				
				FlxG.stage.removeEventListener(KeyboardEvent.KEY_UP, tutorialKeyUp);
				FlxG.stage.addEventListener(KeyboardEvent.KEY_UP,keyUp);
				
			}
		}
		
		public override function destroy():void {
			
			_animations.destroy();
			_introTextTimer.destroy();
			_resultTimer.destroy();
			_bg.destroy();
			
			FlxG.stage.removeChild(_upperText);
			FlxG.stage.removeChild(_lowerText);
			FlxG.stage.removeChild(_resultText);
			FlxG.stage.removeChild(_continueText);
			
			FlxG.stage.removeEventListener(KeyboardEvent.KEY_UP, keyUp);
			
			super.destroy();

		}
	}
}