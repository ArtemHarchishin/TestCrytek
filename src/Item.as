package {
	import flash.events.MouseEvent;

	public class Item extends Control {
		protected var _view:ItemView;

		override protected function get view():View {return _view as View;}

		public function Item(data:Object) {
			super(data);
		}

		override protected function initialize():void {
			_view = new ItemView();
			_view.hittingArea.addEventListener(MouseEvent.CLICK, clickHandler);
			_view.btnDelete.addEventListener(MouseEvent.CLICK, btnDelete_clickHandler);
			addChild(_view);
		}

		override protected function commitData():void {
			_view.label = dataToLabel(data);
		}

		override protected function dispose():void {
			_view.hittingArea.removeEventListener(MouseEvent.CLICK, clickHandler);
			_view.btnDelete.removeEventListener(MouseEvent.CLICK, btnDelete_clickHandler);
			removeChild(_view);
			_view = null;
		}

		protected function clickHandler(e:MouseEvent):void {
			selected = !selected;
			dispatchEvent(new DataEvent(ItemEventType.SELECT, this));
		}

		protected function btnDelete_clickHandler(e:MouseEvent):void {
			dispatchEvent(new DataEvent(ItemEventType.DELETE, this));
		}
	}
}
