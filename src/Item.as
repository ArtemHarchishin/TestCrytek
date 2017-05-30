package {

	import flash.events.MouseEvent;

	public class Item extends BaseControl {

		public function Item() { }

		override protected function commitData():void {
			if (_data !== null) {
				_label = dataToLabel(_data);
			}
		}

		override protected function initialize():void {
			addEventListener(MouseEvent.CLICK, clickHandler);
			btn_delete.addEventListener(MouseEvent.CLICK, btnDelete_clickHandler);
			tf_label.text = "";
		}

		private function btnDelete_clickHandler(e:MouseEvent):void {
			deleted = true;
		}

		override protected function draw():void {
			if (!isInitialized) return;

			gotoAndStop(_selected ? 2 : 1);
			tf_label.text = _label;
		}

		override protected function dispose():void {
			removeEventListener(MouseEvent.CLICK, clickHandler);
			btn_delete.removeEventListener(MouseEvent.CLICK, btnDelete_clickHandler);
			_data = null;
		}

		private function clickHandler(e:MouseEvent):void {
			selected = !selected;
		}
	}
}
