package {
	public class Control {
		private var _isInitialized:Boolean;

		public function get isInitialized():Boolean {
			return _isInitialized;
		}

		public function Control() {
			_isInitialized = false;
			initialize();
			_isInitialized = true;
		}

		protected function initialize():void {
			throw new Error("It's abstract method");
		}

		protected function dispose():void {
			throw new Error("It's abstract method");
		}
	}
}
