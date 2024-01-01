import 'package:get/get.dart';
import 'package:sippo/JobServices/ConnectivityController/internet_connection_controller.dart';
import 'package:sippo/sippo_data/ads_repo/ads_repo.dart';
import 'package:sippo/sippo_data/model/ads_model/ad_model.dart';
import 'package:sippo/utils/states.dart';

class AdsViewController extends GetxController {
  static AdsViewController get instance => Get.find();
  final _states = States().obs;

  States get states => _states.value;

  void set states(States value) => _states.value = value;
  final _adItems = <AdModel>[].obs;

  List<AdModel> get adItems => _adItems.toList();

  void set adItems(List<AdModel> value) => _adItems.value = value;

  Future<void> fetchAds() async {
    if (InternetConnectionService.instance.isNotConnected) return;
    if (states.isLoading) return;
    states = States(isLoading: true);
    final response = await AdsRepo.fetchAds();
    states = States(isLoading: false);
    await response.checkStatusResponse(
      onSuccess: (data, _) {
        if (data case List<AdModel> items) {
          adItems = items;
          states = states.copyWith(isSuccess: true);
        }
      },
      onValidateError: (validateError, _) {
        states = states.copyWith(
          isError: true,
          message: 'something_wrong_happened'.tr,
        );
      },
      onError: (message, _) {
        states = states.copyWith(isError: true, message: message);
      },
    );
  }

  @override
  void onInit() {
    super.onInit();
    fetchAds();
  }
}
