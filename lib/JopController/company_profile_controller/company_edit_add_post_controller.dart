import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:jobspot/JopController/ConnectivityController/internet_connection_controller.dart';
import 'package:jobspot/JopController/dashboards_controller/company_dashboard_controller.dart';
import 'package:jobspot/sippo_data/company_repos/company_posts_repo.dart';
import 'package:jobspot/sippo_data/model/custom_file_model/custom_file_model.dart';
import 'package:jobspot/sippo_data/model/profile_model/company_profile_resource_model/company_post_model.dart';
import 'package:jobspot/utils/getx_text_editing_controller.dart';
import 'package:jobspot/utils/image_picker_service.dart';
import 'package:jobspot/utils/states.dart';

import '../../sippo_data/model/auth_model/company_response_details.dart';

class CompanyEditAddPostController extends GetxController {
  final CompanyPostState newPostState = CompanyPostState();
  final _states = States().obs;
  final _post = CompanyDetailsPostModel().obs;
  final GlobalKey<FormState> formKey = GlobalKey();

  final _dashboardController = CompanyDashBoardController.instance;

  bool get isNetworkConnection =>
      InternetConnectionController.instance.isConnected;

  CompanyDetailsResponseModel get company => _dashboardController.company;

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
        successState(true, 'new post is added successfully.');
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
    final newPost = newPostState.form..id = _post.value.id;
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
          _post.value = data;
          newPostState.setAll(post);
          newPostState.clearLoadedImage();
          newPostState.isUpdated = true;
        }
        successState(true, 'the post updated successfully.');
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
        "sorry your connection is lost, please check your settings before continuing.",
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
        message: "you must remove the old image"
            " from the post before upload new one.",
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
    _imageFile.value = imageFile.copyWith(
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
