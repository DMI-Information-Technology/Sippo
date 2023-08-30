import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:jobspot/JobGlobalclass/global_storage.dart';
import 'package:jobspot/sippo_data/model/auth_model/user_response_model.dart';

import '../../sippo_pages/Joborderpages/jobstop_oderpage.dart';
import '../../sippo_pages/Jobpostpages/jobstop_posting.dart';
import '../../sippo_pages/sippo_user_pages/sippo_user_home.dart';
import '../../sippo_pages/sippo_user_pages/sippo_user_notification.dart';

class UserDashBoardController extends GetxController {
  // final _httpClientController = Get.put(HttpClientController());
  static UserDashBoardController get instance => Get.find();
  final _user = UserResponseModel().obs;

  UserResponseModel get user => _user.value;
  final _selectedItemIndex = 0.obs;
  final List<Widget> _pages = const [
    SippoUserHome(),
    SippoUserSocial(),
    SippoUserJobNotification(),
    JobstopOrder(),
  ];

  List<Widget> get pages => _pages;

  int get selectedItemIndex => _selectedItemIndex.toInt();

  void set selectedItemIndex(int value) {
    _selectedItemIndex.value = value;
  }

  @override
  void onInit() {
    _user.value = UserResponseModel.fromJson(GlobalStorage.userJson);
    print("UserDashBoardController onInit: ${_user.value}");
    super.onInit();
  }
}
