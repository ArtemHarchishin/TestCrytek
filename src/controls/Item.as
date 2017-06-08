package controls {
	import events.DataEvent;
	import events.ItemEventType;

	import flash.events.MouseEvent;

	import ItemView;

	public class Item extends Control {
		protected var _view:ItemView;

		override public function set selected(value:Boolean):void {
			if (_selected != value) {
				_selected = value;
				_view.selected = value;
			}
		}

		public function Item(data:Object) {
			viewType = ItemView;
			super(data);
		}

		override protected function initialize():void {
			_view = ItemView(createView());
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
			dispatchEvent(new DataEvent(ItemEventType.DELETE, {own: [], item: data}));
		}
	}
}
