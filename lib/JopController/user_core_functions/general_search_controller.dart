import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jobspot/utils/getx_text_editing_controller.dart';

import '../../utils/states.dart';

class UserGeneralSearchController extends GetxController {
  static UserGeneralSearchController get instance => Get.find();
  final _state = States().obs;

  States get state => _state.value;
  final generalSearchState = GeneralSearchState();

  @override
  void onInit() {
    super.onInit();
    generalSearchState.startListenState();
  }

  @override
  void onClose() {
    generalSearchState.close();
    super.onClose();
  }
}

class GeneralSearchState {
  final searchController = GetXTextEditingController();
  final _isArrowBack = true.obs;

  bool get isArrowBack => _isArrowBack.isTrue;

  set isArrowBack(bool value) {
    _isArrowBack.value = value;
  }

  final _isJobTab = false.obs;
  final focusNode = FocusNode();

  bool get isJobTab => _isJobTab.isTrue;

  set isJobTab(bool value) {
    _isJobTab.value = value;
  }

  void startListenState() {
    focusNode.addListener(_onHasFocus);
  }

  void _onHasFocus() {
    print(isArrowBack);
    isArrowBack = !focusNode.hasFocus;
  }

  void close() {
    searchController.dispose();
    focusNode.removeListener(_onHasFocus);
    focusNode.dispose();
  }
}
