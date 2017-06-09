package controls {
	import events.DataEvent;
	import events.ItemEventType;

	import flash.display.DisplayObject;
	import flash.events.Event;
	import flash.events.FocusEvent;
	import flash.events.TextEvent;
	import flash.text.TextField;

	public class Component extends Control {
		protected var _view:ComponentView;

		private var _checkBoxSort:CheckBox;
		private var _list:IList;

		public function Component() {
			viewType = ComponentView;
			itemType = GroupedList;
		}

		override protected function initialize():void {
			_view = ComponentView(createView());

			_checkBoxSort = new CheckBox({label: "newest to oldest"});
			_checkBoxSort.addEventListener(ItemEventType.SELECT, checkBox_selectHandler);
			_view.checkboxContainer.addChild(_checkBoxSort);

			_list = IList(createItem());
			_list.addEventListener(Event.SELECT, list_selectHandler);
			_list.dataProvider = dataProvider;

			_view.listContainer.addChild(DisplayObject(_list));

			_view.tfFuzzySearch.addEventListener(Event.CHANGE, textChangeHandler);
			_view.tfFuzzySearch.addEventListener(FocusEvent.FOCUS_OUT, focusOutHandler);

			addChild(_view);
		}

		override protected function commitData():void {
			// empty
		}

		override protected function dispose():void {
			_view.tfFuzzySearch.removeEventListener(Event.CHANGE, textChangeHandler);
			_view.listContainer.removeChild(DisplayObject(_list));
			_view.checkboxContainer.removeChild(_checkBoxSort);
			removeChild(_view);
			_view = null;
		}

		private function checkBox_selectHandler(e:DataEvent):void {
			var checkBox:CheckBox = e.data as CheckBox;
			if (checkBox.selected) {
				dataProvider.reverse();
			} else {
				dataProvider.sortAlphabetical();
			}
		}

		private function list_selectHandler(e:Event):void {
			dispatchEvent(new DataEvent(ItemEventType.SELECT, _list.selectedItem));
		}

		private function textChangeHandler(e:Event):void {
			var tf:TextField = e.currentTarget as TextField;
			var length:int = tf.text.length;
			var pattern:String = "(";
			for (var i:int = 0; i < length; i++) {
				pattern += tf.text.charAt(i) + "|";
			}
			pattern = pattern.slice(0, pattern.length - 1);
			pattern += ")";
			dataProvider.filterOn(new RegExp(pattern));
		}

		private function focusOutHandler(e:FocusEvent):void {
			trace(1);
			dataProvider.filterOff();
		}
	}
}
