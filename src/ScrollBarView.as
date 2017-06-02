package {

	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Rectangle;

	public class ScrollBarView extends View {
		protected var _max:Number = 100;
		protected var _min:Number = -7;
		private var _handle:MovieClip;

		protected var _value:Number = 0;

		public function get value():Number {
			return Math.round(Math.abs(_value - _max));
		}

		public function set value(value:Number):void {
			if (_value != value) {
				_value = value;
				updateValue();
			}
		}

		private var _mouseWheelContent:MovieClip;

		public function set mouseWheelContent(content:MovieClip):void {
			_mouseWheelContent = content;
		}

		public function ScrollBarView() {
			_handle = this["handle"];
		}

		override protected function initialize():void {
			if (_mouseWheelContent) {
				_mouseWheelContent.addEventListener(MouseEvent.MOUSE_WHEEL, onMouseWheelHandler);
			}
			_handle.addEventListener(MouseEvent.MOUSE_DOWN, handle_onDragHandler);
			_handle.buttonMode = true;
			_handle.useHandCursor = true;
		}

		override protected function dispose():void {
			if (_mouseWheelContent) {
				_mouseWheelContent.removeEventListener(MouseEvent.MOUSE_WHEEL, onMouseWheelHandler);
				_mouseWheelContent = null;
			}
			_handle.addEventListener(MouseEvent.MOUSE_DOWN, handle_onDragHandler);
			_handle = null;
		}

		private function updateValue():void {
			var oldValue:Number = _value;
			_value = (height - width - _handle.y) / (height - width) * (_max - _min) + _min;
			if (_value != oldValue) {
				dispatchEvent(new Event(Event.CHANGE));
			}
		}

		protected function stage_onSlideHandler(event:MouseEvent):void {
			updateValue();
		}

		protected function stage_onDropHandler(event:MouseEvent):void {
			stage.removeEventListener(MouseEvent.MOUSE_UP, stage_onDropHandler);
			stage.removeEventListener(MouseEvent.MOUSE_MOVE, stage_onSlideHandler);
			stopDrag();
		}

		private function onMouseWheelHandler(e:MouseEvent):void {
			var scrollDistance:int = e.delta;
			var maxY:int = Math.round(y + height - _handle.height);
			var minY:int = Math.round(y);

			var scrollWheelSpeed:int = 10;

			var canUp:Boolean = scrollDistance > 0 && (_handle.y - (scrollDistance * scrollWheelSpeed)) >= minY;
			var canDown:Boolean = scrollDistance < 0 && (_handle.y - (scrollDistance * scrollWheelSpeed)) <= maxY;

			if (canUp || canDown) {

				_handle.y = _handle.y - (scrollDistance * scrollWheelSpeed);

				if (_handle.y < minY) {
					_handle.y = minY;
				}
				else if (_handle.y > maxY) {
					_handle.y = maxY;
				}

				updateValue();
			}
		}

		private function handle_onDragHandler(e:MouseEvent):void {
			stage.addEventListener(MouseEvent.MOUSE_UP, stage_onDropHandler);
			stage.addEventListener(MouseEvent.MOUSE_MOVE, stage_onSlideHandler);
			_handle.startDrag(false, new Rectangle(-_handle.width / 2, 0, 0, height - _handle.height));
		}
	}

}
