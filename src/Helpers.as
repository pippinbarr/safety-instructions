package
{
	import flash.text.TextField;
	import flash.text.TextFormat;

	public class Helpers
	{
		public function Helpers()
		{
		}
		
		public static function makeTextField(x:uint, y:uint, w:uint, h:uint, s:String,tf:TextFormat):TextField {
			var textField:TextField = new TextField();
			textField.x = x;
			textField.y = y;
			textField.width = w;
			textField.height = h;
			textField.defaultTextFormat = tf;
			textField.text = s;
			textField.wordWrap = true;
			textField.selectable = false;
			textField.embedFonts = true;
			
			return textField;
		}
		
	}
}