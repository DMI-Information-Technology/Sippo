import 'package:get/get.dart';
import 'package:sippo/JobGlobalclass/global_storage.dart';
import 'package:sippo/core/api_endpoints.dart' as apiUrl;
import 'package:sippo/core/http_client.dart';

class HttpClientController extends GetxController {
  static HttpClientController get instance => Get.find();
  final MyHttpClient client = MyHttpClient(
    baseUrl: apiUrl.baseUrl,
    authToken: GlobalStorageService.tokenLogged ?? "",
  );

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onClose() {
    // client.close();
    super.onClose();
  }
}
