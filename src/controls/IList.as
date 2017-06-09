package controls {
	import datas.Collection;

	public interface IList {
		function get selectedItem():Control;

		function updatePosition():void;

		function addEventListener(type:String,listener:Function,useCapture:Boolean = false,priority:int = 0,useWeakReference:Boolean = false):void;

		function set dataProvider(dataProvider:Collection):void;
	}
}
