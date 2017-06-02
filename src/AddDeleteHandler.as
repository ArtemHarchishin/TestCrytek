package {

	public class AddDeleteHandler {
		private var _list:ListView;
		private var _dataProvider:Collection;
		private var _items:Array;

		public function AddDeleteHandler(list:ListView, dataProvider:Collection) {
			_list = list;
			_dataProvider = dataProvider;
			_dataProvider.addEventListener(CollectionEventType.REMOVE_ITEM, data_removeItemHandler);
			_dataProvider.addEventListener(CollectionEventType.ADD_ITEM, dataProvider_addItemHandler);
			_items = null;
		}

		public function dispose():void {
			resetItems();
			_list = null;
			_dataProvider.removeEventListener(CollectionEventType.ADD_ITEM, dataProvider_addItemHandler);
			_dataProvider.removeEventListener(CollectionEventType.REMOVE_ITEM, data_removeItemHandler);
			_dataProvider = null;
		}

		public function reset():void {
			resetItems();
			_items = [];
			var numItems:int = _list.numItems;
			for (var i:int = 0; i < numItems; i++) {
				var item:View = View(_list.getItemAt(i));
				item.addEventListener(ItemEventType.DELETE, view_deleteHandler);
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
				item.removeEventListener(ItemEventType.DELETE, view_deleteHandler);
			}
		}

		private function updatePosition():void {
			var shiftY:Number = 0;
			var length:int = _items.length;
			for (var i:int = 0; i < length; i++) {
				var item:View = View(_items[i]);
				item.y = shiftY;
				shiftY = item.y + item.height;
			}
		}

		private function view_deleteHandler(e:ViewEvent):void {
			_dataProvider.removeItem(e.view.data);
		}

		private function dataProvider_addItemHandler(e:DataEvent):void {
			var item:ItemView = new ItemView();
			item.data = e.data;
			// TODO при добавлении айтэма, надо добавлять ему обработку события select
			item.addEventListener(ItemEventType.DELETE, view_deleteHandler);
			_list.addItem(item);
			_items.push(item);

			updatePosition();
		}

		private function data_removeItemHandler(e:DataEvent):void {
			var numItems:int = _list.numItems;
			for (var i:int = 0; i < numItems; i++) {
				var item:View = View(_list.getItemAt(i));
				if (item.data == e.data) {
					_list.removeItem(item);
					var indexOf:int = _items.indexOf(item);
					_items.splice(indexOf, 1);
					break;
				}
			}

			updatePosition();
		}
	}
}
