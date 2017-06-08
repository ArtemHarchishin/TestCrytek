package controls {
	import flash.events.Event;
	import flash.text.TextField;

	import utils.createField;

	public class Lessons extends Control {
		private var _list:List;
		private var _tf:TextField;

		public function Lessons() {}

		override protected function initialize():void {
			_list = new List();
			_list.dataProvider = dataProvider;
			_list.addEventListener(Event.SELECT, list_selectHandler);
			addChild(_list);

			_tf = createField("", _list.x + _list.width, 0, 500, 500, true);
			_tf.border = true;
			addChild(_tf);
		}

		override protected function dispose():void {
			_list.removeEventListener(Event.SELECT, list_selectHandler);
			_list = null;
			_tf = null;
		}

		override protected function commitData():void {
			// empty
		}

		private function list_selectHandler(e:Event):void {
			var datum:String = _list.selectedItem.data['text'];
			var text:Array = datum.split(" ");
			_tf.text = text.join("\n");
		}
	}
}
