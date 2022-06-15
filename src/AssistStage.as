package
{
	
	import org.flixel.*;
	
	public class AssistStage extends GameStage
	{
		public function AssistStage() {
			super();
		}
		
		public override function create():void {
			
			super.create();
			
			super.setup("AssistStage",
				Assets.AssistSheet,
				Assets._assistWidth,
				Assets._assistHeight,
				Assets._assistPreLoopFrames,
				Assets._assistWinFrames,
				Assets._assistPostWinFrames,
				Assets._assistFailFrames,
				Assets._assistPostFailFrames,
				null,
				Assets._assistText[GameState._difficultyLevel],
				Assets._assistResults);
		}
		
		public override function update():void {
			
			super.update();
			
			if ( _switchStage ) {
				FlxG.switchState( new BraceStage() );
			}
			
		}
	}
}