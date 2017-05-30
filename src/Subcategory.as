package {

	public class Subcategory extends BaseControl {

		private var _items:Array;

		public function set items(value:Array):void {
			if (_items != value) {
				_items = value;
				_items ||= [];
				draw();
			}
		}

		public function Subcategory() {
		}

		override protected function commitData():void {
			if (_data !== null) {
				_label = dataToLabel(_data);
				_items = dataToItems(_data);
			}
		}

		override protected function initialize():void {
			tf_label.text = "";
		}

		override protected function draw():void {
			if (!isInitialized) return;

			tf_label.text = label;

			while (items_container.numChildren) {
				items_container.removeChildAt(0);
			}

			var length:uint = _items.length;
			for (var i:int = 0; i < length; i++) {
				var item:Item = new Item();
				item.data = _items[i];
				item.addEventListener(BaseControlEventType.SELECTED, item_selectedHandler);
				item.addEventListener(BaseControlEventType.DELETED, item_deletedHandler);
				items_container.addChild(item);
				item.y = i * item.height;
			}
		}

		private function item_deletedHandler(e:DataEvent):void {
			var deletedItem:BaseControl = BaseControl(e.data);
			var childIndex:int = items_container.getChildIndex(deletedItem);
			items_container.removeChildAt(childIndex);
//			dataProvider.removeItem(deletedItem.data);
			var i:int = _items.indexOf(deletedItem.data);
			_items.splice(i, 1);
			draw();
		}

		override protected function dispose():void {
			while (items_container.numChildren) {
				items_container.getChildAt(0).removeEventListener(BaseControlEventType.SELECTED, item_selectedHandler);
				items_container.removeChildAt(0);
			}
			_items = null;
		}

		private function item_selectedHandler(e:DataEvent):void {
			dispatchEvent(e);
		}
	}

}
