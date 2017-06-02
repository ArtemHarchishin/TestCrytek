package {
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.geom.Rectangle;

	public class List extends View {

		private var _scrollBar:MovieClip;
		private var _itemsContainer:MovieClip;

		public function get itemsContainer():MovieClip {
			return _itemsContainer;
		}

		public function List() { }

		override protected function initialize():void {
			_scrollBar = scroll_bar;
			_itemsContainer = items_container;
			scrollRect = new Rectangle(0, 0, 240, 365);
			_scrollBar.addEventListener(Event.CHANGE, scrollbar_changeHandler);
		}

		override protected function dispose():void {
			_scrollBar.removeEventListener(Event.CHANGE, scrollbar_changeHandler);
			_scrollBar = null;
			_itemsContainer = null;
		}

		private function scrollbar_changeHandler(e:Event):void {
			if (_itemsContainer.height <= 365) return;
			_itemsContainer.y = -((_itemsContainer.height - 365) / 100 * _scrollBar.value);
		}
	}
}
