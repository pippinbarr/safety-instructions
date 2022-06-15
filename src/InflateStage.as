package
{
	
	import org.flixel.*;
	
	public class InflateStage extends GameStage {
		
		public function InflateStage() {
			super();
		}
		
		
		public override function create():void {
			
			super.create();
			
			super.setup("InflateStage",
				Assets.InflateSheet,
				Assets._inflateWidth,
				Assets._inflateHeight,
				Assets._inflatePreLoopFrames,
				Assets._inflateWinFrames,
				Assets._inflatePostWinFrames,
				Assets._inflateFailFrames,
				Assets._inflatePostFailFrames,
				null,
				Assets._inflateText[GameState._difficultyLevel],
				Assets._inflateResults);
		}
		
		public override function update():void {
			
			super.update();
			
			if ( _switchStage ) {
				FlxG.switchState( new SlideStage() );
			}
			
		}
	}
}