package {
	import flash.events.MouseEvent;

	public class GroupItem extends Item {
		private var _items:Array;

		private function get view():GroupItemView {return _view as GroupItemView;}

		public function GroupItem(data:Object) {
			super(data);
		}

		override protected function initialize():void {
			_view = new GroupItemView();
			view.hittingArea.addEventListener(MouseEvent.CLICK, clickHandler);
			view.btnDelete.addEventListener(MouseEvent.CLICK, btnDelete_clickHandler);
			addChild(_view);
		}

		override protected function commitData():void {
			view.label = dataToLabel(data);
			_items = dataToItems(data);
			var length:uint = _items.length;
			for (var i:int = 0; i < length; i++) {
				var item:Item = _items[i];
				view.itemsContainer.addChild(item);
			}
			updatePosition();
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

		override protected function dispose():void {
			view.hittingArea.removeEventListener(MouseEvent.CLICK, clickHandler);
			view.btnDelete.removeEventListener(MouseEvent.CLICK, btnDelete_clickHandler);
			removeChild(view);
		}

		private function dataToItems(data:Object):Array {
			var items:Array = [];
			var datum:Array;
			if (data && data.hasOwnProperty("items") && data['items'] is Array) {
				datum = data["items"];
			} else if (data is Array) {
				datum = data as Array;
			} else {
				datum = items;
			}
			var length:uint = datum.length;
			for (var i:int = 0; i < length; i++) {
				var object:Object = datum[i];
				var item:Item = new Item(object);
				items.push(item);
			}
			return items;
		}

		private function clickHandler(e:MouseEvent):void {
			selected = !selected;
			dispatchEvent(new DataEvent(ItemEventType.SELECT, this));
		}

		private function btnDelete_clickHandler(e:MouseEvent):void {
			dispatchEvent(new DataEvent(ItemEventType.DELETE, data));
		}
	}
}
