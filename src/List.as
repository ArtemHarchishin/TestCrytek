package {
	public class List extends Control {
		private var _items:Array;
		private var _selectedItem:Control;

		private function get view():ListView {return _view as ListView;}

		protected var _itemType:Class = Item;

		public function get itemType():Class {
			return _itemType;
		}

		public function set itemType(value:Class):void {
			if (_itemType == value) {
				return;
			}
			_itemType = value;
		}

		public function List(data:Collection) {
			super(data);
		}

		override protected function initialize():void {
			_items = null;
			_selectedItem = null;
			_view = new ListView();
			addChild(_view);
		}

		override protected function commitData():void {
			data.addEventListener(CollectionEventType.REMOVE_ITEM, data_removeItemHandler);
			data.addEventListener(CollectionEventType.ADD_ITEM, dataProvider_addItemHandler);
			reset();
		}

		override protected function dispose():void {
			resetView();
			resetItems();
			data.removeEventListener(CollectionEventType.ADD_ITEM, dataProvider_addItemHandler);
			data.removeEventListener(CollectionEventType.REMOVE_ITEM, data_removeItemHandler);
			removeChild(_view);
		}

		public function reset():void {
			resetView();

			resetItems();

			_items = [];

			var length:uint = data.getLength();
			for (var i:int = 0; i < length; i++) {
				var object:Object = data.getItemAt(i);
				var item:Control = new itemType(object);
				item.addEventListener(ItemEventType.SELECT, item_selectHandler);
				item.addEventListener(ItemEventType.DELETE, item_deleteHandler);
				_items.push(item);
				view.addItem(item);
			}

			updatePosition();
		}

		public function reverse():void {
			_items.reverse();
			updatePosition();
		}

		private function resetView():void {
			while (view.numItems) {
				view.removeItemAt(0);
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
				var item:Control = _items[i];
				item.removeEventListener(ItemEventType.SELECT, item_selectHandler);
				item.removeEventListener(ItemEventType.DELETE, item_deleteHandler);
			}
		}

		private function updatePosition():void {
			var shiftY:Number = 0;
			var length:int = _items.length;
			for (var i:int = 0; i < length; i++) {
				var item:Control = _items[i];
				item.y = shiftY;
				shiftY = item.y + item.height;
			}
		}

		private function item_deleteHandler(e:DataEvent):void {
			data.removeItem(e.data);
		}

		private function dataProvider_addItemHandler(e:DataEvent):void {
			var item:Control = new itemType(e.data);
			item.addEventListener(ItemEventType.DELETE, item_deleteHandler);
			item.addEventListener(ItemEventType.SELECT, item_selectHandler);

			view.addItem(item);
			_items.push(item);

			updatePosition();
		}

		private function data_removeItemHandler(e:DataEvent):void {
			var numItems:int = _items.length;
			for (var i:int = 0; i < numItems; i++) {
				var item:Control = _items[i];
				if (item.data == e.data) {
					if (item == _selectedItem) _selectedItem = null;
					view.removeItem(item);
					var indexOf:int = _items.indexOf(item);
					_items.splice(indexOf, 1);
					break;
				}
			}

			updatePosition();
		}

		private function item_selectHandler(e:DataEvent):void {
			if (_selectedItem == e.data) {
				return;
			}
			if (_selectedItem) {
				_selectedItem.selected = false;
			}
			_selectedItem = e.data as Control;
		}
	}
}
