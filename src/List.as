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

		public function List() { }

		override protected function initialize():void {
			if (isInitialized) return;

			scrollRect = new Rectangle(0, 0, 240, 365);
			scroll_bar.addEventListener(Event.CHANGE, scrollbar_changeHandler);
		}

		override protected function draw():void {
			if (!isInitialized) return;

			while (items_container.numChildren) {
				items_container.removeChildAt(0);
			}

			var shiftY:Number = 0;
			var length:int = dataProvider.getLength();
			for (var i:int = 0; i < length; i++) {
				var dataItem:Object = dataProvider.getItemAt(i);
				var item:BaseControl = itemFactory(i);
				item.dataProvider = dataProvider;
				item.data = dataItem;
				item.own = this;
				item.addEventListener(BaseControlEventType.SELECTED, item_selectedHandler);
				items_container.addChild(DisplayObject(item));
				item.y = shiftY;
				shiftY = item.y + item.height;
			}

			scroll_bar.visible = items_container.height > 365;
		}

		override protected function dispose():void {
			while (items_container.numChildren) {
				var childAt:* = items_container.getChildAt(0);
				childAt.removeEventListener(BaseControlEventType.SELECTED, item_selectedHandler);
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

		override protected function dataProvider_addItemHandler(e:Event):void {
			draw();
		}

		override protected function dataProvider_removeItemHandler(e:Event):void {
			redraw();
		}

		override protected function dataProvider_changeHandler(e:Event):void {
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

		override public function doDelete(indices:Array):void {
			dataProvider.removeItemAt(indices);
		}

		private function scrollbar_changeHandler(e:Event):void {
			if (items_container.height <= 365) return;
			items_container.y = -((items_container.height - 365) / 100 * scroll_bar.value);
		}
	}

}
