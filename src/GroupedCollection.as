package {
	import flash.events.Event;
	import flash.events.EventDispatcher;

	public class GroupedCollection extends EventDispatcher {
		private var _data:Array;

		public function get data():Array {
			return _data;
		}

		public function set data(value:Array):void {
			if (_data != value) {
				_data = value;
				dispatchEventWith(CollectionEventType.RESET);
			}
		}

		public function GroupedCollection(data:Array = null) {
			if (!data) {
				data = [];
			}
			_data = data;
		}

		public function removeGroupItem(item:Object):void {
			var i:int = data.indexOf(item);
			if (i >= 0) {
				data.splice(i, 1);
				dispatchEventWith(CollectionEventType.REMOVE_GROUP_ITEM, item);
			}
		}

		public function removeItem(groupItem:Object, item:Object):void {
			if (data.indexOf(groupItem) >= 0 && groupItem.hasOwnProperty("items") && groupItem["items"] is Array) {
				var items:Array = groupItem['items'];
				var i:int = items.indexOf(item);
				if (i >= 0) {
					items.splice(i, 1);
					dispatchEventWith(CollectionEventType.REMOVE_ITEM, item);
				}
			}
		}

		public function addItem(groupItem:Object, item:Object):void {
			groupItem['items'] ||= [];
			groupItem['items'].push(item);
			if (data.indexOf(groupItem) == -1) {
				data.push(groupItem);
				dispatchEventWith(CollectionEventType.ADD_GROUP_ITEM, groupItem);
			} else {
				dispatchEventWith(CollectionEventType.ADD_ITEM, item);
			}
		}

		public function addGroupItem(item:Object):void {
			data.push(item);
			dispatchEventWith(CollectionEventType.ADD_GROUP_ITEM, item);
		}

		public function getItemAt(index:int):Object {
			return data[index];
		}

		public function getLength():int {
			return data.length;
		}

		public function reverse():void {
			data.reverse();
			dispatchEventWith(CollectionEventType.SORT_REVERSE);
		}

		protected function dispatchEventWith(type:String, data:Object = null):void {
			var event:Event = new DataEvent(type, data);
			dispatchEvent(event);
		}
	}
}
