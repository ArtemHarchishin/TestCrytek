package {

	import controls.Lessons;
	import controls.MotoStore;

	import datas.Collection;
	import datas.GroupedCollection;
	import datas.MockData;

	import flash.display.MovieClip;

	public class Main extends MovieClip {

		public function Main() {
//			createLessonsList();
			createMotoStoreList();
		}

		private function createMotoStoreList():void {
			var mockData:MockData = new MockData();
			mockData.getMotoStoreData(function ():void {
				var arr:Array = [];
				for (var i:int = 0; i < mockData.data.length; i++) {
					var object:Object = mockData.data[i];
					var sub:String = object['sub'];
					var has:Boolean = false;
					for (var j:int = 0; j < arr.length; j++) {
						var ooo:Object = arr[j];
						if (ooo['label'] == sub) {
							ooo['items'].push({label:object['label'], pic:object['pic']});
							has = true;
						}
					}

					if (!has) {
						var oo:Object = {label:object['sub'], items: [{label:object['label'], pic:object['pic']}]};
						arr.push(oo);
					}
				}

				var motoStore:MotoStore = new MotoStore();
				motoStore.dataProvider = new GroupedCollection(arr);
				addChild(motoStore);
			});
		}

		private function createLessonsList():void {
			var mockData:MockData = new MockData();
			mockData.getLessonsData(function ():void {
				var lessons:Lessons = new Lessons();
				lessons.dataProvider = new Collection(mockData.data);
				addChild(lessons);
			});
		}
	}
}
