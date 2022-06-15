package
{
	import flash.display.*;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.text.*;
	import flash.utils.getTimer;
	
	import org.flixel.system.FlxPreloader;
	
	import flash.system.fscommand;
	import flash.geom.Rectangle;
	
	[SWF(width = "600", height = "600", backgroundColor = "#FFFFFF")]
	
	public class Preloader extends FlxPreloader
	{
		
		[Embed(source="assets/fonts/slkscr.ttf", fontName="silkscreen", fontWeight="Regular", embedAsCFF="false")]
		private var SilkScreenFont:Class;
		
		[Embed(source="assets/png/BlackFrame.png")]
		private var BlackFrame:Class;
		
		private var _loadingTexts:Array = new Array(
			"Reading shitty airport novel...",
			"Playing Angry Birds listlessly...",
			"Trying to get comfortable on seat...",
			"Watching people shop in duty free...",
			"Wondering about buying a coffee...",
			"Realising toothbrush is back home...",
			"Dreading sitting near that baby...",
			"Feeling too hot and too cold...",
			"Worrying about carry on space...",
			"Fretting about missed opportunites...");
		
		private var _boardingText:TextField;
		private var _boardingTextFormat:TextFormat;
		private var _infoText:TextField;
		private var _infoTextFormat:TextFormat = new TextFormat("system",20,0xFFFFFF,null,null,false,null,null,"center",null,null,null,null);
		
		private var _bg:Bitmap;
		private var _loadingBar:Bitmap;
		private var _loadingBarBGBlack:Bitmap;
		private var _loadingBarBGWhite:Bitmap;
		
		private var _playButton:TextField;
		private var _playButtonFormat:TextFormat;
		
		private var _timer:uint = 0;
		
		public function Preloader() {			
			
			className = "SafetyInstructions";
			super();
			
			stage.showDefaultContextMenu = false;
			stage.displayState = StageDisplayState.FULL_SCREEN;
			stage.scaleMode = StageScaleMode.SHOW_ALL;
			stage.fullScreenSourceRect = new Rectangle(0,0,800,400);
			
			stage.align = StageAlign.TOP;
			
			fscommand("trapallkeys","true");
		}
		
		override protected function create():void {
			
			Font.registerFont(SilkScreenFont);
						
			// Set minimum running time of the preload
			_min = 8000000;
			
			// Create a buffer Sprite
			_buffer = new Sprite();
			addChild(_buffer);	
			
			_bg = new BlackFrame();
			_bg.x = 0;
			_bg.y = 0;
			_bg.scaleX = 8;
			_bg.scaleY = 8;
						
			// Textfield to display boarding messages
			_boardingTextFormat = new TextFormat("silkscreen",50,0xFFFFFF,null,null,false,null,null,"center",null,null,null,null);
			_boardingText = new TextField();
			_boardingText.width = stage.stageWidth;
			_boardingText.x = stage.x;
			_boardingText.y = stage.stageHeight/2 - 100;
			_boardingText.embedFonts = true;
			_boardingText.selectable = false;
			_boardingText.defaultTextFormat = _boardingTextFormat;
			_boardingText.text = "BOARDING...";
			
			_infoText = new TextField();
			_infoTextFormat = new TextFormat("silkscreen",18,0xFFFFFF,null,null,false,null,null,"center",null,null,null,null);
			_infoText.width = stage.stageWidth;
			_infoText.x = stage.x;
			_infoText.y = stage.stageHeight/2;
			_infoText.embedFonts = true;
			_infoText.selectable = false;
			_infoText.defaultTextFormat = _infoTextFormat;
			_infoText.text = "";
			
			_playButton = new TextField();
			_playButtonFormat = new TextFormat("silkscreen",30,0xFF0000,null,null,false,null,null,"center",null,null,null,null);
			_playButton.width = stage.stageWidth;
			_playButton.x = stage.x;
			_playButton.y = stage.stageHeight/2 + 50;
			_playButton.embedFonts = true;
			_playButton.selectable = false;
			_playButton.defaultTextFormat = _playButtonFormat;
			_playButton.text = "CLICK TO PLAY!";
			
			
			_loadingBarBGWhite = new Bitmap(new BitmapData(300,20,false,0xFFFFFF));
			_loadingBarBGBlack = new Bitmap(new BitmapData(298,18,false,0x000000));
			_loadingBar = new Bitmap(new BitmapData(1,16,false,0xFFFFFF));
			
			_loadingBarBGWhite.x = stage.stageWidth/2 - _loadingBarBGWhite.width/2;
			_loadingBarBGWhite.y = stage.stageHeight/2 - 40;
			_loadingBarBGBlack.x = stage.stageWidth/2 - _loadingBarBGBlack.width/2;
			_loadingBarBGBlack.y = _loadingBarBGWhite.y + 1;
			_loadingBar.x = _loadingBarBGBlack.x + 1;
			_loadingBar.y = _loadingBarBGBlack.y + 1;
			
			_buffer.addChild(_bg);
			_buffer.addChild(_boardingText);
			_buffer.addChild(_infoText);
			
			_buffer.addChild(_loadingBarBGWhite);
			_buffer.addChild(_loadingBarBGBlack);
			_buffer.addChild(_loadingBar);			
			
		}
		
		override protected function update(Percent:Number):void {
			
			var ActualPercent:Number = root.loaderInfo.bytesLoaded / root.loaderInfo.bytesTotal;
			_loadingBar.scaleX = ActualPercent * 296;
						
			if (root.loaderInfo.bytesLoaded < root.loaderInfo.bytesTotal && getTimer() < _min) {
				_timer++;
				if (_timer % Math.floor(Math.random() * 40) == 0) {
					_timer = 0;
					_infoText.text = _loadingTexts[Math.floor(Math.random() * _loadingTexts.length)];
				}
			}
			else {
				_infoText.text = "";
				_buffer.addChild(_playButton);
				stage.addEventListener(MouseEvent.MOUSE_DOWN,mouseDown);
			}
			
		}
		
		private function mouseDown(e:MouseEvent):void {
			_min = 3000;
			stage.focus = null;
		}
		
	}
}