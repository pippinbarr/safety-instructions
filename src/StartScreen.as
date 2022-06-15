package
{
	import flash.events.KeyboardEvent;
	import flash.text.*;
	import flash.ui.Mouse;
	import flash.utils.getDefinitionByName;
	
	import org.flixel.*;
	
	
	public class StartScreen extends FlxState
	{
		
		
		private var _animation:FlxSprite;
				
		private var _menuFormat:TextFormat = new TextFormat("Silkscreen",24,0x000000,null,null,null,null,null,"center",null,null,null,null);
		private var _menuSelectedFormat:TextFormat;
		private var _newGame:TextField;
		private var _continue:TextField;
		private var _tutorial:TextField;
		private var _credits:TextField;
		
		private var _titleText:TextField;
		private var _titleFormat:TextFormat = new TextFormat("Silkscreen",36,0x000000,null,null,null,null,null,"center",null,null,null,null);
		private var _creditsUpperText:TextField;
		private var _creditsFormat:TextFormat = new TextFormat("Silkscreen",24,0x000000,null,null,null,null,null,"center",null,null,null,null);
		
		private var _timer:FlxTimer;
		
		public function StartScreen() {
			super();	
		}
		
		public override function create():void {
			
			FlxG.bgColor = 0;
			
			_timer = new FlxTimer();
			
			if (Assets._themeSong == null) {
				Assets._themeSong = new FlxSound();
				Assets._themeSong.loadEmbedded(Assets.ThemeMusic,true,false);
				Assets._themeSong.play();
			}
			else {
				Assets._themeSong.play();
			}
			
			_animation = new FlxSprite(0,0);
			_animation.loadGraphic(Assets.IntroductionSheet,true,false,Assets._introWidth,Assets._introHeight);
			_animation.addAnimation("attractMode",Assets._introPartOneFrames,5,true);
			
			_titleText = Helpers.makeTextField(50, 70, (Assets._introWidth * 8) - 100, 800, "SAFETY INSTRUCTIONS",_titleFormat);
			
			var style:StyleSheet = new StyleSheet();
			style.setStyle("A",{ color:"#555555" });
			
			_creditsUpperText = Helpers.makeTextField(50, 50, (Assets._introWidth * 8) - 100, 800, "",_creditsFormat);
			_creditsUpperText.styleSheet = style;
			_creditsUpperText.htmlText = "THANKS <a href=\"http://www.flixel.org\">FLIXEL</a>! THANKS <a href=\"http://www.bfxr.net/\">BFXR</a>! THANKS <a href=\"http://tones.wolfram.com/\">WOLFRAMTONES</a>!\nTHANKS <a href=\"http://www.pippinbarr.com/\">PIPPIN BARR</a>!\n";
			
			GameState.load();

			//GameState.erase();
			
			if (GameState._currentStageName != null) _continue = Helpers.makeTextField(0,140,(Assets._introWidth * 8),20,"(C)ONTINUE",_menuFormat);			
			_newGame = Helpers.makeTextField(0,160,(Assets._introWidth * 8),20,"(N)EW GAME",_menuFormat);
			_tutorial = Helpers.makeTextField(0,180,(Assets._introWidth * 8),20,"(T)UTORIAL",_menuFormat);
			_credits = Helpers.makeTextField(0,200,(Assets._introWidth * 8),20,"C(R)EDITS",_menuFormat);
			
			_animation.play("attractMode");
			
			add(_animation);
			
			if (GameState._currentStageName != null) FlxG.stage.addChild(_continue);
			FlxG.stage.addChild(_newGame);
			FlxG.stage.addChild(_tutorial);
			FlxG.stage.addChild(_credits);
			
			FlxG.stage.addChild(_titleText);
			FlxG.stage.addChild(_creditsUpperText);
			
			_creditsUpperText.visible = false;
			
			FlxG.stage.addEventListener(KeyboardEvent.KEY_UP,keyUp);
			
		}
		
		
		public override function update():void {
			super.update();
			
		}
		
		private function newGameButtonPress(t:FlxTimer):void {	
			trace("Doing new game...");
			FlxG.switchState( new PreDifficulty() );			
		}
		
		private function continueButtonPress(t:FlxTimer):void {
			trace("Doing continue... _currentStageName is " + GameState._currentStageName);
			var LoadStage:Class = Class(getDefinitionByName(GameState._currentStageName));
			FlxG.switchState(new LoadStage());
		}
		
		private function creditsButtonPress():void {
			_titleText.visible = !_titleText.visible;
			_creditsUpperText.visible = !_creditsUpperText.visible;
		}
		
		private function tutorialButtonPress(t:FlxTimer):void {
			
			FlxG.switchState( new Introduction() );
		}
		
		private function keyUp(e:KeyboardEvent):void {
			
			trace("keyCode=" + e.keyCode + " || charCode=" + e.charCode);
			
			if ((e.keyCode == 67 && _continue != null) || (e.keyCode == 78) || (e.keyCode == 84)) {
				FlxG.stage.removeEventListener(KeyboardEvent.KEY_UP,keyUp);
				FlxG.stage.removeChild(_titleText);
				FlxG.stage.removeChild(_creditsUpperText);
				FlxG.stage.removeChild(_newGame);
				FlxG.stage.removeChild(_credits);
				if (_continue != null) FlxG.stage.removeChild(_continue);
				FlxG.stage.removeChild(_tutorial);
			}
			
			if (e.keyCode == 67 && GameState._currentStageName != null) _timer.start(1,1,continueButtonPress);
			else if (e.keyCode == 78) _timer.start(1,1,newGameButtonPress);
			else if (e.keyCode == 84) _timer.start(1,1,tutorialButtonPress);
			else if (e.keyCode == 82) creditsButtonPress();
			
		}
		
		public override function destroy():void {
			
			_animation.destroy();
						
			FlxG.stage.focus = null;
			
			super.destroy();
		}
	}
}