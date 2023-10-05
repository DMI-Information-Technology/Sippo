import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:jobspot/JopController/ConnectivityController/internet_connection_controller.dart';
import 'package:jobspot/sippo_data/model/profile_model/profile_resource_model/profile_edit_model.dart';

import '../../sippo_data/user_repos/edit_profile_repo.dart';
import '../../sippo_pages/sippo_user_pages/sippo_user_community/sippo_user_community.dart';
import '../../sippo_pages/sippo_user_pages/sippo_user_home.dart';
import '../../sippo_pages/sippo_user_pages/sippo_user_notification.dart';
import '../../sippo_pages/sippo_user_pages/sippo_user_saved_jobs.dart';

class UserDashBoardController extends GetxController {
  // final _httpClientController = Get.put(HttpClientController());
  static UserDashBoardController get instance => Get.find();

  final _user = ProfileInfoModel().obs;
  StreamSubscription<bool>? _connectionSubscription;

  ProfileInfoModel get user => _user.value;
  // final  jobDashboardState =
  //     GlobalSharedState(details: CompanyJobModel().obs);
  // final companyDashboardState = GlobalSharedState(
  //   details: CompanyDetailsResponseModel().obs,
  // );

  void set user(ProfileInfoModel profile) => _user.value = profile;
  final _selectedItemIndex = 0.obs;
  final List<Widget> _pages = const [
    SippoUserHome(),
    SippoUserCommunity(),
    SippoUserJobNotification(),
    SippoUserSavedJob(),
  ];

  Future<void> getUserProfile() async {
    final response = await ProfileInfoRepo.getUserProfile();
    response?.checkStatusResponse(
      onSuccess: (data, _) {
        if (data == null) return;
        print("getUserProfile: is equal to user ? = ${data == _user.value}");
        if (data == _user.value) return;
        _user.value = data;
      },
      onValidateError: (error, _) {},
      onError: (message, statusType) {},
    );
  }

  List<Widget> get pages => _pages;

  int get selectedItemIndex => _selectedItemIndex.toInt();

  void set selectedItemIndex(int value) {
    _selectedItemIndex.value = value;
  }

  Future<void> _connected(bool isConn) async {
    print("UserDashboardController: is connected ? = $isConn");
    print("UserDashboardController: name ? = ${user.name}");
    print("UserDashboardController: name ? = ${user.phone}");
    print("UserDashboardController: is user blank ? = ${user.isProfileBlank}");
    if (!user.isProfileBlank) {
      _connectionSubscription?.cancel();
      _connectionSubscription = null;
      // return true;
    }
    if (isConn) {
      await getUserProfile();
    }
    // return false;
  }

  void _startListeningToConnection() async {
    // Timer.periodic(Duration(seconds: 1), (timer) async {
    //   if (await _connected(InternetConnectionController.instance.isConnected)) {
    //     timer.cancel();
    //   }
    // });
    _connectionSubscription = InternetConnectionController
        .instance.isConnectedStream
        .listen(_connected);
    print(_connectionSubscription != null);
    await getUserProfile();
  }

  Future<void> userInformationRefresh() async {
    await getUserProfile();
  }

  @override
  void onInit() {
    _startListeningToConnection();
    // _user.value = ProfileInfoModel.fromJson(GlobalStorage.userJson);
    print("UserDashBoardController onInit: ${_user.value}");
    super.onInit();
  }

  @override
  void onClose() {
    if (_connectionSubscription != null) _connectionSubscription?.cancel();
    super.onClose();
  }
}
