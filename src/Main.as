package {

	import flash.display.MovieClip;

	public class Main extends MovieClip {

		public function Main() {
			var listData:Array = [
				{label: "1 Математика"},
				{label: "2 Русский"},
				{label: "3 Английский"},
				{label: "4 Физ-ра"},
				{label: "5 Природа"},
				{label: "6 музыка"},
				{label: "7 ИЗО"},
				{label: "8 Труды"},
				{label: "9 Литра"},
				{label: "10 ОБЖ"},
				{label: "11 История"},
				{label: "12 Математика"},
				{label: "13 Русский"},
				{label: "14 Английский"},
				{label: "15 Физ-ра"},
				{label: "16 Природа"},
				{label: "17 музыка"},
				{label: "18 ИЗО"},
				{label: "19 Труды"},
				{label: "20 Литра"},
				{label: "21 ОБЖ"},
				{label: "22 История"}
			];
			var groupedListData:Array = [
				{label: "1 Математика", items: [{label: "1"},{label: "2"},{label: "3"}]},
				{label: "2 Русский", items: [{label: "1"},{label: "2"},{label: "3"}]},
				{label: "3 Английский", items: [{label: "1"},{label: "2"},{label: "3"}]},
				{label: "4 Физ-ра", items: [{label: "1"},{label: "2"},{label: "3"}]},
				{label: "5 Природа", items: [{label: "1"},{label: "2"},{label: "3"}]},
				{label: "6 музыка", items: [{label: "1"},{label: "2"},{label: "3"}]},
				{label: "7 ИЗО", items: [{label: "1"},{label: "2"},{label: "3"}]},
				{label: "8 Труды", items: [{label: "1"},{label: "2"},{label: "3"}]},
				{label: "9 Литра", items: [{label: "1"},{label: "2"},{label: "3"}]},
				{label: "10 ОБЖ", items: [{label: "1"},{label: "2"},{label: "3"}]},
				{label: "11 История", items: [{label: "1"},{label: "2"},{label: "3"}]},
				{label: "12 Математика", items: [{label: "1"},{label: "2"},{label: "3"}]},
				{label: "13 Русский", items: [{label: "1"},{label: "2"},{label: "3"}]},
				{label: "14 Английский", items: [{label: "1"},{label: "2"},{label: "3"}]},
				{label: "15 Физ-ра", items: [{label: "1"},{label: "2"},{label: "3"}]},
				{label: "16 Природа", items: [{label: "1"},{label: "2"},{label: "3"}]},
				{label: "17 музыка", items: [{label: "1"},{label: "2"},{label: "3"}]},
				{label: "18 ИЗО", items: [{label: "1"},{label: "2"},{label: "3"}]},
				{label: "19 Труды", items: [{label: "1"},{label: "2"},{label: "3"}]},
				{label: "20 Литра"},
				{label: "21 ОБЖ"},
				{label: "22 История"}
			];
			var collection:Collection = new Collection(listData);

			var componentControl:Component = new Component(collection);
			addChild(componentControl);

			collection.addItem({label: "1"});
			collection.removeItem(listData[1]);

			var checkBox:CheckBox = new CheckBox({label: "fuck off"});
			moveTo(checkBox, componentControl.x + componentControl.width);
			addChild(checkBox);

			var item:Item = new Item({label: "kiss me"});
			moveTo(item, checkBox.x, checkBox.y + checkBox.height);
			addChild(item);

			var groupedCollection:Collection = new Collection(groupedListData);

			var groupedList:GroupedList = new GroupedList(groupedCollection);
			moveTo(groupedList, checkBox.x, item.y + item.height);
			addChild(groupedList);

			var list:List = new List(collection);
			moveTo(list, groupedList.x + groupedList.width);
			addChild(list);
		}
	}

}
