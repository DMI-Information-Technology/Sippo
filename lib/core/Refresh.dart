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
    final filteredData = newData.where((value) {
      return !currentData.contains(value);
    }).toList();
    print(
      "Refresh.listUpdater: is the filteredData list after filtered empty ? = ${filteredData.isEmpty}.",
    );
    if (filteredData.isNotEmpty) {
      updateData(newData);
      return true;
    }
    return false;
  }
}
