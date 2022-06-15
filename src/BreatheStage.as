package
{
	
	import org.flixel.*;
	
	public class BreatheStage extends GameStage {
		
		public function BreatheStage() {
			super();
		}
		
		
		public override function create():void {
			
			super.create();
			
			super.setup("BreatheStage",
						Assets.BreatheSheet,
						Assets._breatheWidth,
						Assets._breatheHeight,
						Assets._breathePreLoopFrames,
						Assets._breatheWinFrames,
						Assets._breathePostWinFrames,
						Assets._breatheFailFrames,
						Assets._breathePostFailFrames,
						null,
						Assets._breatheText[GameState._difficultyLevel],
						Assets._breatheResults);
		}
		
		public override function update():void {
			
			super.update();
			
			if ( _switchStage && !GameState._bonusUnlocked) {
				FlxG.switchState( new BraceStage() );
			}
			else if (_switchStage && GameState._bonusUnlocked) {
				FlxG.switchState( new AssistStage() );
			}
			
		}
	}
}