import 'package:get/get.dart';
import 'package:jobspot/JobGlobalclass/global_storage.dart';
import 'package:jobspot/utils/app_use.dart';

import '../JobGlobalclass/routes.dart';
import '../sippo_data/model/auth_model/company_response_details.dart';
import '../sippo_data/model/profile_model/company_profile_resource_model/company_job_model.dart';
import '../utils/global_shared_state.dart';

class SharedGlobalDataService extends GetxService {
  static SharedGlobalDataService get instance => Get.find();
  final jobGlobalState = GlobalSharedState(details: CompanyJobModel().obs);
  final companyGlobalState = GlobalSharedState(
    details: CompanyDetailsResponseModel().obs,
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

  static void onCompanyTap(CompanyDetailsResponseModel? item) async {
    final localInstance = instance;
    final id = item?.id;
    if (id == null) return;
    localInstance.companyGlobalState.id = id;
    localInstance.companyGlobalState.details = item;
    await Get.toNamed(SippoRoutes.sippoAboutCompanies);
    localInstance.companyGlobalState
        .clearDetails(() => CompanyDetailsResponseModel());
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
