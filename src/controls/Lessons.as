package controls {
	import events.DataEvent;
	import events.ItemEventType;

	import flash.events.Event;
	import flash.text.TextField;

	import utils.createField;

	public class Lessons extends Control {
		private var _component:Component;
		private var _tf:TextField;

		public function Lessons() {}

		override protected function initialize():void {
			_component = new Component();
			_component.dataProvider = dataProvider;
			_component.itemFactory = function (o:*):Control {
				return new List();
			};
			_component.addEventListener(ItemEventType.SELECT, component_selectHandler);
			addChild(_component);

			_tf = createField("", _component.x + _component.width, 0, 500, 500, true);
			_tf.border = true;
			addChild(_tf);
		}

		override protected function dispose():void {
			_component.removeEventListener(Event.SELECT, component_selectHandler);
			_component = null;
			_tf = null;
		}

		override protected function commitData():void {
			// empty
		}

		private function component_selectHandler(e:DataEvent):void {
			var datum:String = (e.data as Control).data['text'];
			var text:Array = datum.split(" ");
			_tf.text = text.join("\n");
		}
	}
}
