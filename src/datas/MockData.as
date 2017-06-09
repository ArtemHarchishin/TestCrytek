package datas {
	import flash.events.Event;
	import flash.net.URLLoader;
	import flash.net.URLRequest;

	import utils.execute;

	public class MockData {

		private var _lessonsJsonPath:String = "mock_data/lessons_mock_data.json";
		private var _motostoreJsonPath:String = "mock_data/moto_store_mock_data.json";

		private var _data:Array;

		public function get data():Array {return _data;}

		public function MockData() {}

		public function getLessonsData(callback:Function):void {
			var loader:URLLoader = new URLLoader();
			var request:URLRequest = new URLRequest();
			request.url = _lessonsJsonPath;
			loader.addEventListener(Event.COMPLETE, function onLoaderComplete(e:Event):void {
				var loader:URLLoader = URLLoader(e.target);
				var jsonArray:Object = JSON.parse(loader.data);
				_data = jsonArray as Array;
				callback && execute(callback, _data);
			});
			loader.load(request);
		}

		public function getMotoStoreData(callback:Function):void {
			var loader:URLLoader = new URLLoader();
			var request:URLRequest = new URLRequest();
			request.url = _motostoreJsonPath;
			loader.addEventListener(Event.COMPLETE, function onLoaderComplete(e:Event):void {
				var loader:URLLoader = URLLoader(e.target);
				var jsonArray:Object = JSON.parse(loader.data);
				_data = jsonArray as Array;
				callback && callback();
			});
			loader.load(request);
		}
	}
}
