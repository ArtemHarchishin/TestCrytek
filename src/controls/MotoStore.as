package controls {
	import flash.display.Loader;
	import flash.events.Event;
	import flash.net.URLRequest;

	import utils.moveTo;

	public class MotoStore extends Control {
		private var _list:GroupedList;

		public function MotoStore() {
			super();
		}

		private var _loader:Loader;

		override protected function initialize():void {
			_list = new GroupedList();
			_list.dataProvider = dataProvider;
			_list.addEventListener(Event.SELECT, list_selectHandler);
			addChild(_list);

			_loader = new Loader();
			moveTo(_loader, _list.x + _list.width, 0);
			addChild(_loader);
		}

		override protected function dispose():void {
			removeChild(_list);
			_list.removeEventListener(Event.SELECT, list_selectHandler);
			_list = null;
			removeChild(_loader);
			_loader = null;
		}

		override protected function commitData():void {
			// empty
		}

		private function list_selectHandler(e:Event):void {
			var url:String = _list.selectedItem.data['pic'];
			var request:URLRequest = new URLRequest();
			request.url = url;
			_loader.load(request);
		}
	}
}
