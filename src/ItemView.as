package {
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import flash.text.TextField;

	public class ItemView extends View {
		private var _btnDelete:MovieClip;
		private var _hitArea:MovieClip;
		private var _tfLabel:TextField;
		private var _toggleSelect:MovieClip;

		override public function set selected(value:Boolean):void {
			if (_selected != value) {
				_selected = value;
				_toggleSelect.gotoAndStop(selected ? 2 : 1);
			}
		}

		public function set label(value:String):void {
			if (_tfLabel.text != value) {
				_tfLabel.text = value;
			}
		}

		public function ItemView() {
			_btnDelete = this["btn_delete"];
			_hitArea = this["hit_area"];
			_tfLabel = this["tf_label"];
			_toggleSelect = this["toggle_select"];
		}

		override protected function initialize():void {
			_hitArea.addEventListener(MouseEvent.CLICK, clickHandler);
			_btnDelete.addEventListener(MouseEvent.CLICK, btnDelete_clickHandler);
		}

		override protected function commitData():void {
			label = dataToLabel(data);
		}

		override protected function dispose():void {
			_hitArea.removeEventListener(MouseEvent.CLICK, clickHandler);
			_hitArea = null;
			_btnDelete.removeEventListener(MouseEvent.CLICK, btnDelete_clickHandler);
			_btnDelete = null;
			_tfLabel = null;
			_toggleSelect = null;
		}

		private function clickHandler(e:MouseEvent):void {
			selected = !selected;
			dispatchEvent(new ViewEvent(ItemEventType.SELECT, this));
		}

		private function btnDelete_clickHandler(e:MouseEvent):void {
			dispatchEvent(new ViewEvent(ItemEventType.DELETE, this));
		}
	}
}
