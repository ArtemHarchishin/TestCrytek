package old {
	import flash.events.Event;

	public class DataEvent extends Event {

		private var _data:Object;

		public function get data():Object {
			return _data;
		}

		public function DataEvent(type:String, data:Object = null) {
			super(type);
			_data = data;

		}

		override public function clone():Event {
			return new DataEvent(type, data);
		}
	}
}
