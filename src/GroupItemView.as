package {
	import flash.display.MovieClip;
	import flash.text.TextField;

	public class GroupItemView extends View {
		private var _tfLabel:TextField;
		private var _hitArea:MovieClip;

		override public function set selected(value:Boolean):void {
			_toggleSelect.gotoAndStop(value ? 2 : 1);
			_itemsContainer.visible = value;
		}

		override public function set label(value:String):void {
			if (_tfLabel.text != value) {
				_tfLabel.text = value;
			}
		}

		private var _toggleSelect:MovieClip;

		public function get toggleSelect():MovieClip {
			return _toggleSelect;
		}

		private var _itemsContainer:MovieClip;

		public function get itemsContainer():MovieClip {
			return _itemsContainer;
		}

		private var _btnDelete:MovieClip;

		public function get btnDelete():MovieClip {
			return _btnDelete;
		}

		public function get hittingArea():MovieClip {
			return _hitArea;
		}

		public function GroupItemView() {
			_btnDelete = this["btn_delete"];
			_hitArea = this["hit_area"];
			_tfLabel = this["tf_label"];
			_toggleSelect = this["expander"];
			_itemsContainer = this["items_container"];
			_itemsContainer.visible = false;
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
