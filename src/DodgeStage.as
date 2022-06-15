package
{
	
	import org.flixel.*;
	
	public class DodgeStage extends GameStage
	{
		
		private var _playingDrown:Boolean = false;
		private var _playPostDrown:Boolean = false;
		
		public function DodgeStage() {
			super();
		}
		
		public override function create():void {
			
			super.create();
			
			//GameState._inflateSuccess = true;
			
			super.setup("DodgeStage",
				Assets.DodgeSheet,
				Assets._dodgeWidth,
				Assets._dodgeHeight,
				Assets._dodgePreLoopFrames,
				Assets._dodgeWinFrames,
				Assets._dodgePostWinFrames,
				Assets._dodgeFailFrames,
				Assets._dodgePostFailFrames,
				null,
				Assets._dodgeText[GameState._difficultyLevel],
				Assets._dodgeResults);
		}
		
		public override function update():void {
			
			super.update();
			
			if (_playDrown) {
				_animations.addAnimation("drownFrames",Assets._dodgeDrownFrames,FRAMERATE,false);
				_animations.play("drownFrames",true);
				_playDrown = false;
				_playingDrown = true;
				_text.text = "";
			}
			
			if (_animations.finished && _playingDrown) {
				_animations.addAnimation("postDrownFrames",Assets._dodgePostDrownFrames,FRAMERATE,true);
				_animations.play("postDrownFrames",true);
				_lost = true;
				_playingDrown = false;
				_looping = true;
			}
			
			if ( _switchStage ) {
				FlxG.switchState( new WhistleStage() );
			}
			
		}
	}
}