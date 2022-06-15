package
{
	
	import org.flixel.*;
	
	public class BraceStage extends GameStage
	{
		public function BraceStage() {
			super();
		}
		
		public override function create():void {
			
			super.create();
			
			super.setup("BraceStage",
						Assets.BraceSheet,
						Assets._braceWidth,
						Assets._braceHeight,
						Assets._bracePreLoopFrames,
						Assets._braceWinFrames,
						Assets._bracePostWinFrames,
						Assets._braceFailFrames,
						Assets._bracePostFailFrames,
						Assets._braceImpactFrames,
						Assets._braceText[GameState._difficultyLevel],
						Assets._braceResults);
		}
		
		public override function update():void {
			
			super.update();
			
			if (_switchStage) {
				FlxG.switchState( new CrashStage() );
			}
						
		}
	}
}