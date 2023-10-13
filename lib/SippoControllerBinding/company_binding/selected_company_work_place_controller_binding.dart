import 'package:get/get.dart';
import 'package:jobspot/JopController/company_profile_controller/selected_company_work_place_controller.dart';


class SelectedCompanyWorkPlaceBindingController implements Bindings {
  @override
  void dependencies() {
    Get.put<SelectedCompanyWorkPlaceController>(SelectedCompanyWorkPlaceController());
  }

  const SelectedCompanyWorkPlaceBindingController();
}
