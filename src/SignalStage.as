package
{
	
	import org.flixel.*;
	
	public class SignalStage extends GameStage {
				
		private var _playingSignalPrePreLoop:Boolean = false;
		
		public function SignalStage() {
			super();
		}
		
		
		public override function create():void {
			
			super.create();
			
			if (GameState._bonusUnlocked) {
			super.setup("SignalStage",
				Assets.SignalPostShoveSheet,
				Assets._signalWidth,
				Assets._signalHeight,
				Assets._signalPreLoopFrames,
				Assets._signalWinFrames,
				Assets._signalPostWinFrames,
				Assets._signalFailFrames,
				Assets._signalPostFailFrames,
				null,
				Assets._signalText[GameState._difficultyLevel],
				Assets._signalResults);
			}
			else {
				super.setup("SignalStage",
					Assets.SignalSheet,
					Assets._signalWidth,
					Assets._signalHeight,
					Assets._signalPreLoopFrames,
					Assets._signalWinFrames,
					Assets._signalPostWinFrames,
					Assets._signalFailFrames,
					Assets._signalPostFailFrames,
					null,
					Assets._signalText[GameState._difficultyLevel],
					Assets._signalResults);
			}
		}
		
		public override function update():void {
			
			super.update();
			
			if (_playSignalPrePreLoop) {
				_preTimer.start(1,1,startLevel);
				_animations.addAnimation("prePreLoop",Assets._signalPreFrames,FRAMERATE*2,false);
				_animations.play("prePreLoop",true);
				_playSignalPrePreLoop = false;
				_playingSignalPrePreLoop = true;
			}
			else if (_animations.finished && _playingSignalPrePreLoop && !_won && !_lost) {
				_playPreLoop = true;
				_playingSignalPrePreLoop = false;
			}
			
			if ( _switchStage ) {
								
				if ( GameState._difficultyLevel == 2 ) {
					FlxG.switchState( new NextWeek() );
				}
				else {
					Globals._winner = true;
					FlxG.switchState( new PostPlay() );
				}
			}
			
		}
	}
}