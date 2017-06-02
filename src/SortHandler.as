package {
	public class SortHandler {
		private var _component:ComponentView;
		private var _list:List;
		private var _dataProvider:Collection;

		public function SortHandler(component:ComponentView, list:List, dataProvider:Collection) {
			_component = component;
			_component.addEventListener(ComponentEventType.NEW_OLD_SORT, component_new_old_sortHandler);
			_list = list;
			_dataProvider = dataProvider;
			_dataProvider.addEventListener(CollectionEventType.SORT_REVERSE, dataProvider_sortReverseHandler);
		}

		public function dispose():void {
			_component.removeEventListener(CheckBoxEventType.SELECT, component_new_old_sortHandler);
			_component = null;
			_list = null;
			_dataProvider = null;
		}

		private function component_new_old_sortHandler(e:ViewEvent):void {
			_dataProvider.reverse();
		}

		private function dataProvider_sortReverseHandler(e:DataEvent):void {
			_list.reverse();
		}
	}
}
