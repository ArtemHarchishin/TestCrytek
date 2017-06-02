package {
	import flash.display.MovieClip;
	import flash.events.Event;

	public class View extends MovieClip {

		protected var _data:Object;

		public function get data():Object {
			return _data;
		}

		public function set data(value:Object):void {
			if (_data != value) {
				_data = value;
				commitData();
			}
		}

		protected var _selected:Boolean;

		public function get selected():Boolean {
			return _selected;
		}

		public function set selected(value:Boolean):void {
			throw new Error("It's abstract method");
		}

		private var _isInitialized:Boolean;

		public function get isInitialized():Boolean {
			return _isInitialized;
		}

		public function View() {
			_isInitialized = false;
			addEventListener(Event.ADDED_TO_STAGE, addedToStageHandler);
			addEventListener(Event.REMOVED_FROM_STAGE, removedFromStageHandler);
		}

		protected function initialize():void {
			throw new Error("It's abstract method");
		}

		protected function dispose():void {
			throw new Error("It's abstract method");
		}

		protected function commitData():void {
			throw new Error("It's abstract method");
		}

		public function dataToLabel(data:Object):String {
			var result:Object;
			if (data && data.hasOwnProperty("label")) {
				result = data["label"];
				if (result is String) {
					return result as String;
				}
				else if (result) {
					return result.toString();
				}
			}
			else if (data is String) {
				return data as String;
			}
			else if (data != null) {
				return data.toString();
			}
			return "";
		}

		private function addedToStageHandler(e:Event):void {
			removeEventListener(Event.ADDED_TO_STAGE, addedToStageHandler);
			initialize();
			_isInitialized = true;
		}

		private function removedFromStageHandler(e:Event):void {
			removeEventListener(Event.REMOVED_FROM_STAGE, removedFromStageHandler);
			dispose();
			_isInitialized = false;
		}
	}
}
