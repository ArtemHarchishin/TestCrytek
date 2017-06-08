package datas {
	import events.CollectionEventType;
	import events.DataEvent;

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
				dispatchEventWith(CollectionEventType.RESET);
			}
		}

		public function Collection(data:Array = null) {
			if (!data) {
				data = [];
			}
			_data = data;
		}

		public function getItemAt(index:int):Object {
			return data[index];
		}

		public function addItem(...args):void {
			var item:Object = args[0];
			data.push(item);
			dispatchEventWith(CollectionEventType.ADD_ITEM, item);
		}

		public function removeItem(...args):void {
			var item:Object = args[0];
			var i:int = data.indexOf(item);
			if (i >= 0) {
				data.splice(i, 1);
				dispatchEventWith(CollectionEventType.REMOVE_ITEM, item);
			}
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
