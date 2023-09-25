import 'package:get/get.dart';

import '../../utils/states.dart';
import '../ConnectivityController/internet_connection_controller.dart';

class UserCommunityController extends GetxController {
  static UserCommunityController get instance => Get.find();
  // final _dashboardController = UserDashBoardController.instance;
  //

  bool get isNetworkConnected =>
      InternetConnectionController.instance.isConnected;
  final _selected = 0.obs;
  final _states = States().obs;

  States get states => _states.value;

  void resetStates() => _states.value = States();

  void changeStates({
    bool? isLoading,
    bool? isSuccess,
    bool? isError,
    bool? isWarning,
    String? message,
    String? error,
  }) {
    print("is loading:  $isLoading");
    _states.value = states.copyWith(
      isLoading: isLoading,
      isSuccess: isLoading == true ? false : isSuccess,
      isError: isLoading == true ? false : isError,
      message: message,
      isWarning: isLoading == true ? false : isWarning,
      error: error,
    );
  }

  int get selected => _selected.toInt();

  void switchSelectedTap(int value) {
    _selected.value = value < 2 ? value : selected;
  }

  @override
  void onInit() {
    super.onInit();
  }
}
