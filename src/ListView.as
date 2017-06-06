package {
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.geom.Rectangle;

	public class ListView extends View {

		private var _scrollBar:ScrollBarView;
		private var _itemsContainer:MovieClip;

		public function get numItems():int {return _itemsContainer.numChildren;}

		public function ListView() {
			_scrollBar = this["scroll_bar"];
			_itemsContainer = this["items_container"];
		}

		override protected function initialize():void {
			scrollRect = new Rectangle(0, 0, 240, 365);
			_scrollBar.mouseWheelContent = _itemsContainer;
			// TODO добавить функционал - скрывать скролл когда он не нужен
			_scrollBar.addEventListener(Event.CHANGE, scrollbar_changeHandler);
		}

		override protected function dispose():void {
			_scrollBar.removeEventListener(Event.CHANGE, scrollbar_changeHandler);
			_scrollBar = null;
			_itemsContainer = null;
		}

		public function removeItemAt(i:int):DisplayObject {
			return _itemsContainer.removeChildAt(i);
		}

		public function addItem(item:DisplayObject):DisplayObject {
			return _itemsContainer.addChild(item);
		}

		public function getItemAt(i:int):DisplayObject {
			return _itemsContainer.getChildAt(i);
		}

		public function removeItem(item:DisplayObject):DisplayObject {
			return _itemsContainer.removeChild(item);
		}

		public function setItemIndex(item:View, i:int):void {
			_itemsContainer.setChildIndex(item, i);
		}

		private function scrollbar_changeHandler(e:Event):void {
			if (_itemsContainer.height <= 365) return;
			_itemsContainer.y = -((_itemsContainer.height - 365) / 100 * _scrollBar.value);
		}
	}
}
