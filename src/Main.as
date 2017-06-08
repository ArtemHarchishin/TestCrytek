package {

	import flash.display.MovieClip;
	import flash.events.Event;

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
				{label: "1 Математика", items: [{label: "1"}, {label: "2"}, {label: "3"}]},
				{label: "2 Русский", items: [{label: "1"}, {label: "2"}, {label: "3"}]},
				{label: "3 Английский", items: [{label: "1"}, {label: "2"}, {label: "3"}]},
				{label: "4 Физ-ра", items: [{label: "1"}, {label: "2"}, {label: "3"}]},
				{label: "5 Природа", items: [{label: "1"}, {label: "2"}, {label: "3"}]},
				{label: "6 музыка", items: [{label: "1"}, {label: "2"}, {label: "3"}]},
				{label: "7 ИЗО", items: [{label: "1"}, {label: "2"}, {label: "3"}]},
				{label: "8 Труды", items: [{label: "1"}, {label: "2"}, {label: "3"}]},
				{label: "9 Литра", items: [{label: "1"}, {label: "2"}, {label: "3"}]},
				{label: "10 ОБЖ", items: [{label: "1"}, {label: "2"}, {label: "3"}]},
				{label: "11 История", items: [{label: "1"}, {label: "2"}, {label: "3"}]},
				{label: "12 Математика", items: [{label: "1"}, {label: "2"}, {label: "3"}]},
				{label: "13 Русский", items: [{label: "1"}, {label: "2"}, {label: "3"}]},
				{label: "14 Английский", items: [{label: "1"}, {label: "2"}, {label: "3"}]},
				{label: "15 Физ-ра", items: [{label: "1"}, {label: "2"}, {label: "3"}]},
				{label: "16 Природа", items: [{label: "1"}, {label: "2"}, {label: "3"}]},
				{label: "17 музыка", items: [{label: "1"}, {label: "2"}, {label: "3"}]},
				{label: "18 ИЗО", items: [{label: "1"}, {label: "2"}, {label: "3"}]},
				{label: "19 Труды", items: [{label: "1"}, {label: "2"}, {label: "3"}]},
				{label: "20 Литра"},
				{label: "21 ОБЖ"},
				{label: "22 История"}
			];

			var hierarchicalData:Array = [
				{ label: "Kerkira", items: [{ label: "Characters", items: [{label: "John"}, {label: "Phil"}]}, { label: "Events", items: [{label: "Psytrance party"}, {label: "Singing Fountains"}]}, { label: "Points of interest", items: [{label: "Drags"}, {label: "Rock'n'Roll"}]}]},
				{ label: "Kiev", items: []},
				{ label: "Lviv", items: []},
				{ label: "Odessa", items: []},
				{ label: "Rzecszow"}
			];
			var collection:Collection = new Collection(listData);
			var groupedCollection:GroupedCollection = new GroupedCollection(groupedListData);

			var componentControl:Component = new Component();
			componentControl.dataProvider = new GroupedCollection(hierarchicalData);
			addChild(componentControl);

			collection.addItem({label: "1"});
			collection.removeItem(listData[1]);
			collection.getItemAt(0);
			collection.getLength();

			var checkBox:CheckBox = new CheckBox({label: "fuck off"});
			checkBox.addEventListener(Event.SELECT, function (e:Event):void {
				trace(checkBox.selected);
			});
			moveTo(checkBox, componentControl.x + componentControl.width);
			addChild(checkBox);

			var item:Item = new Item({label: "kiss me"});
			item.addEventListener(Event.SELECT, function (e:Event):void {
				o(item.data);
			});
			moveTo(item, checkBox.x, checkBox.y + checkBox.height);
			addChild(item);


			var groupedList:GroupedList = new GroupedList();
			groupedList.dataProvider = groupedCollection;
			groupedList.addEventListener(Event.SELECT, function (e:Event):void {
				o(groupedList.selectedItem.data);
			});
			moveTo(groupedList, checkBox.x, item.y + item.height);
			addChild(groupedList);

			groupedCollection.getItemAt(0);

			groupedCollection.addGroupItem({label: "new Group Item123"});
			groupedCollection.addGroupItem({label: "123new Group Item", items:[{label:"new item 1"},{label:"new item 2"}]});

			groupedCollection.removeItem(groupedListData[2]);
			groupedCollection.removeItem(groupedListData[2], {});

			groupedCollection.addItem(groupedListData[2], {label: "added item2"});
			groupedCollection.addItem(groupedListData[20], {label: "added item3"});
			groupedCollection.addItem({label:"empty"}, {label: "added item 123"});

			var list:List = new List();
			list.dataProvider = collection;
			list.addEventListener(Event.SELECT, function (e:Event):void {
				o(list.selectedItem.data);
			});
			moveTo(list, groupedList.x + groupedList.width);
			addChild(list);
		}
	}

}
