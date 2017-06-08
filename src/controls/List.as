package controls {
	import events.CollectionEventType;
	import events.DataEvent;
	import events.ItemEventType;

	import flash.display.DisplayObject;
	import flash.events.Event;

	import IListView;
	import ListView;

	[Event(name="select", type="flash.events.Event")]

	public class List extends Control {
		protected var _items:Array;
		protected var _view:IListView;

		protected var _selectedItem:Control;

		public function get selectedItem():Control {
			if (_selectedItem == null) return new Control({});
			return _selectedItem;
		}

		public function List() {
			itemType = Item;
			viewType = ListView;
		}

		override protected function initialize():void {
			_items = null;
			_selectedItem = null;
			_view = IListView(createView());
			addChild(DisplayObject(_view));
		}

		override protected function commitData():void {
			reset();
		}

		override protected function dispose():void {
			removeHandlersOfDataProvider();
			resetView();
			resetItems();
			removeChild(DisplayObject(_view));
			_view = null;
		}

		override protected function addHandlersToDataProvider():void {
			dataProvider.addEventListener(CollectionEventType.RESET, data_resetHandler);
			dataProvider.addEventListener(CollectionEventType.REMOVE_ITEM, data_removeItemHandler);
			dataProvider.addEventListener(CollectionEventType.ADD_ITEM, data_addItemHandler);
		}

		override protected function removeHandlersOfDataProvider():void {
			dataProvider.removeEventListener(CollectionEventType.RESET, data_resetHandler);
			dataProvider.removeEventListener(CollectionEventType.REMOVE_ITEM, data_removeItemHandler);
			dataProvider.removeEventListener(CollectionEventType.ADD_ITEM, data_addItemHandler);
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

		private function reset():void {
			resetView();

			resetItems();

			_items = [];

			var length:uint = dataProvider.getLength();
			for (var i:int = 0; i < length; i++) {
				var object:Object = dataProvider.getItemAt(i);
				var item:Control = createItem(object);
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
			dataProvider.removeItem(e.data['item']);
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
			var item:Control = createItem(e.data);
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
