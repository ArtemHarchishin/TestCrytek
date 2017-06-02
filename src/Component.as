package {
	public class Component extends Control {
		private var _sortHandler:SortHandler;

		public function Component(dataProvider:Collection) {
			super(dataProvider);
		}

		override protected function initialize():void {
			var component:ComponentView = new ComponentView();
			component.sortByOldCheckbox.label = "newest to oldest";
			var listControl:List = new List(dataProvider);
			_sortHandler = new SortHandler(component, listControl, dataProvider);
			component.listContainer.addChild(listControl);
			addChild(component);
		}

		override protected function dispose():void {
			_sortHandler.dispose();
			_sortHandler = null;
		}
	}
}
