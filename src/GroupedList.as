package {
	public class GroupedList extends List {
		public function GroupedList(data:Collection) {
			super(data);
			itemType = GroupItem;
		}
	}
}
