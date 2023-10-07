import 'package:get/get_rx/src/rx_types/rx_types.dart';

class GlobalSharedState<T> {
  GlobalSharedState({required Rx<T?> details}) : this._details = details;

  var _id = -1;

  int get id => _id;

  void set id(int value) {
    _id = value;
  }

  void clearDetails(T? Function() cleaner) {
    id = -1;
    details = cleaner();
    print("details after clear: $details");
  }

  final Rx<T?> _details;

  T? get details => _details.value;

  void set details(T? value) {
    _details(value);
  }
}
