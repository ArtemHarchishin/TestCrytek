package {

	import flash.display.MovieClip;

	public class Main extends MovieClip {

		public function Main() {
			var data:Array = [
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
			var collection:Collection = new Collection(data);

			var componentControl:Component = new Component(collection);
			addChild(componentControl);

			collection.addItem({label: "1"});
			collection.removeItem(data[1]);
		}
	}

}
