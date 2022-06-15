package
{
	
	import org.flixel.*;
	
	public class ShoveStage extends GameStage
	{
		public function ShoveStage() {
			super();
		}
		
		public override function create():void {
			
			super.create();
			
			super.setup("ShoveStage",
				Assets.ShoveSheet,
				Assets._shoveWidth,
				Assets._shoveHeight,
				Assets._shovePreLoopFrames,
				Assets._shoveWinFrames,
				Assets._shovePostWinFrames,
				Assets._shoveFailFrames,
				Assets._shovePostFailFrames,
				Assets._shoveImpactFrames,
				Assets._shoveText[GameState._difficultyLevel],
				Assets._shoveResults);
		}
		
		public override function update():void {
			
			super.update();
			
			if ( _switchStage ) {
				FlxG.switchState( new SignalStage() );
			}
			
		}
	}
}