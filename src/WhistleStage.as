package
{
	
	import org.flixel.*;
	
	public class WhistleStage extends GameStage {
		
		private var _playingDrown:Boolean = false;
		private var _playPostDrown:Boolean = false;
		
		public function WhistleStage() {
			super();
		}
		
		
		public override function create():void {
			
			super.create();
			
			super.setup("WhistleStage",
				Assets.WhistleSheet,
				Assets._whistleWidth,
				Assets._whistleHeight,
				Assets._whistlePreLoopFrames,
				Assets._whistleWinFrames,
				Assets._whistlePostWinFrames,
				Assets._whistleFailFrames,
				Assets._whistlePostFailFrames,
				null,
				Assets._whistleText[GameState._difficultyLevel],
				Assets._whistleResults);
			
		}
		
		public override function update():void {
			
			super.update();
			
			if (_playDrown) {
				_animations.addAnimation("drownFrames",Assets._whistleDrownFrames,FRAMERATE,false);
				_animations.play("drownFrames",true);
				_playDrown = false;
				_playingDrown = true;
				_text.text = "";
			}
			
			if (_animations.finished && _playingDrown) {
				_animations.addAnimation("postDrownFrames",Assets._whistlePostDrownFrames,FRAMERATE,true);
				_animations.play("postDrownFrames",true);
				_lost = true;
				_playingDrown = false;
				_looping = true;
			}	
						
			if ( _switchStage && !GameState._bonusUnlocked ) {
				FlxG.switchState( new SignalStage() );
			}
			else if ( _switchStage && GameState._bonusUnlocked ) {
				FlxG.switchState( new ShoveStage() );
			}
			
		}
		
		public override function destroy():void {
			super.destroy();
		}
	}
}