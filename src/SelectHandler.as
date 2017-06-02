package {

	public class SelectHandler {
		private var _list:ListView;
		private var _items:Array;

		private var _selectedView:View;

		public function get selectedView():View {
			return _selectedView;
		}

		public function SelectHandler(list:ListView) {
			_list = list;
			_selectedView = null;
			_items = null;
		}

		public function dispose():void {
			resetItems();
			_list = null;
			_selectedView = null;
		}

		public function reset():void {
			resetItems();
			_items = [];
			var numItems:int = _list.numItems;
			for (var i:int = 0; i < numItems; i++) {
				var item:View = View(_list.getItemAt(i));
				item.addEventListener(ItemEventType.SELECT, view_selectHandler);
				_items.push(item);
			}
		}

		private function resetItems():void {
			if (_items) {
				removeHandlers();
				_items.length = 0;
				_items = null;
			}
		}

		private function removeHandlers():void {
			if (_items == null) return;

			var length:uint = _items.length;
			for (var i:int = 0; i < length; i++) {
				var item:View = View(_items[i]);
				item.removeEventListener(ItemEventType.SELECT, view_selectHandler);
			}
		}

		private function view_selectHandler(e:ViewEvent):void {
			trace(1);
			// TODO если удалить этот обьект в другом хендлере, то выпадает ошибка когда нажимаешь на другой айтем
			if (_selectedView == e.view) {
				return;
			}
			if (_selectedView) {
				_selectedView.selected = false;
			}
			_selectedView = e.view;
		}
	}
}
