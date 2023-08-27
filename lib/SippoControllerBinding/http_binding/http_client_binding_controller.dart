import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/bindings_interface.dart';
import 'package:jobspot/JopController/HttpClientController/http_client_controller.dart';

class HttpClientBindingController implements Bindings {
  @override
  void dependencies() {
    Get.put<HttpClientController>(HttpClientController());
  }
  const HttpClientBindingController();
}
