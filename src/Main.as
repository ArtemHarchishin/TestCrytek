package {

	import flash.display.MovieClip;

	import old.Component;

	public class Main extends MovieClip {

		public function Main() {
			var arr:Array = [
				{label: "John", items: [], selectable: false, asset: Category},
				{label: "Phil", asset: Subcategory, items: [{label: "delete me", items: [], asset: Subcategory}]},
				{
					label: "Psytrance party",
					asset: Category,
					items: [{
						label: "1",
						asset: Subcategory,
						items: [{label: "6", asset: Item}, {label: "5", asset: Item}, {
							label: "4",
							asset: Item
						}, {label: "3", asset: Item}]
					}]
				},
				{label: "Singing Fountains", items: [{label: "1", items: [{label: "2"}]}], deletable: false},
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
			var arr1:Array = [
				{label: "John", asset: Item, deletable: false},
				{label: "Phil", asset: Item, deletable: false},
				{label: "Psytrance party", asset: Item, deletable: false},
				{label: "Singing Fountains", asset: Item, deletable: false},
				{label: "Drags", asset: Item, deletable: false},
				{label: "Rock'n'Roll", asset: Item, deletable: false},
				{label: "item3", asset: Item, deletable: false},
				{label: "item1", asset: Item, deletable: false},
				{label: "item2", asset: Item, deletable: false},
				{label: "Rock'n'Roll", asset: Item, deletable: false},
				{label: "Rock'n'Roll2", asset: Item, deletable: false},
				{label: "Rock'n'Roll3", asset: Item, deletable: false},
				{label: "Rock'n'Roll4", asset: Item, deletable: false},
				{label: "Rock'n'Roll5", asset: Item, deletable: false},
				{label: "Rock'n'Roll6", asset: Item, deletable: false},
				{label: "Rock'n'Roll7", asset: Item, deletable: false},
				{label: "Rock'n'Roll8", asset: Item, deletable: false},
				{label: "Rock'n'Roll9", asset: Item, deletable: false},
				{label: "Rock'n'Roll10", asset: Item, deletable: false}
			];

			var component:Component = new Component();
			component.data = arr;
			addChild(component);

			var component1:Component = new Component();
			component1.x = 300;
			component1.data = arr1;
			addChild(component1);
		}
	}

}
