package {
	import flash.display.DisplayObjectContainer;

	public class ListControl extends Control {
		protected var _data:Array;

		public function ListControl(parent:DisplayObjectContainer = null, xpos:Number = 0, ypos:Number = 0, items:Array = null) {
			items ||= [];
			_data = items;
		}

		override protected function initialize():void {
		}

		override protected function dispose():void {
		}
	}
}
