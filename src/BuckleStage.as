package
{
	
	import org.flixel.*;
	
	public class BuckleStage extends GameStage
	{
		public function BuckleStage()
		{
			super();
			
			super.setup("BuckleStage",
				Assets.BuckleSheet,
				Assets._buckleWidth,
				Assets._buckleHeight,
				Assets._bucklePreLoopFrames,
				Assets._buckleWinFrames,
				Assets._bucklePostWinFrames,
				Assets._buckleFailFrames,
				Assets._bucklePostFailFrames,
				Assets._buckleImpactFrames,
				Assets._buckleText[GameState._difficultyLevel],
				Assets._buckleResults);
		}
		
		public override function create():void {
			
			super.create();
			
			
		}
		
		public override function update():void {
			
			super.update();
			
			if ( _switchStage ) {
				FlxG.switchState( new BreatheStage() );
			}
			
		}
		
	}
}