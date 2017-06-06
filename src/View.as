package {
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.utils.getQualifiedClassName;

	public class View extends MovieClip {

		public function set label(value:String):void {
			throw new Error("It's abstract setter. Need implement in " + getQualifiedClassName(this));
		}

		public function set selected(value:Boolean):void {
			throw new Error("It's abstract setter. Need implement in " + getQualifiedClassName(this));
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
			throw new Error("It's abstract method. Need implement in " + getQualifiedClassName(this));
		}

		protected function dispose():void {
			throw new Error("It's abstract method. Need implement in " + getQualifiedClassName(this));
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
