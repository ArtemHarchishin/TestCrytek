package {

	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import flash.text.TextField;

	public class CheckBoxView extends View {
		private var _tfLabel:TextField;

		private var _checkbox:MovieClip;

		override public function set selected(value:Boolean):void {
			if (_selected != value) {
				_selected = value;
				_checkbox.gotoAndStop(selected ? 2 : 1);
			}
		}

		public function set label(value:String):void {
			if (_tfLabel.text != value) {
				_tfLabel.text = value;
			}
		}

		public function CheckBoxView() {
			_tfLabel = this["tf_label"];
			_checkbox = this["check_box"];
		}

		override protected function commitData():void {
			label = dataToLabel(data);
		}

		override protected function initialize():void {
			_checkbox.addEventListener(MouseEvent.CLICK, checkbox_clickHandler);
		}

		override protected function dispose():void {
			_tfLabel = null;
			_checkbox.removeEventListener(MouseEvent.CLICK, checkbox_clickHandler);
			_checkbox = null;
		}

		private function checkbox_clickHandler(e:MouseEvent):void {
			selected = !selected;
			dispatchEvent(new ViewEvent(CheckBoxEventType.SELECT, this));
		}
	}

}
