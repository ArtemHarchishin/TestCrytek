package {
	import flash.events.MouseEvent;

	public class Item extends Control {

		private function get view():ItemView {return _view as ItemView;}

		public function Item(data:Object) {
			super(data);
		}

		override protected function initialize():void {
			_view = new ItemView();
			view.hittingArea.addEventListener(MouseEvent.CLICK, clickHandler);
			view.btnDelete.addEventListener(MouseEvent.CLICK, btnDelete_clickHandler);
			addChild(_view);
		}

		override protected function commitData():void {
			_view.label = dataToLabel(data);
		}

		override protected function dispose():void {
			view.hittingArea.removeEventListener(MouseEvent.CLICK, clickHandler);
			view.btnDelete.removeEventListener(MouseEvent.CLICK, btnDelete_clickHandler);
			removeChild(_view);
		}

		private function clickHandler(e:MouseEvent):void {
			selected = !selected;
			dispatchEvent(new DataEvent(ItemEventType.SELECT, this));
		}

		private function btnDelete_clickHandler(e:MouseEvent):void {
			dispatchEvent(new DataEvent(ItemEventType.DELETE, data));
		}
	}
}
