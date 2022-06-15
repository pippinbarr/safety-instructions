package
{
	
	import org.flixel.*;
	
	public class GameState
	{
		
		private static var _save:FlxSave;
		private static var _loaded:Boolean = false;
		
		private static var _tempNightmareUnlocked:Boolean = false;
		private static var _tempBonusUnlocked:Boolean = false;
		private static var _tempInflateSuccess:Boolean = false;
		private static var _tempCurrentStageName:String = null;
		private static var _tempDifficultyLevel:int = 0;		
		
		public function GameState()
		{
		}
		
		public static function load():void {
			
			_save = new FlxSave();
			_loaded = _save.bind("SafeInstructionsSaveData");
			
			trace("_loaded: " + _loaded + " | _currentStageName: " + _save.data.currentStageName);
			
			if (_loaded && _save.data.nightmareUnlocked == null) _save.data.nightmareUnlocked = false;
			if (_loaded && _save.data.bonusUnlocked == null) _save.data.bonusUnlocked = false;
			if (_loaded && _save.data.inflateSuccess == null) _save.data.inflateSuccess = false;
			if (_loaded && _save.data.difficultyLevel == null) _save.data.difficultyLevel = 0;
			if (_loaded && _save.data.currentStageName == null) _save.data.currentStageName = null;

			trace("Post null checks: _loaded: " + _loaded + " | _currentStageName: " + _save.data.currentStageName);
			
		}
		
		public static function flush():void {
			if (_loaded) _save.flush();
		}
		
		public static function erase():void {
			if (_loaded) _save.erase();
		}
				
		public static function set _nightmareUnlocked(value:Boolean):void {
			if (_loaded)
			{
				_save.data.nightmareUnlocked = value;
			}
			else
			{
				_tempNightmareUnlocked = value;
			}
		}
		
		public static function get _nightmareUnlocked():Boolean {
			if (_loaded)
			{
				return _save.data.nightmareUnlocked;
			}
			else
			{
				return _tempNightmareUnlocked;
			}
		}
		
		public static function set _bonusUnlocked(value:Boolean):void {
			if (_loaded)
			{
				_save.data.bonusUnlocked = value;
			}
			else
			{
				_tempBonusUnlocked = value;
			}
		}
		
		public static function get _bonusUnlocked():Boolean {
			if (_loaded)
			{
				return _save.data.bonusUnlocked;
			}
			else
			{
				return _tempBonusUnlocked;
			}
		}
		
		public static function set _inflateSuccess(value:Boolean):void {
			if (_loaded)
			{
				_save.data.inflateSuccess = value;
			}
			else
			{
				_tempInflateSuccess = value;
			}
		}
		
		public static function get _inflateSuccess():Boolean {
			if (_loaded)
			{
				return _save.data.inflateSuccess;
			}
			else
			{
				return _tempInflateSuccess;
			}
		}
		
		public static function set _difficultyLevel(value:int):void {
			if (_loaded)
			{
				_save.data.difficultyLevel = value;
			}
			else
			{
				_tempDifficultyLevel = value;
			}
		}
		
		public static function get _difficultyLevel():int {
			if (_loaded)
			{
				return _save.data.difficultyLevel;
			}
			else
			{
				return _tempDifficultyLevel;
			}
		}
		
		public static function set _currentStageName(value:String):void {
			if (_loaded)
			{
				_save.data.currentStageName = value;
			}
			else
			{
				_tempCurrentStageName = value;
			}
		}
		
		public static function get _currentStageName():String {
			if (_loaded)
			{
				return _save.data.currentStageName;
			}
			else
			{
				return _tempCurrentStageName;
			}
		}
	}
}