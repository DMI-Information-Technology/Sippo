import 'package:get/get.dart';
import 'package:jobspot/JobGlobalclass/global_storage.dart';
import 'package:jobspot/core/api_endpoints.dart' as apiUrl;
import 'package:jobspot/core/http_client.dart';

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
