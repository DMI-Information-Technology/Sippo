class Refresher {
  static bool listUpdater<T>({
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
}
