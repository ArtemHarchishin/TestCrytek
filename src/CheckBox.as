package {
	import flash.events.MouseEvent;

	public class CheckBox extends Control {

		protected var _view:CheckBoxView;

		override public function set selected(value:Boolean):void {
			if (_selected != value) {
				_selected = value;
				_view.selected = value;
			}
		}

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
