package
{
	
	import org.flixel.*;
	
	public class Globals
	{
		
		public static var _gameLoaded:Boolean = false;
		
		public static var _firstTimeBonus:Boolean = false;
		public static var _firstTimeNightmare:Boolean = false;

		public static var _winner:Boolean = false;
		
		public static var _finalAnimation:FlxSprite = null;
		public static var _finalAnimationFrames:Array = null;
		public static var _finalAnimationStartFrame:uint = 0;
		
		public function Globals()
		{
		}
	}
}