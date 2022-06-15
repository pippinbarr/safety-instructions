package
{
	import flash.events.*;
	import flash.text.*;
	
	import org.flixel.*;
	
	public class CrashStage extends FlxState
	{
		private var _animation:FlxSprite;
		private var _text:TextField;
		private var _textFormat:TextFormat = new TextFormat("Silkscreen",28,0x000000,null,null,null,null,null,"center",null,null,null,null);
		private var _textTimer:FlxTimer;
		private var _texts:Array = new Array(
			"GET OFF THE PLANE! GET OFF THE PLANE NOW!!\n\n(PRESS SPACE)",
			"AAAAAHHHHHH!!\n\n(PRESS SPACE)");
		private var _currentTextIndex:uint = 0;
		private var _looping:Boolean = false;
		private var _removeSettings:Boolean = false;
		
		private var _announceSound:FlxSound;
		private var _impactSound:FlxSound;
		private var _impactFrame:uint = 0;
		
		public function CrashStage()
		{
		}
		
		public override function create():void {
			
			super.create();
			
			_impactSound = new FlxSound();
			_announceSound = new FlxSound();
			_impactSound.loadEmbedded(Assets.ImpactSnd);
			_announceSound.loadEmbedded(Assets.AnnounceSnd);
			
			_animation = new FlxSprite(0,0);
			_animation.loadGraphic(Assets.CrashSheet,true,false,Assets._crashWidth,Assets._crashHeight);
			_animation.addAnimation("preLoop",Assets._crashFrames,8,false);
			_animation.addAnimation("loop",Assets._crashPostLoopFrames,8,true);
			
			add(_animation);
			_animation.play("preLoop");
			
			_textTimer = new FlxTimer();
			
			_text = new TextField();
			_text.defaultTextFormat = _textFormat;
			_text.text = "";
			_text.selectable = false;
			_text.wordWrap = true;
			_text.embedFonts = true;
			_text.width = (Assets._crashWidth * 8) - 100;
			_text.height = 800;
			_text.x = 0 + 50;
			_text.y = 0 + 50;
			
			FlxG.stage.addChild(_text);
			
		}
		
		public override function update():void {
			super.update();
			
			if (Assets._crashImpactFrames.indexOf(_animation.frame) != -1) {
				if (_impactFrame == 0) {
					_impactSound.play();
					_impactFrame = _animation.frame;
				}
				else if (_impactFrame != _animation.frame) {
					_impactFrame = 0;
				}
			}
			
			if (_animation.finished && !_looping) {
				_animation.play("loop");
				_looping = true;
				_textTimer.start(2,1,displayText);
			}
		}
		
		private function displayText(timer:FlxTimer):void {
			if (_currentTextIndex < _texts.length) {
				if (_currentTextIndex == 0) _announceSound.play();
				_text.text = _texts[_currentTextIndex];
				_currentTextIndex++;
				FlxG.stage.addEventListener(KeyboardEvent.KEY_UP,crashKeyUp);
			}
			else {
				
			}
		}
		
		private function nextStage(timer:FlxTimer):void {
			if ( !GameState._bonusUnlocked) {
				FlxG.switchState( new CrawlStage() );
			}
			else if ( GameState._bonusUnlocked ) {
				FlxG.switchState( new LuggageStage() );
			}
		}	
		
		public function crashKeyUp(e:KeyboardEvent):void {
			
			if (e.keyCode == 32) {
				FlxG.stage.removeEventListener(KeyboardEvent.KEY_UP, crashKeyUp);
				_text.text = "";
				if (_currentTextIndex == _texts.length) {
					_textTimer.start(1,1,nextStage);
				}
				else {
					_textTimer.start(1,1,displayText);
				}
			}
		}
		

		
		public override function destroy():void {
			
			_animation.destroy();
			_textTimer.destroy();
			FlxG.stage.removeChild(_text);
			super.destroy();
		}
	}
}