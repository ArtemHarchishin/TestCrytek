package {
	import flash.display.MovieClip;

	public class ComponentView extends View {
		private var _listContainer:MovieClip;

		public function get listContainer():MovieClip {
			return _listContainer;
		}

		private var _checkboxContainer:MovieClip;

		public function get checkboxContainer():MovieClip {
			return _checkboxContainer;
		}

		public function ComponentView() {
			_listContainer = this["list_container"];
			_checkboxContainer = this["check_box_container"];
		}

		override protected function initialize():void {}

		override protected function dispose():void {
			_listContainer = null;
			_checkboxContainer = null;
		}
	}

}
