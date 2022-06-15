package
{
	
	import org.flixel.*;
	
	public class SlideStage extends GameStage {
		
		public function SlideStage() {
			super();
		}
		
		
		public override function create():void {
			
			super.create();
			
			super.setup("SlideStage",
				Assets.SlideSheet,
				Assets._slideWidth,
				Assets._slideHeight,
				Assets._slidePreLoopFrames,
				Assets._slideWinFrames,
				Assets._slidePostWinFrames,
				Assets._slideFailFrames,
				Assets._slidePostFailFrames,
				Assets._slideImpactFrames,
				Assets._slideText[GameState._difficultyLevel],
				Assets._slideResults);
		}
		
		public override function update():void {
			
			super.update();
			
			if ( _switchStage && !GameState._bonusUnlocked ) {
				FlxG.switchState( new WhistleStage() );
			}
			else if ( _switchStage && GameState._bonusUnlocked ) {
				FlxG.switchState( new DodgeStage() );
			}
			
		}
	}
}