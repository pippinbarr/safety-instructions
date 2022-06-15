package
{
	import flash.text.*;
	import org.flixel.*;
		
	public class SafetyButton extends FlxButton
	{
		public var _buttonLabel:TextField;
		private var _labelFormat:TextFormat;
		
		public function SafetyButton(X:Number=0, Y:Number=0, Label:String=null, OnClick:Function=null)
		{
			super(X, Y, "", OnClick);
			
			super.loadGraphic(Assets.ButtonSheet,false,false,15,5);
			
			_labelFormat = new TextFormat("Silkscreen",12,0x000000,null,null,null,null,null,"center",null,null,null,null);

			_buttonLabel = new TextField();
			_buttonLabel.defaultTextFormat = _labelFormat;
			_buttonLabel.selectable = false;
			_buttonLabel.embedFonts = true;
			_buttonLabel.text = Label;
			_buttonLabel.x = (X * 8) + 8, _buttonLabel.y = (Y * 8) + 11;

			FlxG.stage.addChild(_buttonLabel);
		}
		
		
		public override function update():void {
			super.update();
			if (!FlxG.mouse.pressed() && frame == PRESSED) frame = NORMAL;
		}
		
		public function setLabel(text:String):void {
			_buttonLabel.text = text;
		}
		
		public override function destroy():void {
			_buttonLabel.visible = false;
			super.destroy()
		}
	}
}