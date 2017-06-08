package {

	public class GroupedCollection extends Collection {

		public function GroupedCollection(data:Array = null) {
			super(data);
		}

		override public function removeItem(...args):void {
			if (args.length == 2) {
				var groupItem:Object;
				if (args[0] is Array && args[0].length > 0) {
					var groups:Array = args[0];
					for (var j:int = groups.length; j >= 0; j--) {
						groupItem = groups[j];
					}
					removeItemInGroup(groupItem, args[1]);
				} else if (args[0] is Array && args[0].length == 0) {
					removeGroupItem(args[1]);
				} else {
					groupItem = args[0];
					removeItemInGroup(groupItem, args[1]);
				}
			} else if (args.length == 1) {
				removeGroupItem(args[0]);
			}
		}

		override public function addItem(...args):void {
			var groupItem:Object = args[0];
			var item:Object = args[1];
			groupItem['items'] ||= [];
			groupItem['items'].push(item);
			if (data.indexOf(groupItem) == -1) {
				data.push(groupItem);
				dispatchEventWith(CollectionEventType.ADD_GROUP_ITEM, groupItem);
			} else {
				dispatchEventWith(CollectionEventType.ADD_ITEM, item);
			}
		}

		override public function getItemAt(index:int):Object {
			return data[index];
		}

		override public function getLength():int {
			return data.length;
		}

		override public function reverse():void {
			data.reverse();
			dispatchEventWith(CollectionEventType.SORT_REVERSE);
		}

		public function addGroupItem(item:Object):void {
			data.push(item);
			dispatchEventWith(CollectionEventType.ADD_GROUP_ITEM, item);
		}

		private function removeItemInGroup(groupItem:Object, item:Object):void {
			if (groupItem.hasOwnProperty("items") && groupItem["items"] is Array) {
				var items:Array = groupItem['items'];
				var i:int = items.indexOf(item);
				if (i >= 0) {
					items.splice(i, 1);
					dispatchEventWith(CollectionEventType.REMOVE_ITEM, item);
				}
			}
		}

		private function removeGroupItem(groupItem:Object):void {
			var i:int = data.indexOf(groupItem);
			if (i >= 0) {
				data.splice(i, 1);
				dispatchEventWith(CollectionEventType.REMOVE_GROUP_ITEM, groupItem);
			}
		}
	}
}
