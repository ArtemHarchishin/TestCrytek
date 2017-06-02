package {
	import flash.display.MovieClip;
	import flash.events.Event;

	public class ComponentView extends View {
		private var _listContainer:MovieClip;

		public function get listContainer():MovieClip {
			return _listContainer;
		}

		private var _sortByOldCheckbox:CheckBoxView;

		public function get sortByOldCheckbox():CheckBoxView {
			return _sortByOldCheckbox;
		}

		public function ComponentView() {
			_listContainer = this["list_container"];
			_sortByOldCheckbox = this["sort_by_old"];
		}

		override protected function initialize():void {
			_sortByOldCheckbox.addEventListener(CheckBoxEventType.SELECT, sortByOldCheckbox_selectHandler);
		}

		override protected function dispose():void {
			_sortByOldCheckbox.removeEventListener(CheckBoxEventType.SELECT, sortByOldCheckbox_selectHandler);
			_listContainer = null;
			_sortByOldCheckbox = null;
		}

		private function sortByOldCheckbox_selectHandler(e:Event):void {
			dispatchEvent(new ViewEvent(ComponentEventType.NEW_OLD_SORT, this));
		}
	}

}
