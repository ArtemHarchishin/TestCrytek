package {

	import flash.display.MovieClip;
	import flash.text.TextField;

	public class CheckBoxView extends View {
		private var _tfLabel:TextField;

		private var _checkbox:MovieClip;

		override public function set selected(value:Boolean):void {
			_checkbox.gotoAndStop(value ? 2 : 1);
		}

		override public function set label(value:String):void {
			if (_tfLabel.text != value) {
				_tfLabel.text = value;
			}
		}

		public function CheckBoxView() {
			_tfLabel = this["tf_label"];
			_checkbox = this["check_box"];
		}

		override protected function initialize():void {}

		override protected function dispose():void {
			_tfLabel = null;
			_checkbox = null;
		}
	}

}
