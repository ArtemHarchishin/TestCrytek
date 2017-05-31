package {
	import flash.display.MovieClip;
	import flash.events.Event;

	/**
	 It's abstract class
	 */
	public class BaseControl extends MovieClip {
		private var _deleted:Boolean;

		public function get deleted():Boolean {
			return _deleted;
		}

		public function set deleted(value:Boolean):void {
			if (_deleted != value) {
				_deleted = value;
				draw();
				dispatchEvent(new DataEvent(BaseControlEventType.DELETED, this));
			}
		}

		private var _isInitialized:Boolean;

		public function get isInitialized():Boolean {
			return _isInitialized;
		}

		protected var _selected:Boolean;

		public function get selected():Boolean {
			return _selected;
		}

		public function set selected(value:Boolean):void {
			if (_selected != value) {
				_selected = value;
				draw();

				dispatchEvent(new DataEvent(BaseControlEventType.SELECTED, this));
			}
		}

		protected var _itemsField:String = "items";

		public function get itemsField():String {
			return _itemsField;
		}

		public function set itemsField(value:String):void {
			if (_itemsField == value) {
				return;
			}
			_itemsField = value;
		}

		protected var _labelField:String = "label";

		public function get labelField():String {
			return _labelField;
		}

		public function set labelField(value:String):void {
			if (_labelField == value) {
				return;
			}
			_labelField = value;
		}

		protected var _label:String;

		public function get label():String {
			return _label;
		}

		public function set label(value:String):void {
			if (_label == value) {
				return;
			}
			_label = value;
			draw();
		}

		protected var _selectableField:String = "selectable";

		public function get selectableField():String {
			return _selectableField;
		}

		public function set selectableField(value:String):void {
			if (_selectableField == value) {
				return;
			}
			_selectableField = value;
		}

		protected var _selectable:Boolean;

		public function get selectable():Boolean {
			return _selectable;
		}

		public function set selectable(value:Boolean):void {
			if (_selectable == value) {
				return;
			}
			_selectable = value;
		}

		protected var _deletableField:String = "selectable";

		public function get deletableField():String {
			return _deletableField;
		}

		public function set deletableField(value:String):void {
			if (_deletableField == value) {
				return;
			}
			_deletableField = value;
		}

		protected var _deletable:Boolean;

		public function get deletable():Boolean {
			return _deletable;
		}

		public function set deletable(value:Boolean):void {
			if (_deletable == value) {
				return;
			}
			_deletable = value;
		}

		protected var _data:Object;

		public function get data():Object {
			return _data;
		}

		public function set data(value:Object):void {
			if (_data === value) {
				return;
			}
			_data = value;
			commitData();
			draw();
		}

		public function BaseControl() {
			_isInitialized = false;
			addEventListener(Event.ADDED_TO_STAGE, addedToStageHandler);
			addEventListener(Event.REMOVED_FROM_STAGE, removedFromStageHandler);
		}

		public function deselect():void {
			selected = false;
		}

		public function dataToLabel(data:Object):String {
			var result:Object;
			if (_labelField != null && data && data.hasOwnProperty(_labelField)) {
				result = data[_labelField];
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
			else if (data !== null) {
				return data.toString();
			}
			return null;
		}

		public function dataToItems(data:Object):Array {
			var result:Object;
			if (_itemsField != null && data && data.hasOwnProperty(_itemsField)) {
				result = data[_itemsField];
				if (result is Array) {
					return result as Array;
				}
			}
			else if (data is Array) {
				return data as Array;
			}
			else if (data !== null) {
				return data as Array;
			}
			return [];
		}

		public function dataToSelectable(data:Object):Boolean {
			var result:Object;
			if (_selectableField != null && data && data.hasOwnProperty(_selectableField)) {
				result = data[_selectableField];
				if (result is Boolean) {
					return result as Boolean;
				}
			}
			else if (data is Boolean) {
				return data as Boolean;
			}
			else if (data !== null) {
				return Boolean(data);
			}
			return false;
		}

		public function dataToDeletable(data:Object):Boolean {
			var result:Object;
			if (_selectableField != null && data && data.hasOwnProperty(_selectableField)) {
				result = data[_selectableField];
				if (result is Boolean) {
					return result as Boolean;
				}
			}
			else if (data is Boolean) {
				return data as Boolean;
			}
			else if (data !== null) {
				return Boolean(data);
			}
			return false;
		}

		protected function commitData():void {
			throw new Error("It's abstract method");
		}

		protected function draw():void {
			throw new Error("It's abstract method");
		}

		protected function initialize():void {
			throw new Error("It's abstract method");
		}

		protected function dispose():void {
			throw new Error("It's abstract method");
		}

		private function addedToStageHandler(e:Event):void {
			initialize();
			_isInitialized = true;
			draw();
		}

		private function removedFromStageHandler(e:Event):void {
			removeEventListener(Event.ADDED_TO_STAGE, addedToStageHandler);
			removeEventListener(Event.REMOVED_FROM_STAGE, removedFromStageHandler);
			dispose();
			_isInitialized = false;
		}
	}
}
