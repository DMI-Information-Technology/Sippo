import 'package:get/get.dart';
import 'package:jobspot/JopController/AuthenticationController/sippo_signup_company_controller.dart';
import 'package:jobspot/utils/states.dart';

import '../../sippo_data/model/specializations_model/specializations_model.dart';
import '../../sippo_data/specializations/specializations_repo.dart';
import '../../sippo_excepstions/specialization_exception/specialization_exception.dart';

class SpecializationCompanyController extends GetxController {
  var specializations = <SpecializationModel>[].obs;
  final _states = States().obs;

  States get states => _states.value;

  void set loadingStates(bool value) {
    _states.value = _states.value.copyWith(isLoading: value);
  }

  void set successStates(bool value) {
    _states.value = _states.value.copyWith(isSuccess: value);
  }

  void errorStates(bool value, String? message) {
    _states.value = _states.value.copyWith(
      isError: value,
      message: message.toString(),
    );
  }

  @override
  void onInit() {
    (() async {
      await fetchSpecializations();
      SignUpCompanyController.instance.companySpecializations =
          specializations.toList();
    })();
    super.onInit();
  }

  Future<void> fetchSpecializations() async {
    try {
      loadingStates = true;
      final List<SpecializationModel>? fetchedSpecializations =
          await SpecializationRepo.fetchSpecializations();
      print(fetchedSpecializations);
      if (fetchedSpecializations != null && fetchedSpecializations.isNotEmpty) {
        successStates = true;
        specializations.assignAll(fetchedSpecializations);
      } else {
        throw FailedFetchingSpecializationException();
      }
    } on FailedFetchingSpecializationException catch (e) {
      print(e);
      errorStates(true, e.toString());
    } catch (e) {
      print(e);
      errorStates(true, e.toString());
    } finally {
      loadingStates = false;
    }
  }
}
