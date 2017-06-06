package {
	public class Component extends Control {

		private var _checkBoxSort:CheckBox;
		private var _list:List;

		private function get view():ComponentView {return _view as ComponentView;}

		public function Component(data:Collection) {
			super(data);
		}

		override protected function initialize():void {
			_view = new ComponentView();

			_checkBoxSort = new CheckBox({label: "newest to oldest"});
			_checkBoxSort.addEventListener(ItemEventType.SELECT, checkBox_selectHandler);
			view.checkboxContainer.addChild(_checkBoxSort);

			_list = new List(data as Collection);
			view.listContainer.addChild(_list);

			addChild(view);
		}

		override protected function commitData():void {
			// empty
		}

		override protected function dispose():void {
			view.listContainer.removeChild(_list);
			view.checkboxContainer.removeChild(_checkBoxSort);
			removeChild(view);
		}

		private function checkBox_selectHandler(e:DataEvent):void {
			var checkBox:CheckBox = e.data as CheckBox;
			if (checkBox.selected) {
				trace(1);
//				data
			} else {
				trace(2);
//				data
			}
		}
	}
}
