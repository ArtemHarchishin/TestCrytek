package {
	import flash.events.MouseEvent;

	public class GroupItem extends Control {
		private var _items:Array;
		private var _view:GroupItemView;

		override public function set selected(value:Boolean):void {
			if (_selected != value){
				_selected = value;
				_view.selected = value;
			}
		}

		override public function get height():Number {
			if (!selected) return _view.hittingArea.height;
			if (!_items.length) return _view.hittingArea.height;
			return super.height;
		}

		public function GroupItem(data:Object) {
			super(data);
		}

		override protected function initialize():void {
			_view = new GroupItemView();
			_view.hittingArea.addEventListener(MouseEvent.CLICK, clickHandler);
			_view.btnDelete.addEventListener(MouseEvent.CLICK, btnDelete_clickHandler);
			addChild(_view);
		}

		override protected function commitData():void {
			_view.label = dataToLabel(data);
			reset();
			_view.toggleSelect.visible = Boolean(_items.length);
		}

		override protected function dispose():void {
			resetView();
			resetItems();
			removeChild(_view);
		}

		public function reset():void {
			resetView();

			resetItems();

			_items = [];

			var datum:Array = dataToItems(data);
			var length:uint = datum.length;
			for (var i:int = 0; i < length; i++) {
				var object:Object = datum[i];
				var item:Control = new Item(object);
				item.addEventListener(ItemEventType.SELECT, dispatchEvent);
				item.addEventListener(ItemEventType.DELETE, dispatchEvent);
				_items.push(item);
				_view.itemsContainer.addChild(item);
			}

			updatePosition();
		}

		private function resetView():void {
			while (_view.itemsContainer.numChildren) {
				_view.itemsContainer.removeChildAt(0);
			}
		}

		private function resetItems():void {
			if (_items) {
				removeHandlers();
				_items.length = 0;
				_items = null;
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

		private function removeHandlers():void {
			if (_items == null) return;

			var length:uint = _items.length;
			for (var i:int = 0; i < length; i++) {
				var item:Control = _items[i];
				item.removeEventListener(ItemEventType.SELECT, dispatchEvent);
				item.removeEventListener(ItemEventType.DELETE, dispatchEvent);
			}
		}

		private function dataToItems(data:Object):Array {
			var items:Array;
			if (data && data.hasOwnProperty("items") && data['items'] is Array) {
				return data["items"] as Array;
			} else if (data is Array) {
				return data as Array;
			}
			return [];
		}

		private function clickHandler(e:MouseEvent):void {
			selected = !selected;
			dispatchEvent(new DataEvent(ItemEventType.GROUP_SELECT, this));
		}

		private function btnDelete_clickHandler(e:MouseEvent):void {
			dispatchEvent(new DataEvent(ItemEventType.GROUP_DELETE, this));
		}
	}
}
