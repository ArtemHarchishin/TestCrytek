package {
	public class List extends Control {
		private var _selectHandler:SelectHandler;
		private var _addDeleteHandler:AddDeleteHandler;
		private var _listView:ListView;

		public function List(dataProvider:Collection) {
			super(dataProvider);
		}

		override protected function initialize():void {
			_listView = new ListView();
			_selectHandler = new SelectHandler(_listView);
			_addDeleteHandler = new AddDeleteHandler(_listView, dataProvider);
			addChild(_listView);
			reset();
		}

		override protected function dispose():void {
			_addDeleteHandler.dispose();
			_addDeleteHandler = null;
			_selectHandler.dispose();
			_selectHandler = null;
			_listView = null;
		}

		public function reset():void {
			while (_listView.numItems) {
				_listView.removeItemAt(0);
			}

			var length:uint = dataProvider.getLength();
			for (var i:int = 0; i < length; i++) {
				var object:Object = dataProvider.getItemAt(i);
				var item:ItemView = new ItemView();
				item.data = object;
				_listView.addItem(item);
			}

			updatePosition();

			_selectHandler.reset();
			_addDeleteHandler.reset();
		}

		public function reverse():void {
			var numItems:int = _listView.numItems;
			for (var from:int = 0; from < numItems; from++) {
				_listView.setItemIndex(View(_listView.getItemAt(from)), 0);
			}

			updatePosition();

			_selectHandler.reset();
			_addDeleteHandler.reset();
		}

		private function updatePosition():void {
			var shiftY:Number = 0;
			var length:int = _listView.numItems;
			for (var i:int = 0; i < length; i++) {
				var item:View = View(_listView.getItemAt(i));
				item.y = shiftY;
				shiftY = item.y + item.height;
			}
		}
	}
}
