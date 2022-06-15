package
{
	
	import org.flixel.*;
	
	public class LuggageStage extends GameStage
	{
		public function LuggageStage() {
			super();
		}
		
		public override function create():void {
			
			super.create();
			
			super.setup("LuggageStage",
				Assets.LuggageSheet,
				Assets._luggageWidth,
				Assets._luggageHeight,
				Assets._luggagePreLoopFrames,
				Assets._luggageWinFrames,
				Assets._luggagePostWinFrames,
				Assets._luggageFailFrames,
				Assets._luggagePostFailFrames,
				Assets._luggageImpactFrames,
				Assets._luggageText[GameState._difficultyLevel],
				Assets._luggageResults);
		}
		
		public override function update():void {
			
			super.update();
			
			if ( _switchStage ) {
				FlxG.switchState( new CrawlStage() );
			}
			
		}
	}
}