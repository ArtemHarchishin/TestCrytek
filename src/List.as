package {
	import flash.display.DisplayObject;
	import flash.events.Event;
	import flash.geom.Rectangle;

	public class List extends BaseControl {
		private var _selectedItem:BaseControl;

		protected var _itemFactory:Function;

		public function get itemFactory():Function {
			return _itemFactory;
		}

		public function set itemFactory(value:Function):void {
			if (_itemFactory === value) {
				return;
			}

			_itemFactory = value;
		}

		private var _dataProvider:Collection;

		public function get dataProvider():Collection {
			return _dataProvider;
		}

		public function set dataProvider(value:Collection):void {
			if (_dataProvider == value) {
				return;
			}
			if (_dataProvider) {
				_dataProvider.removeEventListener(CollectionEventType.ADD_ITEM, dataProvider_addItemHandler);
				_dataProvider.removeEventListener(CollectionEventType.REMOVE_ITEM, dataProvider_removeItemHandler);
				_dataProvider.removeEventListener(Event.CHANGE, dataProvider_changeHandler);
			}
			_dataProvider = value;
			if (_dataProvider) {
				_dataProvider.addEventListener(CollectionEventType.ADD_ITEM, dataProvider_addItemHandler);
				_dataProvider.addEventListener(CollectionEventType.REMOVE_ITEM, dataProvider_removeItemHandler);
				_dataProvider.addEventListener(Event.CHANGE, dataProvider_changeHandler);
			}
		}

		public function List() { }

		override protected function initialize():void {
			scrollRect = new Rectangle(0, 0, 240, 365);
			scroll_bar.addEventListener(Event.CHANGE, scrollbar_changeHandler);
		}

		override protected function draw():void {
			if (!isInitialized) return;

			while (items_container.numChildren) {
				items_container.removeChildAt(0);
			}

			var shiftY:Number = 0;
			var length:int = _dataProvider.getLength();
			for (var i:int = 0; i < length; i++) {
				var dataItem:Object = _dataProvider.getItemAt(i);
				var item:BaseControl = itemFactory(dataItem);
				item.data = dataItem;
				item.addEventListener(BaseControlEventType.SELECTED, item_selectedHandler);
				item.addEventListener(BaseControlEventType.DELETED, item_deletedHandler);
				items_container.addChild(DisplayObject(item));
				item.y = shiftY;
				shiftY = item.y + item.height;
			}
		}

		override protected function dispose():void {
			while (items_container.numChildren) {
				var childAt:* = items_container.getChildAt(0);
				childAt.removeEventListener(BaseControlEventType.SELECTED, item_selectedHandler);
				childAt.removeEventListener(BaseControlEventType.DELETED, item_deletedHandler);
				items_container.removeChildAt(0);
			}
			_itemFactory = null;
			dataProvider = null;
		}

		private function redraw():void {
			if (!isInitialized) return;

			var shiftY:Number = 0;
			for (var i:int = 0; i < items_container.numChildren; i++) {
				var item:BaseControl = BaseControl(items_container.getChildAt(i));
				item.y = shiftY;
				shiftY = item.y + item.height;
			}
		}

		private function dataProvider_addItemHandler(e:Event):void {
			draw();
		}

		private function dataProvider_removeItemHandler(e:Event):void {
			draw();
		}

		private function dataProvider_changeHandler(e:Event):void {
			redraw();
		}

		private function item_selectedHandler(e:DataEvent):void {
			var clickedItem:BaseControl = BaseControl(e.data);
			if (_selectedItem != clickedItem) {
				if (_selectedItem) {
					_selectedItem.deselect();
				}
				_selectedItem = clickedItem;
			}
			redraw();
		}

		private function item_deletedHandler(e:DataEvent):void {
			var deletedItem:BaseControl = BaseControl(e.data);
			var childIndex:int = items_container.getChildIndex(deletedItem);
			items_container.removeChildAt(childIndex);
			dataProvider.removeItem(deletedItem.data);
			redraw();
		}

		private function scrollbar_changeHandler(e:Event):void {
			if (items_container.height <= 365) return;
			items_container.y = -((items_container.height - 365) / 100 * scroll_bar.value);
		}
	}

}
