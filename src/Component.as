package {
	import flash.display.Sprite;

	public class Component extends Sprite {
		public function Component() {
			init();
			if(parent != null)
			{
				parent.addChild(this);
			}
		}

		protected function init():void
		{
			addChildren();
			invalidate();
		}
	}
}
