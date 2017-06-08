package {
	import flash.display.DisplayObject;

	public interface IListView {

		function get numItems():int

		function removeItemAt(i:int):DisplayObject

		function addItem(item:DisplayObject):DisplayObject

		function getItemAt(i:int):DisplayObject

		function removeItem(item:DisplayObject):DisplayObject

		function setItemIndex(item:View, i:int):void
	}
}
