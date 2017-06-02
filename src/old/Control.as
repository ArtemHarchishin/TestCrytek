package old {

	import flash.events.Event;
	import flash.events.MouseEvent;

	public class Control extends BaseControl {
		private var _assetWrapper:AssetWrapper;
		private var _selectedItem:BaseControl;

		private var _items:Array;

		public function get items():Array {
			return _items;
		}

		public function set items(value:Array):void {
			if (_items != value) {
				_items = value;
				draw();
			}
		}

		public function Control(i:int) {
			_index = i;
		}

		override public function deselect():void {
			trace(label, _items.length);
			o(_items);
			if (_items.length == 0) {
				_selected = false;
				draw();
			}
		}

		override protected function commitData():void {
			if (_data !== null) {
				_label = dataToLabel(data);
				_items = dataToItems(data);
				_selectable = dataToSelectable(data);
				_deletable = dataToDeletable(data);
				_assetClass = dataToAsset(data);
			}
		}

		override protected function initialize():void {
			if (isInitialized) return;

			_assetWrapper = new AssetWrapper(_assetClass, this);
			_assetWrapper.btn_delete.addEventListener(MouseEvent.CLICK, btnDelete_clickHandler);
			_assetWrapper.hit_area.addEventListener(MouseEvent.CLICK, hitarea_clickHandler);
			_assetWrapper.tf_label.text = "";
			if (_items.length == 0) selectable = false;
		}

		override protected function draw():void {
			if (!isInitialized) return;
			_assetWrapper.tf_label.text = label;

			if (selectable) {
				_assetWrapper.expander.visible = true;
				_assetWrapper.expander.gotoAndStop(selected ? 2 : 1);
			} else {
				_assetWrapper.expander.visible = false;
			}

			_assetWrapper.btn_delete.visible = deletable;

			while (_assetWrapper.items_container.numChildren) {
				_assetWrapper.items_container.removeChildAt(0);
			}

			if (!selected) return;

			var length:uint = _items.length;
			for (var i:int = 0; i < length; i++) {
				var itemData:Object = _items[i];
				var control:Control = new Control(i);
				control.dataProvider = dataProvider;
				control.data = itemData;
				control.own = this;
				control.addEventListener(BaseControlEventType.SELECTED, item_selectedHandler);
				_assetWrapper.items_container.addChild(control);
				control.y = i * control.height;
			}
		}

		override protected function dispose():void {
			if (_assetWrapper) {
				while (_assetWrapper.items_container.numChildren) {
					_assetWrapper.items_container.getChildAt(0).removeEventListener(BaseControlEventType.SELECTED, item_selectedHandler);
					_assetWrapper.items_container.removeChildAt(0);
				}
				_assetWrapper.hit_area.removeEventListener(MouseEvent.CLICK, hitarea_clickHandler);
				_assetWrapper.btn_delete.removeEventListener(MouseEvent.CLICK, btnDelete_clickHandler);
				_assetWrapper.dispose();
				_assetWrapper = null;
			}
			_label = null;
			_items = null;
			_assetClass = null;
			_data = null;
			_selectedItem = null;
		}

		override public function doDelete(indices:Array):void {
			indices.unshift(index);
			if (own == null) {
				dataProvider.removeItemAt(indices);
				draw();
			} else {
				own.doDelete(indices);
			}
		}

		override protected function dataProvider_addItemHandler(e:Event):void {
			draw();
		}

		override protected function dataProvider_removeItemHandler(e:Event):void {
		}

		override protected function dataProvider_changeHandler(e:Event):void {
			draw();
		}

		private function hitarea_clickHandler(e:MouseEvent):void {
			if (!selectable) return;
			selected = !selected;
		}

		private function btnDelete_clickHandler(e:MouseEvent):void {
			deleted = true;
		}

		private function item_selectedHandler(e:DataEvent):void {
			var clickedItem:BaseControl = BaseControl(e.data);
			if (_selectedItem != clickedItem) {
				if (_selectedItem) {
					_selectedItem.deselect();
				}
				_selectedItem = clickedItem;
			}
			dispatchEvent(e);
		}
	}

}
