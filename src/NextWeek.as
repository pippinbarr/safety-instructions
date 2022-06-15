package
{
	import flash.events.*;
	import flash.text.*;
	
	import org.flixel.*;
	
	public class NextWeek extends FlxState
	{
		private var _image:FlxSprite;
		private var _text:TextField;
		private var _textFormat:TextFormat = new TextFormat("Silkscreen",36,0xFFFFFFFF,null,null,null,null,null,"center",null,null,null,null);
		private var _spaceFormat:TextFormat = new TextFormat("Silkscreen",18,0xFFFFFFFF,null,null,null,null,null,"center",null,null,null,null);
		private var _textTimer:FlxTimer;
		
		
		public function NextWeek()
		{
		}
		
		public override function create():void {
			
			super.create();
			
			_image = new FlxSprite(0,0);
			_image.loadGraphic(Assets.BlackFrame,false,false,75,50);
			
			add(_image);
			
			_textTimer = new FlxTimer();
			
			_text = new TextField();
			_text.defaultTextFormat = _textFormat;
			_text.text = "NEXT WEEK...";
			_text.embedFonts = true;
			_text.selectable = false;
			_text.wordWrap = true;
			_text.width = (Assets._crashWidth * 8) - 100;
			_text.height = 800;
			_text.x = 0 + 50;
			_text.y = 0 + 180;
			
			_textTimer.start(2,1,displayNextWeek);
			
		}
		
		public override function update():void {
			super.update();
		}
		
		private function displayNextWeek(t:FlxTimer):void {
			FlxG.stage.addChild(_text);
			_textTimer.start(2,1,displayPressSpace);
		}
		
		private function displayPressSpace(t:FlxTimer):void {
			_text.appendText("\n\n(PRESS SPACE)");
			_text.setTextFormat(_spaceFormat,12,_text.text.length);
			FlxG.stage.addEventListener(KeyboardEvent.KEY_UP, keyUp);
		}
		
		private function nextStage(t:FlxTimer):void {
			FlxG.switchState( new LostStage() );
		}	
		
		public function keyUp(e:KeyboardEvent):void {
			
			if (e.keyCode == 32) {
				FlxG.stage.removeEventListener(KeyboardEvent.KEY_UP, keyUp);
				_text.text = "";
				_textTimer.start(3,1,nextStage);
			}
			
		}
		
		public override function destroy():void {
			
			_image.destroy();
			_textTimer.destroy();
			FlxG.stage.removeChild(_text);
			super.destroy();
		}
	}
}