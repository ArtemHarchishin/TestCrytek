package {
	import flash.display.MovieClip;

	public interface IGroupItemView {
		function set selected(value:Boolean):void

		function set label(value:String):void

		function get toggleSelect():MovieClip

		function get itemsContainer():MovieClip

		function get btnDelete():MovieClip

		function get hittingArea():MovieClip

		function get height():Number;
	}
}
