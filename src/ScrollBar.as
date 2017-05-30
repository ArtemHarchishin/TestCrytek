package {

	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Rectangle;

	public class ScrollBar extends MovieClip {
		protected var _max:Number = 100;
		protected var _min:Number = -7;

		protected var _value:Number = 0;

		public function get value():Number {
			return Math.round(Math.abs(_value - _max));
		}

		public function ScrollBar() {
			handle.addEventListener(MouseEvent.MOUSE_DOWN, onDrag);
			handle.buttonMode = true;
			handle.useHandCursor = true;
		}

		protected function onSlide(event:MouseEvent):void {
			var oldValue:Number = _value;
			_value = (height - width - handle.y) / (height - width) * (_max - _min) + _min;
			if (_value != oldValue) {
				dispatchEvent(new Event(Event.CHANGE));
			}
		}

		protected function onDrop(event:MouseEvent):void {
			stage.removeEventListener(MouseEvent.MOUSE_UP, onDrop);
			stage.removeEventListener(MouseEvent.MOUSE_MOVE, onSlide);
			stopDrag();
		}

		private function onDrag(e:MouseEvent):void {
			stage.addEventListener(MouseEvent.MOUSE_UP, onDrop);
			stage.addEventListener(MouseEvent.MOUSE_MOVE, onSlide);
			handle.startDrag(false, new Rectangle(-handle.width / 2, 0, 0, height - handle.height));
		}
	}

}
