package
{
	
	import org.flixel.*;
	
	public class CrawlStage extends GameStage
	{
		public function CrawlStage() {
			super();
		}
		
		public override function create():void {
			
			super.create();
			
			super.setup("CrawlStage",
				Assets.CrawlSheet,
				Assets._crawlWidth,
				Assets._crawlHeight,
				Assets._crawlPreLoopFrames,
				Assets._crawlWinFrames,
				Assets._crawlPostWinFrames,
				Assets._crawlFailFrames,
				Assets._crawlPostFailFrames,
				null,
				Assets._crawlText[GameState._difficultyLevel],
				Assets._crawlResults);
		}
		
		public override function update():void {
			
			super.update();
			
			if ( _switchStage ) {
				FlxG.switchState( new OpenStage() );
			}
			
		}
	}
}