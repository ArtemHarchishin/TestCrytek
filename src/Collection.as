package {
	import flash.events.Event;
	import flash.events.EventDispatcher;

	public class Collection extends EventDispatcher {

		private var _data:Array;

		public function get data():Array {
			return _data;
		}

		public function set data(value:Array):void {
			if (_data != value) {
				_data = value;
				dispatchEventWith(Event.CHANGE);
			}
		}

		public function Collection(data:Array = null) {
			if (!data) {
				data = [];
			}
			_data = data;
		}

		public function updateAll():void {
			dispatchEventWith(CollectionEventType.UPDATE_ALL);
		}

		public function getItemAt(index:int):Object {
			return data[index];
		}

		public function addItem(item:Object):void {
			data.push(item);
			dispatchEventWith(CollectionEventType.ADD_ITEM);
		}

		public function removeItem(item:Object):void {
			var i:int = data.indexOf(item);
			data.splice(i, 1);
			dispatchEventWith(CollectionEventType.REMOVE_ITEM);
		}

		public function getLength():int {
			return data.length;
		}

		private function dispatchEventWith(type:String, data:Object = null):void {
			var event:Event = new DataEvent(type, data);
			dispatchEvent(event);
		}
	}
}
