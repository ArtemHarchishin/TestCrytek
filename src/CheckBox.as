package {
	import flash.events.MouseEvent;

	public class CheckBox extends Control {

		public function CheckBox(data:Object) {
			super(data);
		}

		override protected function initialize():void {
			_view = new CheckBoxView();
			_view.addEventListener(MouseEvent.CLICK, view_clickHandler);
			addChild(_view);
		}

		override protected function dispose():void {
			_view.removeEventListener(MouseEvent.CLICK, view_clickHandler);
			removeChild(_view);
		}

		override protected function commitData():void {
			_view.label = dataToLabel(data);
		}

		private function view_clickHandler(e:MouseEvent):void {
			selected = !selected;
			dispatchEvent(new DataEvent(ItemEventType.SELECT, this));
		}
	}
}
