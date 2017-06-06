package {
	public class GroupedList extends Control {
		protected var _items:Array;
		protected var _selectedItem:Control;

		protected var _view:ListView;

		override protected function get view():View {return _view as View;}

		protected var _itemType:Class = GroupItem;

		public function get itemType():Class {
			return _itemType;
		}

		public function set itemType(value:Class):void {
			if (_itemType == value) {
				return;
			}
			_itemType = value;
		}

		public function GroupedList(data:GroupedCollection) {
			super(data);
		}

		override protected function initialize():void {
			_items = null;
			_selectedItem = null;
			_view = new ListView();
			addChild(_view);
		}

		override protected function commitData():void {
			data.addEventListener(CollectionEventType.REMOVE_GROUP_ITEM, data_removeGroupItemHandler);
			data.addEventListener(CollectionEventType.REMOVE_ITEM, data_removeItemHandler);
			data.addEventListener(CollectionEventType.ADD_ITEM, data_addItemHandler);
			data.removeEventListener(CollectionEventType.ADD_GROUP_ITEM, data_addGroupItemHandler);
			reset();
		}

		override protected function dispose():void {
			data.removeEventListener(CollectionEventType.REMOVE_GROUP_ITEM, data_removeGroupItemHandler);
			data.removeEventListener(CollectionEventType.REMOVE_ITEM, data_removeItemHandler);
			data.removeEventListener(CollectionEventType.ADD_ITEM, data_addItemHandler);
			data.removeEventListener(CollectionEventType.ADD_GROUP_ITEM, data_addGroupItemHandler);
			resetView();
			resetItems();
			removeChild(_view);
			_view = null;
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
				item.removeEventListener(ItemEventType.GROUP_DELETE, itemGroup_deleteHandler);
				item.removeEventListener(ItemEventType.GROUP_SELECT, itemGroup_selectHandler);
			}
		}

		protected function item_deleteHandler(e:DataEvent):void {
			data.removeItem((e.data as Item).data);
		}

		protected function data_removeItemHandler(e:DataEvent):void {
//			var numItems:int = _items.length;
//			for (var i:int = 0; i < numItems; i++) {
//				var groupItem:GroupItem = _items[i];
//				if (groupItem.data == e.data) {
//					if (groupItem.has(_selectedItem)) _selectedItem = null;
//					_view.removeItem(groupItem);
//					var indexOf:int = _items.indexOf(groupItem);
//					_items.splice(indexOf, 1);
//					break;
//				}
//			}
//
//			updatePosition();
		}

		protected function item_selectHandler(e:DataEvent):void {
			if (_selectedItem == e.data) {
				return;
			}
			if (_selectedItem) {
				_selectedItem.selected = false;
			}
			_selectedItem = e.data as Control;
		}

		private function data_addItemHandler(e:DataEvent):void {
			var item:Control = new itemType(e.data);
			// TODO add group item
			item.addEventListener(ItemEventType.DELETE, item_deleteHandler);
			item.addEventListener(ItemEventType.SELECT, item_selectHandler);

			_view.addItem(item);
			_items.push(item);

			updatePosition();
		}

		private function data_removeGroupItemHandler(e:DataEvent):void {
			var numItems:int = _items.length;
			for (var i:int = 0; i < numItems; i++) {
				var item:GroupItem = _items[i];
				if (item.data == e.data) {
					if (item.has(_selectedItem)) _selectedItem = null;
					_view.removeItem(item);
					var indexOf:int = _items.indexOf(item);
					_items.splice(indexOf, 1);
					break;
				}
			}

			updatePosition();
		}

		private function itemGroup_deleteHandler(e:DataEvent):void {
			data.removeGroupItem((e.data as GroupItem).data);
		}

		private function itemGroup_selectHandler(e:DataEvent):void {
			updatePosition();
		}

		private function data_addGroupItemHandler(e:DataEvent):void {
		}
	}
}
