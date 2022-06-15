package
{
	
	import org.flixel.*;
	
	public class OpenStage extends GameStage {
		
		public function OpenStage() {
			super();
		}
		
		
		public override function create():void {
			
			super.create();
			
			super.setup("OpenStage",
				Assets.OpenSheet,
				Assets._openWidth,
				Assets._openHeight,
				Assets._openPreLoopFrames,
				Assets._openWinFrames,
				Assets._openPostWinFrames,
				Assets._openFailFrames,
				Assets._openPostFailFrames,
				Assets._openImpactFrames,
				Assets._openText[GameState._difficultyLevel],
				Assets._openResults);
		}
		
		public override function update():void {
			
			super.update();
			
			if ( _switchStage ) {
				FlxG.switchState( new InflateStage() );
			}
			
		}
	}
}