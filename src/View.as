package {
	import flash.display.MovieClip;
	import flash.events.Event;

	public class View extends MovieClip {

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

		private function addedToStageHandler(e:Event):void {
			initialize();
			_isInitialized = true;
		}

		private function removedFromStageHandler(e:Event):void {
			removeEventListener(Event.ADDED_TO_STAGE, addedToStageHandler);
			removeEventListener(Event.REMOVED_FROM_STAGE, removedFromStageHandler);
			dispose();
			_isInitialized = false;
		}
	}
}
