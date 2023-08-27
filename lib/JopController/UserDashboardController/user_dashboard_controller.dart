import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../sippo_pages/Joborderpages/jobstop_oderpage.dart';
import '../../sippo_pages/Jobpostpages/jobstop_posting.dart';
import '../../sippo_pages/sippo_user_pages/sippo_user_home.dart';
import '../../sippo_pages/sippo_user_pages/sippo_user_notification.dart';

class UserDashBoardController extends GetxController {
  // final _httpClientController = Get.put(HttpClientController());
  final _selectedItemIndex = 0.obs;
  final List<Widget> _pages = const [
    SippoUserHome(),
    JobstopPosting(),
    SippoUserJobNotification(),
    JobstopOrder(),
  ];

  List<Widget> get pages => _pages;

  int get selectedItemIndex => _selectedItemIndex.toInt();

  void set selectedItemIndex(int value) {
    _selectedItemIndex.value = value;
  }
}
