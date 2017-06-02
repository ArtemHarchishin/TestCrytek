package {
	import flash.display.Sprite;
	import flash.events.Event;

	public class Control extends Sprite {
		private var _dataProvider:Collection;

		public function get dataProvider():Collection {
			return _dataProvider;
		}

		private var _isInitialized:Boolean;

		public function get isInitialized():Boolean {
			return _isInitialized;
		}

		public function Control(dataProvider:Collection) {
			_isInitialized = false;
			_dataProvider = dataProvider;
			addEventListener(Event.ADDED_TO_STAGE, addedToStageHandler);
			addEventListener(Event.REMOVED_FROM_STAGE, removedFromStageHandler);
		}

		protected function initialize():void {
			throw new Error("It's abstract method");
		}

		protected function dispose():void {
			throw new Error("It's abstract method");
		}

		private function addedToStageHandler(e:Event):void {
			removeEventListener(Event.ADDED_TO_STAGE, addedToStageHandler);
			initialize();
			_isInitialized = true;
		}

		private function removedFromStageHandler(e:Event):void {
			removeEventListener(Event.REMOVED_FROM_STAGE, removedFromStageHandler);
			dispose();
			_dataProvider = null;
			_isInitialized = false;
		}
	}
}
