
import 'package:get/get.dart';
import 'package:jobspot/JobGlobalclass/global_storage.dart';
import 'package:jobspot/JobGlobalclass/routes.dart';
import 'package:jobspot/sippo_data/model/auth_model/company_response_details.dart';
import 'package:jobspot/sippo_data/model/profile_model/company_profile_resource_model/company_job_model.dart';
import 'package:jobspot/sippo_data/model/profile_model/company_profile_resource_model/company_user_profile_view_model.dart';
import 'package:jobspot/utils/app_use.dart';
import 'package:jobspot/utils/global_shared_state.dart';

class SharedGlobalDataService extends GetxService {
  static SharedGlobalDataService get instance => Get.find();
  var profileIdState = -1;
  final jobGlobalState = GlobalSharedState(details: CompanyJobModel().obs);
  final profileViewGlobalState =
      GlobalSharedState(details: ProfileViewResourceModel().obs);
  final companyGlobalState = GlobalSharedState(
    details: CompanyDetailsModel().obs,
  );

  static void onJobTap(CompanyJobModel? item) async {
    final localInstance = instance;
    final id = item?.id;
    if (id == null) return;
    localInstance.jobGlobalState.id = id;
    localInstance.jobGlobalState.details = item;
    await Get.toNamed(SippoRoutes.sippoJobDescription);
    localInstance.jobGlobalState.clearDetails(() => CompanyJobModel());
  }

  static void onCompanyTap(CompanyDetailsModel? item) async {
    final localInstance = instance;
    final id = item?.id;
    if (id == null) return;
    localInstance.companyGlobalState.id = id;
    localInstance.companyGlobalState.details = item;
    await Get.toNamed(SippoRoutes.sippoAboutCompanies);
    localInstance.companyGlobalState
        .clearDetails(() => CompanyDetailsModel());
  }

  static void onProfileViewTap({
    ProfileViewResourceModel? item,
    int? profId,
  }) async {
    final localInstance = instance;
    final id = item?.userInfo?.id ?? profId;
    if (id == null) return;
    localInstance.profileViewGlobalState.id = id;
    localInstance.profileViewGlobalState.details = item;
    await Get.toNamed(SippoRoutes.sippoCompanyUserProfileView);
    localInstance.profileViewGlobalState.clearDetails(
      () => ProfileViewResourceModel(),
    );
  }

  static void onActionJobTapped(List args) async {
    switch (GlobalStorageService.appUse) {
      case AppUsingType.user:
        break;
      case AppUsingType.company:
        break;
    }
  }

  var searchTextKey = "";
}
