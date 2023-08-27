import 'package:get/get.dart';
import 'package:jobspot/JopController/HttpClientController/http_client_controller.dart';

class HttpClientBindingController implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HttpClientController>(() => (HttpClientController()));
  }

  const HttpClientBindingController();
}
