package {
	import flash.events.Event;

	public class GroupedList extends Control {
		protected var _items:Array;
		protected var _view:ListView;

		protected var _selectedItem:Control;

		public function get selectedItem():Control {
			if (_selectedItem == null) return new Control({});
			return _selectedItem;
		}

		public function GroupedList() {
			itemType = GroupItem;
		}

		override protected function initialize():void {
			_items = null;
			_selectedItem = null;
			_view = new ListView();
			addChild(_view);
		}

		override protected function commitData():void {
			reset();
		}

		override protected function dispose():void {
			removeHandlersOfDataProvider();
			resetView();
			resetItems();
			removeChild(_view);
			_view = null;
		}

		override protected function addHandlersToDataProvider():void {
			dataProvider.addEventListener(CollectionEventType.RESET, data_resetHandler);
			dataProvider.addEventListener(CollectionEventType.REMOVE_GROUP_ITEM, data_removeGroupItemHandler);
			dataProvider.addEventListener(CollectionEventType.REMOVE_ITEM, data_removeItemHandler);
			dataProvider.addEventListener(CollectionEventType.ADD_ITEM, data_addItemHandler);
			dataProvider.addEventListener(CollectionEventType.ADD_GROUP_ITEM, data_addGroupItemHandler);
		}

		override protected function removeHandlersOfDataProvider():void {
			dataProvider.removeEventListener(CollectionEventType.RESET, data_resetHandler);
			dataProvider.removeEventListener(CollectionEventType.REMOVE_GROUP_ITEM, data_removeGroupItemHandler);
			dataProvider.removeEventListener(CollectionEventType.REMOVE_ITEM, data_removeItemHandler);
			dataProvider.removeEventListener(CollectionEventType.ADD_ITEM, data_addItemHandler);
			dataProvider.removeEventListener(CollectionEventType.ADD_GROUP_ITEM, data_addGroupItemHandler);
		}

		public function reset():void {
			resetView();

			resetItems();

			_items = [];

			var length:uint = dataProvider.getLength();
			for (var i:int = 0; i < length; i++) {
				var object:Object = dataProvider.getItemAt(i);
				var item:Control = createItem(object);
				item.addEventListener(ItemEventType.SELECT, item_selectHandler);
				item.addEventListener(ItemEventType.DELETE, item_deleteHandler);
				item.addEventListener(ItemEventType.GROUP_DELETE, itemGroup_deleteHandler);
				item.addEventListener(ItemEventType.GROUP_SELECT, itemGroup_selectHandler);
				_items.push(item);
				_view.addItem(item);
			}

			updatePosition();
		}

		public function reverse():void {
			_items.reverse();
			updatePosition();
		}

		override public function updatePosition():void {
			var shiftY:Number = 0;
			var length:int = _items.length;
			for (var i:int = 0; i < length; i++) {
				var item:Control = _items[i];
				item.updatePosition();
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
				item.removeEventListener(ItemEventType.GROUP_DELETE, itemGroup_deleteHandler);
				item.removeEventListener(ItemEventType.GROUP_SELECT, itemGroup_selectHandler);
			}
		}

		protected function data_removeItemHandler(e:DataEvent):void {
			reset();
		}

		private function data_addItemHandler(e:DataEvent):void {
			reset();
		}

		private function data_addGroupItemHandler(e:DataEvent):void {
			var item:Control = createItem(e.data);
			item.addEventListener(ItemEventType.DELETE, item_deleteHandler);
			item.addEventListener(ItemEventType.SELECT, item_selectHandler);
			item.addEventListener(ItemEventType.GROUP_DELETE, itemGroup_deleteHandler);
			item.addEventListener(ItemEventType.GROUP_SELECT, itemGroup_selectHandler);

			_items.push(item);
			_view.addItem(item);

			updatePosition();
		}

		private function data_removeGroupItemHandler(e:DataEvent):void {
			var numItems:int = _items.length;
			for (var i:int = 0; i < numItems; i++) {
				var item:Control = _items[i];
				if (item.data == e.data) {
					if (item.selected) _selectedItem = null;
					_view.removeItem(item);
					var indexOf:int = _items.indexOf(item);
					_items.splice(indexOf, 1);
					break;
				}
			}

			updatePosition();
		}

		private function data_resetHandler(e:Event):void {
			reset();
		}

		protected function item_deleteHandler(e:DataEvent):void {
			dataProvider.removeItem(e.data['own'], e.data['item']);
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

		private function itemGroup_deleteHandler(e:DataEvent):void {
			dataProvider.removeItem(e.data['own'], e.data['item']);
		}

		private function itemGroup_selectHandler(e:DataEvent):void {
			updatePosition();
		}
	}
}
