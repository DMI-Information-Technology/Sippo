import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:sippo/JobServices/ConnectivityController/internet_connection_controller.dart';
import 'package:sippo/sippo_controller/dashboards_controller/company_dashboard_controller.dart';
import 'package:sippo/sippo_data/company_repos/company_posts_repo.dart';
import 'package:sippo/sippo_data/model/custom_file_model/custom_file_model.dart';
import 'package:sippo/sippo_data/model/profile_model/company_profile_resource_model/company_post_model.dart';
import 'package:sippo/utils/getx_text_editing_controller.dart';
import 'package:sippo/utils/image_picker_service.dart';
import 'package:sippo/utils/states.dart';

import 'package:sippo/sippo_data/model/auth_model/company_response_details.dart';
import 'package:sippo/sippo_data/model/image_resource_model/image_resource_model.dart';

import '../../JobGlobalclass/jobstopcolor.dart';
import '../../JobGlobalclass/sippo_customstyle.dart';

class CompanyEditAddPostController extends GetxController {
  final CompanyPostState newPostState = CompanyPostState();
  final _states = States().obs;
  final _post = CompanyDetailsPostModel().obs;
  final GlobalKey<FormState> formKey = GlobalKey();

  final _dashboardController = CompanyDashBoardController.instance;

  bool get isNetworkConnection =>
      InternetConnectionService.instance.isConnected;

  CompanyDetailsModel get company => _dashboardController.company;

  static CompanyEditAddPostController get instance => Get.find();

  States get states => _states.value;

  CompanyDetailsPostModel get post => _post.value;

  bool get isEditing => _dashboardController.dashboardState.editId != -1;

  Future<void> addNewCompanyPost() async {
    // make response
    final response = await CompanyPostRepo.addNewPost(newPostState.form);
    // check response
    await response?.checkStatusResponse(
      onSuccess: (data, _) async {
        popOut();
        successState(true, 'new_post_added_message'.tr);
      },
      onValidateError: (validateError, _) {
        errorState(true, validateError?.message);
      },
      onError: (message, _) {
        errorState(true, message);
      },
    );
  }

  Future<void> updateCompanyPost() async {
    final newPost = newPostState.formWithId(_post.value.id);
    print('image url is ${newPostState.imageUrl.url}');
    if (newPost.isContentEqualTo(post) && newPost.image?.file == null) {
      print(
        "CompanyPostController.updateCompanyPost: "
        "nothing change ? = "
        "${newPost.isContentEqualTo(post) && newPost.image?.file == null}",
      );
      return warningState(true, "nothing is changed in the post.");
    }
    final response = await CompanyPostRepo.updatePostCompanyById(
      newPost,
      post.id,
    );
    await response?.checkStatusResponse(
      onSuccess: (data, _) async {
        if (data != null) {
          newPostState.isUpdated = true;
          popOut();
        }
        successState(true, 'post_updated_message'.tr);
      },
      onValidateError: (validateError, _) {
        errorState(true, validateError?.message);
      },
      onError: (message, _) {
        errorState(true, message);
      },
    );
  }

  Future<CompanyDetailsPostModel?> getCompanyPostById(int id) async {
    final response = await CompanyPostRepo.getPostById(id);
    final data = await response?.checkStatusResponseAndGetData(
      onValidateError: (validateError, _) {
        _states.value =
            states.copyWith(isError: true, error: validateError?.message);
      },
      onError: (message, _) {
        _states.value = states.copyWith(isError: true, error: message);
      },
    );
    return data;
  }

  void successState(bool value, [String? message]) {
    _states.value = states.copyWith(isSuccess: value, message: message);
  }

  void errorState(bool value, [String? message]) {
    _states.value = states.copyWith(isError: value, message: message);
  }

  void warningState(bool value, [String? message]) {
    _states.value = states.copyWith(isWarning: value, message: message);
  }

  Future<void> onSaveSubmitted() async {
    if (!isNetworkConnection) {
      return warningState(
        true,
        "connection_lost_message_1".tr,
      );
    }
    _states.value = States(isLoading: true);
    if (isEditing) {
      await updateCompanyPost();
    } else {
      await addNewCompanyPost();
    }
    _states.value = states.copyWith(isLoading: false);
  }
  void popOut() {
    final localIsEditing = isEditing;
    Get.back(result: true, closeOverlays: true);
    Get.snackbar(
      localIsEditing ? 'edit_post'.tr : 'new_post'.tr,
      localIsEditing ? 'edit_post_done'.tr : 'post_added_successfully'.tr,
      boxShadows: [boxShadow],
      backgroundColor: SippoColor.backgroudHome,
    );
  }

  Future<void> openEditing() async {
    _states.value = states.copyWith(isLoading: true);
    if (isEditing) {
      final editingId = _dashboardController.dashboardState.editId;
      _post.value = await getCompanyPostById(editingId) ?? post;
      print(_post.value);
      if (_post.value.id != null)
        newPostState.setAll(
          _post.value,
        );
    }
    _states.value = states.copyWith(isLoading: false);
  }

  Future<void> uploadImage() async {
    if (newPostState.imageUrl.url != null) {
      _states.value = states.copyWith(
        isError: true,
        message: 'remove_old_image_message'.tr,
      );
      return;
    }
    final image = await ImagePickerFile.pickImageFromGallery();
    print("image path: ${image?.path}");
    if (image == null) return;
    newPostState.setImageFile(
      file: image,
      type: 'image',
      subtype: 'jpg',
      fileField: 'image',
    );
  }

  @override
  void onInit() {
    openEditing();
    super.onInit();
  }

  @override
  void onClose() {
    newPostState.disposeTextControllers();
    super.onClose();
  }
}

class CompanyPostState {
  final title = GetXTextEditingController();
  final description = GetXTextEditingController();
  final _imageFile = CustomFileModel().obs;
  final _imageUrl = ImageResourceModel().obs;
  var isUpdated = false;

  CustomFileModel get imageFile => _imageFile.value;

  ImageResourceModel get imageUrl => _imageUrl.value;

  void set imageUrl(ImageResourceModel value) => _imageUrl.value = value;

  void setImageFile({
    String? fileField,
    String? type,
    String? subtype,
    File? file,
  }) {
    _imageFile.value = imageFile.copyWithFile(
      type: type,
      subtype: subtype,
      file: file,
      fileField: fileField,
    );
  }

  void clearLoadedImage() => _imageFile.value = CustomFileModel();

  void deleteUrlImage() => imageUrl = ImageResourceModel();

  void clearFields() {
    title.text = "";
    description.text = "";
    _imageFile.value = CustomFileModel();
  }

  CompanyPostModel get form => CompanyPostModel(
        title: title.text,
        body: description.text,
        image: imageFile,
      );

  CompanyPostModel formWithId(int? id) => CompanyPostModel(
        id: id,
        title: title.text,
        body: description.text,
        image: imageFile,
      );

  void setAll(CompanyDetailsPostModel value) {
    title.text = value.title ?? "";
    description.text = value.body ?? "";
    imageUrl = value.image ?? imageUrl;
  }

  void disposeTextControllers() {
    title.dispose();
    description.dispose();
  }
}
