package {
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.utils.getQualifiedClassName;

	public class Control extends Sprite {
		protected var _selected:Boolean;

		public function get selected():Boolean {
			return _selected;
		}

		public function set selected(value:Boolean):void {
			if (_selected != value) {
				_selected = value;
				view.selected = value;
			}
		}

		protected var _data:Object;

		public function get data():Object {
			return _data;
		}

		private var _isInitialized:Boolean;

		public function get isInitialized():Boolean {
			return _isInitialized;
		}

		protected function get view():View {return null;}

		public function Control(data:Object) {
			_isInitialized = false;
			_data = data;
			addEventListener(Event.ADDED_TO_STAGE, addedToStageHandler);
			addEventListener(Event.REMOVED_FROM_STAGE, removedFromStageHandler);
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

		protected function initialize():void {
			throw new Error("initialize - It's abstract method. Need implement in " + getQualifiedClassName(this));
		}

		protected function dispose():void {
			throw new Error("dispose - It's abstract method. Need implement in " + getQualifiedClassName(this));
		}

		protected function commitData():void {
			throw new Error("commitData - It's abstract method. Need implement in " + getQualifiedClassName(this));
		}

		private function addedToStageHandler(e:Event):void {
			removeEventListener(Event.ADDED_TO_STAGE, addedToStageHandler);
			initialize();
			commitData();
			_isInitialized = true;
		}

		private function removedFromStageHandler(e:Event):void {
			removeEventListener(Event.REMOVED_FROM_STAGE, removedFromStageHandler);
			dispose();
			_data = null;
			_isInitialized = false;
		}
	}
}
