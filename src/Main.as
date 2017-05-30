package {

	import flash.display.MovieClip;

	public class Main extends MovieClip {

		public function Main() {
			var arr:Array = [
				{label: "John", items: [{label: "1", items: [{label: "2"}]}]},
				{label: "Phil", items: [{label: "1", items: [{label: "2"}]}]},
				{label: "Psytrance party", items: [{label: "1", items: [{label: "2"}]}]},
				{label: "Singing Fountains", items: [{label: "1", items: [{label: "2"}]}]},
				{label: "Drags", items: [{label: "1", items: [{label: "2"}]}]},
				{label: "Rock'n'Roll", items: [{label: "1", items: [{label: "2"}]}]},
				{label: "item3", items: [{label: "1", items: [{label: "2"}]}]},
				{label: "item1", items: [{label: "1", items: [{label: "2"}]}]},
				{label: "item2", items: [{label: "1", items: [{label: "2"}]}]},
				{label: "Rock'n'Roll", items: [{label: "1", items: [{label: "2"}]}]},
				{label: "Rock'n'Roll2", items: [{label: "1", items: [{label: "2"}]}]},
				{label: "Rock'n'Roll3", items: [{label: "1", items: [{label: "2"}]}]},
				{label: "Rock'n'Roll4", items: [{label: "1", items: [{label: "2"}]}]},
				{label: "Rock'n'Roll5", items: [{label: "1", items: [{label: "2"}]}]},
				{label: "Rock'n'Roll6", items: [{label: "1", items: [{label: "2"}]}]},
				{label: "Rock'n'Roll7", items: [{label: "1", items: [{label: "2"}]}]},
				{label: "Rock'n'Roll8", items: [{label: "1", items: [{label: "2"}]}]},
				{label: "Rock'n'Roll9", items: [{label: "1", items: [{label: "2"}]}]},
				{label: "Rock'n'Roll10", items: [{label: "1", items: [{label: "2"}]}]}
			];

			var component:Component = new Component();
			component.data = arr;
			addChild(component);

		}
	}

}
