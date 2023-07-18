import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class AppUsingController extends GetxController {
  final _findEmployee = false.obs;

  bool get findEmployee => _findEmployee.isTrue;
  final _findJop = false.obs;

  bool get findJop => _findJop.isTrue;


  bool isdark = false;

  Future<void> findOnJop() async {
    if (_findJop.value) return;
    _findJop.value = true;
    _findEmployee.value = !_findJop.value;
  }

  Future<void> findOnEmployee() async {
    if (_findEmployee.value) return;
    _findEmployee.value = true;
    _findJop.value = !_findEmployee.value;
  }
}
