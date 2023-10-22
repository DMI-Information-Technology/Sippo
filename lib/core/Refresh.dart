class Refresher {
  static bool dataListUpdater<T>({
    List<T>? newData,
    required List<T> currentData,
    required void Function(List<T> data) updateData,
  }) {
    print("Refresh.listUpdater: the newData is null ? = ${newData == null}.");
    if (newData == null) return false;
    if (currentData.isEmpty || newData.length != currentData.length) {
      updateData(newData);
      return true;
    }
    final isNew = newData.any((value) => !currentData.contains(value));
    print(
      "Refresh.listUpdater: is the there is any new data ? = ${isNew}.",
    );
    if (isNew) {
      updateData(newData);
      return true;
    }
    return false;
  }

  static List<T>? changePropertyItemState<T>(
    List<T>? itemList,
    int index, {
    required T Function(T newItem) newItemChanger,
  }) {
    if (itemList == null) return itemList;
    if (index > -1 && index < itemList.length) {
      final newItem = newItemChanger(itemList[index]);
      if (newItem == null) return itemList;
      return itemList.toList()..[index] = newItem;
    }
    return itemList;
  }
}
