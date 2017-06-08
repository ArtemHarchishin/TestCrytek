package controls {
	import events.DataEvent;
	import events.ItemEventType;

	import flash.events.MouseEvent;

	import CheckBoxView;

	public class CheckBox extends Control {

		protected var _view:CheckBoxView;

		override public function set selected(value:Boolean):void {
			if (_selected != value) {
				_selected = value;
				_view.selected = value;
			}
		}

		public function CheckBox(data:Object) {
			viewType = CheckBoxView;
			super(data);
		}

		override protected function initialize():void {
			_view = CheckBoxView(createView());
			_view.addEventListener(MouseEvent.CLICK, view_clickHandler);
			addChild(_view);
		}

		override protected function dispose():void {
			_view.removeEventListener(MouseEvent.CLICK, view_clickHandler);
			removeChild(_view);
			_view = null;
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
