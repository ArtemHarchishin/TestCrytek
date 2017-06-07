package {
	import flash.events.Event;

	public class List extends Control {
		protected var _items:Array;
		protected var _view:ListView;

		protected var _selectedItem:Control;

		public function get selectedItem():Control {
			if (_selectedItem == null) return new Control({});
			return _selectedItem;
		}

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
			data.addEventListener(CollectionEventType.RESET, data_resetHandler);
			data.addEventListener(CollectionEventType.REMOVE_ITEM, data_removeItemHandler);
			data.addEventListener(CollectionEventType.ADD_ITEM, data_addItemHandler);
			reset();
		}

		override protected function dispose():void {
			data.removeEventListener(CollectionEventType.RESET, data_resetHandler);
			data.removeEventListener(CollectionEventType.REMOVE_ITEM, data_removeItemHandler);
			data.removeEventListener(CollectionEventType.ADD_ITEM, data_addItemHandler);
			resetView();
			resetItems();
			removeChild(_view);
			_view = null;
		}

		private function reset():void {
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
				_view.addItem(item);
			}

			updatePosition();
		}

		private function reverse():void {
			_items.reverse();
			updatePosition();
		}

		protected function updatePosition():void {
			var shiftY:Number = 0;
			var length:int = _items.length;
			for (var i:int = 0; i < length; i++) {
				var item:Control = _items[i];
				item.y = shiftY;
				shiftY = item.y + item.height;
			}
		}

		private function resetView():void {
			while (_view.numItems) {
				_view.removeItemAt(0);
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

		protected function item_deleteHandler(e:DataEvent):void {
			data.removeItem((e.data as Item).data);
		}

		protected function item_selectHandler(e:DataEvent):void {
			if (_selectedItem == e.data) {
				return;
			}
			if (_selectedItem) {
				_selectedItem.selected = false;
			}
			_selectedItem = e.data as Control;
			dispatchEvent(new Event(Event.SELECT));
		}

		protected function data_removeItemHandler(e:DataEvent):void {
			var numItems:int = _items.length;
			for (var i:int = 0; i < numItems; i++) {
				var item:Control = _items[i];
				if (item.data == e.data) {
					if (item == _selectedItem) _selectedItem = null;
					_view.removeItem(item);
					var indexOf:int = _items.indexOf(item);
					_items.splice(indexOf, 1);
					break;
				}
			}

			updatePosition();
		}

		private function data_addItemHandler(e:DataEvent):void {
			var item:Control = new itemType(e.data);
			item.addEventListener(ItemEventType.DELETE, item_deleteHandler);
			item.addEventListener(ItemEventType.SELECT, item_selectHandler);

			_view.addItem(item);
			_items.push(item);

			updatePosition();
		}

		private function data_resetHandler(e:Event):void {
			reset();
		}
	}
}
