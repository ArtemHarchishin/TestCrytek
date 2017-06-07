package {
	public class Component extends Control {
		protected var _view:ComponentView;

		private var _checkBoxSort:CheckBox;
		private var _list:List;

		public function Component(data:Object) {
			super(data);
		}

		override protected function initialize():void {
			_view = new ComponentView();

			_checkBoxSort = new CheckBox({label: "newest to oldest"});
			_checkBoxSort.addEventListener(ItemEventType.SELECT, checkBox_selectHandler);
			_view.checkboxContainer.addChild(_checkBoxSort);

			_list = new List(data as Collection);
			_list.itemType = GroupItem;
			_list.itemFactory = function ():Control {
				var groupItem:GroupItem = new GroupItem();
				groupItem.it
				return groupItem;
			};

			_view.listContainer.addChild(_list);

			addChild(_view);
		}

		override protected function commitData():void {
			// empty
		}

		override protected function dispose():void {
			_view.listContainer.removeChild(_list);
			_view.checkboxContainer.removeChild(_checkBoxSort);
			removeChild(_view);
			_view = null;
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
