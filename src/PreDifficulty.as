package
{
	import flash.events.*;
	import flash.text.*;
	
	import org.flixel.*;
	
	public class PreDifficulty extends FlxState
	{
		
		private var _animation:FlxSprite;
				
		private var _text:TextField;
		private var _textFormat:TextFormat = new TextFormat("Silkscreen",24,0x000000,null,null,null,null,null,"center",null,null,null,null);
		private var _textTimer:FlxTimer;
		private var _texts:Array = new Array(
			"HI FOLKS, THIS IS YOUR CAPTAIN SPEAKING. WE'RE CLIMBING TO OUR CRUISING ALTITUDE, CONDITIONS ARE LOOKING JUST PERFECT.\n\n(PRESS SPACE)",
			"AS WE SETTLE INTO THIS FLIGHT, I DO HAVE ONE BRIEF QUESTION FOR YOU...\n\n(PRESS SPACE)");
		private var _currentTextIndex:uint = 0;
		private var _removeSettings:Boolean = false;
		
		private var _announceSound:FlxSound;
		
		public function PreDifficulty()
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
			_animation.play("takeoff");
			add(_animation);
			
			_text = new TextField();
			_text.defaultTextFormat = _textFormat;
			_text.text = "";
			_text.selectable = false;
			_text.wordWrap = true;
			_text.embedFonts = true;
			_text.width = (Assets._crashWidth * 8) - 100;
			_text.height = 800;
			_text.x = 0 + 50;
			_text.y = 0 + 220;
			
			FlxG.stage.addChild(_text);
			
			_textTimer.start(2,1,displayText);
			
		}
		
		public override function update():void {
			super.update();	
		}
		
		private function displayText(timer:FlxTimer):void {
			if (_currentTextIndex < _texts.length) {
				if (_currentTextIndex == 0) _announceSound.play();
				_text.text = _texts[_currentTextIndex];
				_currentTextIndex++;
				FlxG.stage.addEventListener(KeyboardEvent.KEY_UP,difficultyKeyUp);
			}
			else {
				
			}
		}
		
		private function nextStage(timer:FlxTimer):void {
			FlxG.switchState( new DifficultSelection() );
		}
				
		public function difficultyKeyUp(e:KeyboardEvent):void {
			
			if (e.keyCode == 32) {
				FlxG.stage.removeEventListener(KeyboardEvent.KEY_UP, difficultyKeyUp);
				_text.text = "";
				if (_currentTextIndex == _texts.length) {
					_textTimer.start(0.1,1,nextStage);
				}
				else {
					_textTimer.start(1,1,displayText);
				}
			}
		}
				
		public override function destroy():void {
			
			FlxG.stage.removeChild(_text);
			_animation.destroy();
			
			FlxG.stage.focus = null;
			
			super.destroy();
			
		}
	}
}