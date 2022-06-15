package
{
	
	import org.flixel.*;
	
	public class LostStage extends GameStage
	{
		public function LostStage() {
			super();
		}
		
		public override function create():void {
			
			super.create();
			
			super.setup("LostStage",
				Assets.LostSheet,
				Assets._lostWidth,
				Assets._lostHeight,
				Assets._lostPreLoopFrames,
				null,
				null,
				Assets._lostFailFrames,
				Assets._lostPostFailFrames,
				Assets._lostImpactFrames,
				Assets._lostText[GameState._difficultyLevel],
				Assets._lostResults);
		}
		
		public override function update():void {
			
			super.update();
			
			if ( _switchStage ) {
				Globals._winner = true;
				FlxG.switchState( new PostPlay() );
			}
			
		}
	}
}