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

		public function removeItemAt(indices:Array):Object {
			var branch:Array = data as Array;
			var index:int;
			var indexCount:int = indices.length - 1;
			for(var i:int = 0; i < indexCount; i++)
			{
				index = indices[i] as int;
				branch = branch[index]['items'] as Array;
			}
			var lastIndex:int = indices[indexCount];
			var item:Object = branch[lastIndex];
			branch.splice(lastIndex, 1);
			indices.length = 0;
			dispatchEventWith(CollectionEventType.REMOVE_ITEM);
			return item;
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
