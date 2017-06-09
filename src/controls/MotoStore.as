package controls {
	import events.DataEvent;
	import events.ItemEventType;

	import flash.display.Loader;
	import flash.events.Event;
	import flash.net.URLRequest;

	import utils.moveTo;

	public class MotoStore extends Control {
		private var _component:Component;
		private var _loader:Loader;

		public function MotoStore() {
			super();
		}

		override protected function initialize():void {
			_component = new Component();
			_component.dataProvider = dataProvider;
			_component.addEventListener(ItemEventType.SELECT, component_selectHandler);
			addChild(_component);

			_loader = new Loader();
			moveTo(_loader, _component.x + _component.width, 0);
			addChild(_loader);
		}

		override protected function dispose():void {
			removeChild(_component);
			_component.removeEventListener(Event.SELECT, component_selectHandler);
			_component = null;
			removeChild(_loader);
			_loader = null;
		}

		override protected function commitData():void {
			// empty
		}

		private function component_selectHandler(e:DataEvent):void {
			var url:String = (e.data as Control).data['pic'];
			var request:URLRequest = new URLRequest();
			request.url = url;
			_loader.load(request);
		}
	}
}
