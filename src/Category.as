package {

	import flash.events.MouseEvent;

	public class Category extends BaseControl {
		private var _selectedItem:BaseControl;

		private var _items:Array;

		public function set items(value:Array):void {
			if (_items != value) {
				_items = value;
				draw();
			}
		}

		override public function deselect():void {
			// empty
		}

		public function Category() {
		}

		override protected function commitData():void {
			if (_data !== null) {
				_label = dataToLabel(data);
				_items = dataToItems(data);
			}
		}

		override protected function initialize():void {
			btn_delete.addEventListener(MouseEvent.CLICK, btnDelete_clickHandler);
			hit_area.addEventListener(MouseEvent.CLICK, hitarea_clickHandler);
			tf_label.text = "";
		}

		override protected function draw():void {
			if (!isInitialized) return;
			tf_label.text = label;

			expander.gotoAndStop(selected ? 2 : 1);

			while (items_container.numChildren) {
				items_container.removeChildAt(0);
			}

			if (!selected) return;

			var length:uint = _items.length;
			for (var i:int = 0; i < length; i++) {
				var subcat:Object = _items[i];
				var subcategory:Subcategory = new Subcategory();
				subcategory.data = subcat;
				subcategory.addEventListener(BaseControlEventType.SELECTED, subcategory_selectedHandler);
				items_container.addChild(subcategory);
				subcategory.y = i * subcategory.height;
			}
		}

		override protected function dispose():void {
			while (items_container.numChildren) {
				items_container.getChildAt(0).removeEventListener(BaseControlEventType.SELECTED, subcategory_selectedHandler);
				items_container.removeChildAt(0);
			}
			hit_area.removeEventListener(MouseEvent.CLICK, hitarea_clickHandler);
			btn_delete.removeEventListener(MouseEvent.CLICK, btnDelete_clickHandler);
			_label = null;
		}

		private function hitarea_clickHandler(e:MouseEvent):void {
			selected = !selected;
		}

		private function btnDelete_clickHandler(e:MouseEvent):void {
			deleted = true;
		}

		private function subcategory_selectedHandler(e:DataEvent):void {
			var clickedItem:BaseControl = BaseControl(e.data);
			if (_selectedItem != clickedItem) {
				if (_selectedItem) {
					_selectedItem.deselect();
				}
				_selectedItem = clickedItem;
			}
		}
	}

}
