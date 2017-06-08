package controls {
	import events.DataEvent;
	import events.ItemEventType;

	import flash.display.DisplayObject;
	import flash.events.Event;
	import flash.events.MouseEvent;

	import GroupItemView;
	import IGroupItemView;

	public class GroupItem extends Control {
		private var _items:Array;
		private var _view:IGroupItemView;

		override public function set selected(value:Boolean):void {
			if (_selected != value) {
				_selected = value;
				_view.selected = value;
			}
		}

		override public function get height():Number {
			var value:Number = 0;
			if (!selected || _items.length == 0) {
				value = _view.height;
			} else if (_items.length > 0) {
				for (var i:int = 0; i < _items.length; i++) {
					var item:Control = _items[i];
					value += item.height;
				}
				value += _view.height;
				value = Math.ceil(value);
			} else {
				value = super.height;
			}
			return value;
		}

		public function GroupItem(data:Object) {
			itemType = Item;
			viewType = GroupItemView;
			super(data);
		}

		override protected function initialize():void {
			_view = IGroupItemView(createView());
			_view.hittingArea.addEventListener(MouseEvent.CLICK, clickHandler);
			_view.btnDelete.addEventListener(MouseEvent.CLICK, btnDelete_clickHandler);
			addChild(DisplayObject(_view));
		}

		override protected function commitData():void {
			_view.label = dataToLabel(data);
			reset();
			_view.toggleSelect.visible = Boolean(_items.length);
		}

		override protected function dispose():void {
			resetView();
			resetItems();
			removeChild(DisplayObject(_view));
		}

		public function reset():void {
			resetView();

			resetItems();

			_items = [];

			var datum:Array = dataToItems(data);
			var length:uint = datum.length;
			for (var i:int = 0; i < length; i++) {
				var object:Object = datum[i];
				var item:Control = createItem(object);
				item.addEventListener(ItemEventType.SELECT, item_selectHandler);
				item.addEventListener(ItemEventType.DELETE, item_deleteHandler);
				item.addEventListener(ItemEventType.GROUP_SELECT, dispatchEvent);
				item.addEventListener(ItemEventType.GROUP_DELETE, itemGroup_deleteHandler);
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

		private function removeHandlers():void {
			if (_items == null) return;

			var length:uint = _items.length;
			for (var i:int = 0; i < length; i++) {
				var item:Control = _items[i];
				item.removeEventListener(ItemEventType.SELECT, item_selectHandler);
				item.removeEventListener(ItemEventType.DELETE, item_deleteHandler);
				item.removeEventListener(ItemEventType.GROUP_SELECT, dispatchEvent);
				item.removeEventListener(ItemEventType.GROUP_DELETE, itemGroup_deleteHandler);
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
			dispatchEvent(new DataEvent(ItemEventType.GROUP_DELETE, {own: [], item: data}));
		}

		private function item_selectHandler(event:Event):void {
			dispatchEvent(event);
		}

		private function item_deleteHandler(e:DataEvent):void {
			e.data['own'].push(data);
			dispatchEvent(e);
		}

		private function itemGroup_deleteHandler(e:DataEvent):void {
			e.data['own'].push(data);
			dispatchEvent(e);
		}
	}
}
