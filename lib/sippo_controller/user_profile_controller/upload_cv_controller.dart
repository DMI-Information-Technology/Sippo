import 'package:get/get.dart';
import 'package:jobspot/sippo_controller/user_profile_controller/profile_user_controller.dart';
import 'package:jobspot/sippo_data/model/profile_model/profile_resource_model/profile_edit_model.dart';

import 'package:jobspot/sippo_data/model/custom_file_model/custom_file_model.dart';
import 'package:jobspot/sippo_data/user_repos/add_delete_cv_repo.dart';
import 'package:jobspot/utils/file_picker_service.dart';
import 'package:jobspot/utils/states.dart';
import '../dashboards_controller/user_dashboard_controller.dart';

class UploadCvController extends GetxController {
  static UploadCvController get instance => Get.find();
  final dashboard = UserDashBoardController.instance;

  ProfileState get profileState => ProfileUserController.instance.profileState;

  ProfileInfoModel get user => dashboard.user;
  final _states = States().obs;

  States get states => _states.value;

  void changeStates({
    bool? isLoading,
    bool? isSuccess,
    bool? isError,
    bool? isWarning,
    String? message,
    String? error,
  }) {
    _states.value = states.copyWith(
      isLoading: isLoading,
      isSuccess: isLoading == true ? false : isSuccess,
      isError: isLoading == true ? false : isError,
      message: message,
      isWarning: isLoading == true ? false : isWarning,
      error: error,
    );
  }

  Future<void> uploadCvFile() async {
    if (dashboard.user.cv != null || profileState.cvFile.isFileNull) return;
    final response = await CvUploaderRepo.addCvFile(profileState.cvFile);
    await response?.checkStatusResponse(
      onSuccess: (data, _) {
        if (data != null) {
          dashboard.user = dashboard.user.copyWith(cv: data);
          profileState.profileView =
              profileState.profileView.copyWith(cv: data);
          profileState.cvFile = CustomFileModel();
        }
      },
      onValidateError: (validateError, _) {},
      onError: (message, _) {},
    );
  }

  Future<void> deleteCvFile() async {
    if (dashboard.user.cv == null) return;
    final response = await CvUploaderRepo.deleteCvFile();
    await response?.checkStatusResponse(
      onSuccess: (data, _) {
        if (data != null) {
          dashboard.user = dashboard.user.copyWithRemoveCv();
        }
      },
      onValidateError: (validateError, _) {},
      onError: (message, _) {},
    );
  }

  Future<void> removeCvFile() async {
    if (user.cv != null) {
      await deleteCvFile();
    } else {
      profileState.cvFile = CustomFileModel();
    }
  }

  Future<void> uploadFileCvFromStorage() async {
    if (await FilePickerService.uploadFileCv() case final result?)
      profileState.cvFile = result;
  }
}
