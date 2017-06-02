package {
	import flash.events.Event;

	public class ViewEvent extends Event {
		private var _view:View;

		public function get view():View {
			return _view;
		}

		public function ViewEvent(eventType:String, view:View) {
			super(eventType);
			_view = view;
		}

		override public function clone():Event {
			return new ViewEvent(type, view);
		}
	}
}
