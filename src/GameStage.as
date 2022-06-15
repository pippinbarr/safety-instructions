package
{
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.text.*;
	
	import org.flixel.*;
	
	public class GameStage extends FlxState
	{
		
		protected const FRAMERATE:int = 6;
		protected const TIME_TO_RESULT:Number = 0.5;
		protected const TIME_TO_CONTINUE:Number = 0.5;
		
		protected const POST_CONTINUE_DELAY:Number = 0.5;
		protected const PRE_TEXT_DELAY:uint = 1;
		
		protected var TIME_LIMIT:int = 10;
		
		protected var _successSound:FlxSound;
		protected var _wrongSound:FlxSound;
		protected var _impactSound:FlxSound;
		protected var _impactFrame:uint = 0;
		protected var _impactFrames:Array;
		protected var _openSound:FlxSound;
		protected var _openFrame:uint = 0;
		protected var _whistleSound:FlxSound;
		protected var _whistleFrame:uint = 0;
		
		protected var _width:int;
		protected var _height:int;
		
		protected var _stageName:String;
		protected var _results:Array;
		
		protected var _animations:FlxSprite;
		
		protected var _loopFrames:Array;
		protected var _winFrames:Array;
		protected var _failFrames:Array;
		
		protected var _text:TextField;
		protected var _textFormat:TextFormat = new TextFormat("Silkscreen",20,0x000000,null,null,false,null,null,"center",null,null,null,15);
		protected var _inputTextFormat:TextFormat = new TextFormat("Silkscreen",20,0x00FF00,null,null,false,null,null,"center",null,null,null,15);
		protected var _failTextFormat:TextFormat = new TextFormat("Silkscreen",20,0xFF0000,null,null,false,null,null,"center",null,null,null,15);
		protected var _highlightTextFormat:TextFormat = new TextFormat("Silkscreen",20,0x000000,null,null,true,null,null,"center",null,null,null,15);
		protected var _resultText:TextField;
		protected var _resultTextFormat:TextFormat = new TextFormat("Silkscreen",70,0x000000,null,null,null,null,null,"center",null,null,null,null);
		protected var _lostResultTextFormat:TextFormat = new TextFormat("Silkscreen",30,0x000000,null,null,null,null,null,"center",null,null,null,null);
		protected var _continueText:TextField;
		protected var _continueTextFormat:TextFormat = new TextFormat("Silkscreen",32,0x000000,null,null,null,null,null,"center",null,null,null,null);
		protected var _timerText:TextField;
		protected var _timerTextFormat:TextFormat = new TextFormat("Silkscreen",70,0xFF0000,null,null,null,null,null,"right",null,null,null,null);
		
		protected var _lastKeyCode:int = -1;
		
		protected var _bg:FlxSprite;
		
		protected var _currentInputIndex:int = 0;
		
		protected var _won:Boolean = false;
		protected var _lost:Boolean = false;
		protected var _wonLost:Boolean = false;
		protected var _looping:Boolean = false;
		protected var _timerRunning:Boolean = false;
		
		protected var _currentLostWinIndex:uint = 0;
		protected var _lostTimer:FlxTimer;
		
		protected var _timer:Number = 0;
		protected var _textDisplayed:Boolean = false;
		protected var _resultDisplayed:Boolean = false;
		protected var _continueDisplayed:Boolean = false;
		
		protected var _switchStage:Boolean = false;
		
		// Special case booleans
		protected var _playPreLoop:Boolean = false;
		protected var _playSignalPrePreLoop:Boolean = false;
		protected var _playDrown:Boolean = false;
		protected var _signalDelay:Boolean = false;
		
		protected var _postWin:Array = null;
		
		protected var _preTimer:FlxTimer;
		
		private var _animationOffset:uint = 0;
		
		private var _playingReverseFrames:Boolean = false;
		
		public function GameStage()
		{
			super();
		}
		
		public override function create():void {
			
			super.create();
			
			FlxG.bgColor = 0;
			
			FlxG.mouse.hide();
			
		}
		
		public function setup(stageName:String,
							  sheet:Class,width:int,
							  height:int,
							  preLoop:Array,
							  win:Array,
							  postWin:Array,
							  fail:Array,
							  postFail:Array,
							  impactFrames:Array,
							  text:String,
							  results:Array):void {
			
			Assets._themeSong.play();
			
			_lostTimer = new FlxTimer();
			
			Globals._winner = false;
			
			_successSound = new FlxSound();
			_successSound.loadEmbedded(Assets.SuccessSnd);
			_wrongSound = new FlxSound();
			_wrongSound.loadEmbedded(Assets.WrongSnd);
			_impactSound = new FlxSound();
			_impactSound.loadEmbedded(Assets.ImpactSnd);
			_impactFrames = impactFrames;
			_openSound = new FlxSound();
			_openSound.loadEmbedded(Assets.OpenSnd);
			_whistleSound = new FlxSound();
			_whistleSound.loadEmbedded(Assets.WhistleSnd)
			
			_stageName = stageName;
			
			GameState._currentStageName = _stageName;
			_postWin = postWin;
			
			_results = results;
			
			_width = width;
			_height = height;
			
			_animations = new FlxSprite(0,0);
			Globals._finalAnimation = new FlxSprite(0,0);
			Globals._finalAnimation.loadGraphic(sheet,true,false,width,height,false);
			
			if ( _stageName == "LuggageStage" ) {
				Globals._finalAnimation.addAnimation("final",postWin,FRAMERATE,true);
				Globals._finalAnimationFrames = postWin.concat();
			}
			else if ( _stageName == "DodgeStage" && !GameState._inflateSuccess) {
				Globals._finalAnimation.addAnimation("final",Assets._dodgePostDrownFrames,FRAMERATE,true);
				Globals._finalAnimationFrames = Assets._dodgePostDrownFrames.concat();
			}
			else if ( _stageName == "WhistleStage" && !GameState._inflateSuccess) {
				Globals._finalAnimation.addAnimation("final",Assets._whistlePostDrownFrames,FRAMERATE,true);
				Globals._finalAnimationFrames = Assets._whistlePostDrownFrames.concat();	
			}
			else {
				Globals._finalAnimation.addAnimation("final",postFail,FRAMERATE,true);
				Globals._finalAnimationFrames = postFail.concat();
			}
			
			_animations.loadGraphic(sheet,true,false,width,height,false);
			
			if (_animations.frameWidth == 50 ) _animationOffset = 12;
			_animations.x += _animationOffset;
			
			_animations.addAnimation("preLoop",preLoop,FRAMERATE,true);
			_animations.addAnimation("win",win,FRAMERATE,false);
			_animations.addAnimation("postWinLoop",postWin,FRAMERATE,true);
			_animations.addAnimation("fail",fail,FRAMERATE,false);
			_animations.addAnimation("postFailLoop",postFail,FRAMERATE,true);
			
			_bg = new FlxSprite(0,0);
			_bg.x += _animationOffset;
			_bg.makeGraphic(FlxG.stage.width,FlxG.stage.height,0x88FFFFFF);
			
			_text = new TextField();
			_text.defaultTextFormat = _textFormat;
			_text.text = text;
			_text.wordWrap = true;
			_text.embedFonts = true;
			_text.selectable = false;
			_text.width = (_width * 8) - 40;
			_text.height = 200;
			_text.x = 0 + 20;
			_text.x += _animationOffset * 8;
			_text.y = (_height * 8) + 10;
			
			_timerText = new TextField();
			_timerText.defaultTextFormat = _timerTextFormat;
			_timerText.text = TIME_LIMIT.toString();
			_timerText.width = 100;
			_timerText.x = (_width * 8) - 120;
			_timerText.x += _animationOffset * 8;
			_timerText.embedFonts = true;
			_timerText.selectable = false;
			_timerText.y = 20;
						
			_resultText = new TextField();
			_resultText.defaultTextFormat = _resultTextFormat;
			_resultText.wordWrap = true;
			_resultText.embedFonts = true;
			_resultText.selectable = false;
			_resultText.text = "";

			//_resultText.alpha = 0.8;
			//_resultText.background = true;
			//_resultText.backgroundColor = 0x000000;
			_resultText.width = (_width * 8);
			_resultText.height = 100;
			_resultText.x = 0;
			_resultText.x += _animationOffset * 8;
			_resultText.y = (_height * 8)/2 - 50;
			
			_continueText = new TextField();
			_continueText.defaultTextFormat = _continueTextFormat;
			_continueText.wordWrap = true;
			_continueText.embedFonts = true;
			_continueText.selectable = false;
			_continueText.text = "";
			//_continueText.background = true;
			//_continueText.backgroundColor = 0x000000;
			_continueText.width = (_width * 8);
			_continueText.height = 50;
			_continueText.x = 0;
			_continueText.x += _animationOffset * 8;
			_continueText.y = (_height * 8)/2;
		
			
			add(_animations);
			
			if (_stageName == "SignalStage") {
				_playSignalPrePreLoop = true;
			}
			else if ((_stageName == "WhistleStage" || (_stageName == "DodgeStage")) && !GameState._inflateSuccess) {
				_playDrown = true;
			}
			else {
				_playPreLoop = true;
			}
			
			_preTimer = new FlxTimer();
			
			
		}
		
		public function startLevel(timer:FlxTimer):void {
			FlxG.stage.addChild(_timerText);			
			FlxG.stage.addChild(_text);			
			_text.setTextFormat(_highlightTextFormat,0,1);
			FlxG.stage.addEventListener(KeyboardEvent.KEY_DOWN,keyUp);
			_timerRunning = true;
		}
		
		public override function update():void {
			
			super.update();
			
			if (_playingReverseFrames) {
				if (_animations.finished) {
					_animations.play("preLoop");
					_lostTimer.start(1,1,displayLostWinResult);
					_playingReverseFrames = false;
				}
			}
			
			if (_impactFrames != null) {
				if (_impactFrames.indexOf(_animations.frame) != -1) {
					if (_impactFrame == 0) {
						_impactSound.play();
						_impactFrame = _animations.frame;
					}
					else if (_impactFrame != _animations.frame) {
						_impactFrame = 0;
					}				
				}
			}
			if (_stageName == "OpenStage") {
				if (Assets._openOpenFrames.indexOf(_animations.frame) != -1) {
					if (_openFrame == 0) {
						_openSound.play();
						_openFrame = _animations.frame;
					}
					else if (_openFrame != _animations.frame) {
						_openFrame = 0;
					}
				}
			}
			if (_stageName == "WhistleStage") {
				if (Assets._whistleFrames.indexOf(_animations.frame) != -1) {
					if (_whistleFrame == 0) {
						_whistleSound.play();
						_whistleFrame = _animations.frame;
					}
					else if (_whistleFrame != _animations.frame) {
						_whistleFrame = 0;
					}
				}
			}
			
			if (_stageName == "BuckleStage" || _stageName == "BreatheStage" || _stageName == "AssistStage" || _stageName == "BraceStage") {
				FlxG.shake(0.01,60);
			}
			
			if (_playPreLoop) {
				if (_stageName != "SignalStage") _preTimer.start(PRE_TEXT_DELAY,1,startLevel);
				playPreLoop();
				_playPreLoop = false;
			}
			
			if (!_won && !_lost && _timerRunning) {
				_timer += FlxG.elapsed;
				if (_stageName == "LostStage") _timer += FlxG.elapsed;
				_timerText.text = Math.ceil(TIME_LIMIT - _timer).toString();
			}
			
			if (_timer > TIME_LIMIT) {
				_wrongSound.play();
				_text.setTextFormat(_failTextFormat,_currentInputIndex,_text.length);
				playFail();
				_lost = true;
				_timerRunning = false;
				FlxG.stage.removeEventListener(KeyboardEvent.KEY_DOWN,keyUp);
				_timer = 0;
			}
			
			if ((_won || _lost) && !_looping && _signalDelay) {
				if (_animations.finished) {
					_timerRunning = false;
					_timer = 0;
					if (_won) {
						playWin();
					}
					else if (_lost) {
						playFail();
					}
					_signalDelay = false;
				}
			}
			
			if ((_won || _lost) && !_looping && !_signalDelay) {
				// The level has been decided and the win/fail animation is playing
				_timerRunning = false;
				_timer = 0;
				if (_animations.finished) {
					// The animation has finished so we need to play the appropriate post-loop
					if (_won) {
						playPostWinLoop();
					}
					else if (_lost && ((_stageName != "WhistleStage" && _stageName != "DodgeStage") || GameState._inflateSuccess)) {
						playPostFailLoop();
					}
				}
			}
			
			else if (_wonLost && !_looping) {
				_timerRunning = false;
				_timer = 0;
				if (_animations.finished) {
					// We've played the chair crushing them, so now we need to be surprised!
					playPostFailLoop();
				}
			}
			
			else if ((_won || _lost) && _looping && !_resultDisplayed) {
				// The level has been decided and the post-loop is playing
				// So we need to give them the result (SAFE or DEAD) and then
				// set a timer to move to the next level (or not, if dead)
				if (_timer < TIME_TO_RESULT) {
					_timer += FlxG.elapsed;
				}
				else {
					_timer = 0;
					displayResult();
				}
			}
			
			else if (_wonLost && _looping && !_resultDisplayed) {
				if (_timer < TIME_TO_RESULT) {
					_timer += FlxG.elapsed;
				}
				else {
					_lostTimer.start(2,1,displayLostWinResult);
					_resultDisplayed = true;
				}
			}
			
			else if (_resultDisplayed && !_continueDisplayed) {
				_timer += FlxG.elapsed;
				if (_timer > TIME_TO_CONTINUE) {
					displayContinue();
				}
			}
		}
		
		public function playPreLoop():void {
			_animations.play("preLoop");
		}
		
		public function playWin():void {
			_animations.play("win");
			_looping = false;
		}
		
		public function playPostWinLoop():void {
			_animations.play("postWinLoop");
			_looping = true;
		}
		
		public function playFail():void {
			_animations.play("fail");
			_looping = false;
		}
		
		public function playPostFailLoop():void {
			_animations.play("postFailLoop");
			_looping = true;
		}
		
		public function displayResult():void {
			
			//add(_bg);
			
			
			
			if (_won) {
				if (_results != null) _resultText.text = _results[0];
				else _resultText.text = Assets._defaultResults[0];
			}
			else if (_lost) {
				
				if (_results != null) _resultText.text = _results[2];
				else _resultText.text = Assets._defaultResults[2];
				
				if (_stageName == "CrawlStage") {
					_resultTextFormat.color = 0xFFFFFF;
					_resultText.setTextFormat(_resultTextFormat);
				}
			}
			
			FlxG.stage.addChild(_resultText);
			
			_resultDisplayed = true;
		}
		
		
		public function displayContinue():void {
			
			if (_won) {
				if (_results != null) _continueText.text = _results[1];
				else _continueText.text = Assets._defaultResults[1];
			}
			else if (_lost) {
				if (_stageName == "WhistleStage" && !GameState._inflateSuccess) _continueText.text = Assets._whistleDrownRestartText;
				else if (_stageName == "DodgeStage" && !GameState._inflateSuccess) _continueText.text = Assets._dodgeDrownRestartText;
				else if (_results != null) _continueText.text = _results[3];
				else _continueText.text = Assets._defaultResults[3];
				if (_stageName == "CrawlStage") {
					_continueTextFormat.color = 0xFFFFFF;
					_continueText.setTextFormat(_continueTextFormat);
				}
			}
			
			FlxG.stage.addChild(_continueText);
			
			FlxG.stage.addEventListener(KeyboardEvent.KEY_UP,endStageKeyUp);
			
			_continueDisplayed = true;
		}
		
		public function displayLostWinResult(t:FlxTimer):void {
			if (_currentLostWinIndex == 0) {
				_resultText.defaultTextFormat = _lostResultTextFormat;
				FlxG.stage.addChild(_resultText);
			}
			else {
				_resultText.visible = true;
			}
			
			if (_currentLostWinIndex < Assets._lostWinResults.length) {
				_resultText.text = Assets._lostWinResults[_currentLostWinIndex];
			}
			
			if (_currentLostWinIndex != 5) {
				_lostTimer.start(0.5,1,displayLostWinContinue);
			}
		}
		
		public function displayLostWinContinue(t:FlxTimer):void {
			_continueText.text = "(PRESS SPACE)";
			if (_currentLostWinIndex == 0) {
				FlxG.stage.addChild(_continueText);
			}
			else {
				_continueText.visible = true;
			}
			FlxG.stage.addEventListener(KeyboardEvent.KEY_UP,wonLostKeyUp);
		}
		
		public function keyUp(e:KeyboardEvent):void {
			
			var input:int = e.charCode;
			var chr:String = String.fromCharCode(e.charCode);
			
			// PORTUGAL: ? = keycode 189 // charcode 63
			// US: ? = keycode 191 // 63
			
			//trace("entered: keyCode=" + e.keyCode + " // charCode=" + e.charCode);
			//trace("required: char=" + _text.text.charAt(_currentInputIndex) + " // charCode=" + _text.text.charCodeAt(_currentInputIndex));

			if (input >= 97 && input <= 122) input -= 32;
			// Allow shift
			if (e.keyCode == 16) {}
			//else if (input == _text.text.charCodeAt(_currentInputIndex) || e.keyCode == 16) {
			else if (chr.toUpperCase() == _text.text.charAt(_currentInputIndex) ||
					(_text.text.charAt(_currentInputIndex) == "?" && e.keyCode == 219) ||
					(_text.text.charAt(_currentInputIndex) == "'" && e.keyCode == 191)) {
				// If the typed character matches (OR "THE MANUEL CASE" applies...)
				_text.setTextFormat(_inputTextFormat,0,_currentInputIndex+1);
				_text.setTextFormat(_inputTextFormat,0,_currentInputIndex+1);
				if (_currentInputIndex + 2 <= _text.length)
					_text.setTextFormat(_highlightTextFormat,_currentInputIndex+1,_currentInputIndex+2);
				_currentInputIndex++;
				if (_currentInputIndex == _text.text.length) {
					_successSound.play();
					if (_stageName != "SignalStage" && _stageName != "LostStage") {
						playWin();
						_won = true;
						FlxG.stage.removeEventListener(KeyboardEvent.KEY_DOWN,keyUp);
						_timerRunning = false;
					}
					else if (_stageName == "SignalStage") {
						_won = true;
						FlxG.stage.removeEventListener(KeyboardEvent.KEY_DOWN,keyUp);
						_timerRunning = false;
						_signalDelay = true;
					}
					else if (_stageName == "LostStage") {
						_wrongSound.play(); // Play the fail sound as well as the success sound - ha ha
						_wonLost = true;
						FlxG.stage.removeEventListener(KeyboardEvent.KEY_DOWN,keyUp);
						_timerRunning = false;
						playFail();
					}
				}
			}
			else {
				_wrongSound.play();
				
				_text.setTextFormat(_failTextFormat,_currentInputIndex,_text.length);
				FlxG.stage.removeEventListener(KeyboardEvent.KEY_DOWN,keyUp);
				_timerRunning = false;
				_lost = true;

				if (_stageName != "SignalStage") {
					playFail();
				}
				else {
					_signalDelay = true;
				}
			}	
			_lastKeyCode = input;
		}
		
		
		// endStageKeyUp
		//
		// All this really does is look for a SPACE hit and then work out what the next
		// correct stage to transition to is, based on the current level and result.
		
		public function endStageKeyUp(e:KeyboardEvent):void {
			if (e.keyCode == 32) {
				FlxG.stage.removeEventListener(KeyboardEvent.KEY_UP,endStageKeyUp);
				_resultText.visible = false;
				_continueText.visible = false;
				if (_won) {
					// If it was luggage, then winning means losing!
					if (_stageName == "LuggageStage") {
						_preTimer.start(POST_CONTINUE_DELAY,1,gameOver);
						//FlxG.switchState(new PostPlay());
					}
					else {
						// If it was inflating the jacket, then we need to take note
						if (_stageName == "InflateStage") GameState._inflateSuccess = true;
						if (_stageName == "SignalStage") Globals._finalAnimationFrames = _postWin;
						
						// And if we had success, we want to go to the next stage
						_preTimer.start(POST_CONTINUE_DELAY,1,nextStage);
						//_switchStage = true;
					}
				}
				else if (_lost) {
					// If it was inflate, then we need to note the failure to inflate, but keep playing
					if (_stageName == "InflateStage") {
						GameState._inflateSuccess = false;
						_preTimer.start(POST_CONTINUE_DELAY,1,nextStage);
						//_switchStage = true;
					}
						// If it was assist, then you don't lose for not helping the kid
					else if ( _stageName == "AssistStage" ) {
						_preTimer.start(POST_CONTINUE_DELAY,1,nextStage);
						//_switchStage = true;
					}
						// If it was luggage, then losing means winning!
					else if (_stageName == "LuggageStage" ) {
						_preTimer.start(POST_CONTINUE_DELAY,1,nextStage);
					}
						// Otherwise, the game is lost
					else {
						_preTimer.start(POST_CONTINUE_DELAY,1,gameOver);
						
					}
				}
			}
		}
		
		private function wonLostKeyUp(e:KeyboardEvent):void {
			// They pressed space during lost sequence
			FlxG.stage.removeEventListener(KeyboardEvent.KEY_UP,wonLostKeyUp);
			_resultText.visible = false;
			_continueText.visible = false;
			_currentLostWinIndex++;
			if (_currentLostWinIndex == 4) {
				_animations.addAnimation("lostWin",Assets._lostReverseFailFrames,FRAMERATE,false);
				_animations.play("lostWin");
				_playingReverseFrames = true;
			}
			else if (_currentLostWinIndex == 6) {
				// Do nothing.
			}
			else {
				_lostTimer.start(1,1,displayLostWinResult);
			}

		}
		
		private function nextStage(timer:FlxTimer):void {
			_switchStage = true;
		}
		
		private function gameOver(timer:FlxTimer):void {
			Globals._finalAnimationStartFrame = _animations.frame;
			//Assets._themeSong.pause();
			FlxG.switchState( new PostPlay() );
		}
		
		public override function destroy():void {
			
			super.destroy();
			
			_animations.destroy();
			_bg.destroy();
			
			_loopFrames = null;
			_winFrames = null;
			_failFrames = null;
			
			if (GameState._inflateSuccess || (_stageName != "WhistleStage" && _stageName != "DodgeStage")) FlxG.stage.removeChild(_text);
			if (GameState._inflateSuccess || (_stageName != "WhistleStage" && _stageName != "DodgeStage")) FlxG.stage.removeChild(_timerText);
			FlxG.stage.removeChild(_resultText);
			FlxG.stage.removeChild(_continueText);
			
			_preTimer.destroy();
			
			//FlxG.stage.removeEventListener(KeyboardEvent.KEY_UP,endStageKeyUp);	
		}
		
		public override function kill():void {
			
			_animations.kill();
			
			super.kill();
		}
	}
}