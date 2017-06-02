package old {
	import flash.display.MovieClip;
	import flash.text.TextField;

	public class AssetWrapper {
		private var _control:Control;
		private var _asset:*;

		private var _btn_delete:MovieClip;

		public function get btn_delete():MovieClip {
			return _btn_delete;
		}

		private var _hit_area:MovieClip;

		public function get hit_area():MovieClip {
			return _hit_area;
		}

		private var _tf_label:TextField;

		public function get tf_label():TextField {
			return _tf_label;
		}

		private var _expander:MovieClip;

		public function get expander():MovieClip {
			return _expander;
		}

		private var _items_container:MovieClip;

		public function get items_container():MovieClip {
			return _items_container;
		}

		public function AssetWrapper(assetClass:Class, control:Control) {
			_asset = new assetClass();
			_control = control;
			_control.addChild(_asset);
			_btn_delete = _asset["btn_delete"];
			_btn_delete ||= new MovieClip();
			_hit_area = _asset["hit_area"];
			_hit_area ||= new MovieClip();
			_tf_label = _asset["tf_label"];
			_tf_label ||= new TextField();
			_expander = _asset["expander"];
			_expander ||= new MovieClip();
			_items_container = _asset["items_container"];
			_items_container ||= new MovieClip();
		}

		public function dispose():void {
			if (_control && _asset) {
				_control.removeChild(_asset);
				_asset = null;
				_control = null;
			}
			_btn_delete = null;
			_hit_area = null;
			_tf_label = null;
			_expander = null;
			_items_container = null;
		}
	}
}
