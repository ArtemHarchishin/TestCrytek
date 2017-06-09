package {
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import flash.text.TextField;

	public class ComponentView extends View {
		private var _listContainer:MovieClip;

		public function get listContainer():MovieClip {
			return _listContainer;
		}

		private var _checkboxContainer:MovieClip;

		public function get checkboxContainer():MovieClip {
			return _checkboxContainer;
		}

		private var _tfFuzzySearch:TextField;

		public function get tfFuzzySearch():TextField {
			return _tfFuzzySearch;
		}

		public function ComponentView() {
			_listContainer = this["list_container"];
			_checkboxContainer = this["check_box_container"];
//			_tfFuzzySearch = this["tf_fuzzy_search"];
			_tfFuzzySearch = new TextField();
			_tfFuzzySearch.addEventListener(MouseEvent.CLICK, tfFuzzySearch_clickHandler);
		}

		override protected function initialize():void {}

		override protected function dispose():void {
			_listContainer = null;
			_checkboxContainer = null;
		}

		private function tfFuzzySearch_clickHandler(event:MouseEvent):void {
			_tfFuzzySearch.text = "";
			_tfFuzzySearch.removeEventListener(MouseEvent.CLICK, tfFuzzySearch_clickHandler);
		}
	}

}
