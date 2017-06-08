package controls {
	import datas.Collection;

	import flash.display.Sprite;
	import flash.events.Event;
	import flash.utils.getQualifiedClassName;

	import View;

	public class Control extends Sprite {

		protected var _itemFactory:Function;

		public function get itemFactory():Function {
			return _itemFactory;
		}

		public function set itemFactory(value:Function):void {
			if (_itemFactory === value) {
				return;
			}
			_itemFactory = value;
		}

		protected var _itemType:Class;

		public function get itemType():Class {
			return _itemType;
		}

		public function set itemType(value:Class):void {
			if (_itemType == value) {
				return;
			}
			_itemType = value;
		}

		protected var _viewFactory:Function;

		public function get viewFactory():Function {
			return _viewFactory;
		}

		public function set viewFactory(value:Function):void {
			if (_viewFactory === value) {
				return;
			}
			_viewFactory = value;
		}

		protected var _viewType:Class;

		public function get viewType():Class {
			return _viewType;
		}

		public function set viewType(value:Class):void {
			if (_viewType == value) {
				return;
			}
			_viewType = value;
		}

		private var _dataProvider:Collection;

		public function get dataProvider():Collection {
			return _dataProvider;
		}

		public function set dataProvider(value:Collection):void {
			if (_dataProvider == value) {
				return;
			}
			if (_dataProvider) {
				removeHandlersOfDataProvider();
			}
			_dataProvider = value;
			if (_dataProvider) {
				addHandlersToDataProvider();
			}
		}

		protected var _selected:Boolean;

		public function get selected():Boolean {
			return _selected;
		}

		public function set selected(value:Boolean):void {
			throw new Error("selected - It's abstract setter. Need implement in " + getQualifiedClassName(this));
		}

		protected var _data:Object;

		public function get data():Object {
			return _data;
		}

		private var _isInitialized:Boolean;

		protected function get isInitialized():Boolean {
			return _isInitialized;
		}

		public function Control(data:Object = null) {
			data ||= {};
			_isInitialized = false;
			_data = data;
			addEventListener(Event.ADDED_TO_STAGE, addedToStageHandler);
			addEventListener(Event.REMOVED_FROM_STAGE, removedFromStageHandler);
		}

		public function updatePosition():void {
			// empty
		}

		protected function addHandlersToDataProvider():void {
			// empty
		}

		protected function removeHandlersOfDataProvider():void {
			// empty
		}

		protected function createItem(data:Object):Control {
			if (itemFactory == null) {
				return new itemType(data);
			}
			return itemFactory(data);
		}

		protected function createView():View {
			if (viewFactory == null) {
				return new viewType();
			}
			return viewFactory();
		}

		protected function dataToLabel(data:Object):String {
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
