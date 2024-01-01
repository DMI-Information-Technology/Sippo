import 'package:get/get.dart';
import 'package:sippo/sippo_controller/HttpClientController/http_client_controller.dart';

class HttpClientBindingController implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HttpClientController>(() => (HttpClientController()));
  }

  const HttpClientBindingController();
}
