package {
	import flash.display.MovieClip;
	import flash.text.TextField;

	public class ItemView extends View {
		private var _tfLabel:TextField;
		private var _toggleSelect:MovieClip;

		override public function set selected(value:Boolean):void {
			_toggleSelect.gotoAndStop(value ? 2 : 1);
		}

		private var _btnDelete:MovieClip;

		public function get btnDelete():MovieClip {
			return _btnDelete;
		}

		private var _hitArea:MovieClip;

		public function get hittingArea():MovieClip {
			return _hitArea;
		}

		override public function set label(value:String):void {
			if (_tfLabel.text != value) {
				_tfLabel.text = value;
			}
		}

		public function ItemView() {
			_btnDelete = this["btn_delete"];
			_hitArea = this["hit_area"];
			_tfLabel = this["tf_label"];
			_toggleSelect = this["toggle_select"];
		}

		override protected function initialize():void {}

		override protected function dispose():void {
			_hitArea = null;
			_btnDelete = null;
			_tfLabel = null;
			_toggleSelect = null;
		}
	}
}
