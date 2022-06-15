package
{
	import org.flixel.*;
	import flash.system.fscommand;
	import flash.display.*;
	import flash.geom.Rectangle;
	
//	[SWF(width = "600", height = "600", backgroundColor = "#FFFFFF")]
//	[Frame(factoryClass="Preloader")]
			
	public class SafetyInstructions extends FlxGame
	{		
		public function SafetyInstructions()
		{	
			super(75,50,StartScreen,8);
			
			this.useSoundHotKeys = false;
			FlxG.volume = 1.0;
			
			/////////////////////////////////
			
			FlxG.stage.showDefaultContextMenu = false;
			FlxG.stage.displayState = StageDisplayState.FULL_SCREEN;
			FlxG.stage.scaleMode = StageScaleMode.NO_SCALE;
			FlxG.stage.fullScreenSourceRect = new Rectangle(0,0,75*8,75*8);
			
			FlxG.stage.align = StageAlign.TOP;
			
			
			fscommand("trapallkeys","true");
		}
		
	}
}