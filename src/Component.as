package {
	public class Component extends BaseControl {

		public function Component() {
		}

		override protected function commitData():void {
		}

		override protected function initialize():void {
			var list:List = new List();
			list.dataProvider = new Collection(data as Array);
			list.itemFactory = function (data:Object):BaseControl {
				var item:Category = new Category();
				return item;
			};
			list_container.addChild(list);
		}

		override protected function draw():void {
		}

		override protected function dispose():void {
		}
	}

}
