import 'dart:async';

import 'package:get/get.dart';
import 'package:jobspot/JopController/AuthenticationController/sippo_signup_company_controller.dart';
import 'package:jobspot/JopController/ConnectivityController/internet_connection_controller.dart';
import 'package:jobspot/utils/states.dart';

import '../../sippo_data/model/specializations_model/specializations_model.dart';
import '../../sippo_data/specializations/specializations_repo.dart';
import '../../sippo_excepstions/specialization_exception/specialization_exception.dart';

class SpecializationCompanyController extends GetxController {
  var specializations = <SpecializationModel>[].obs;
  final _states = States().obs;

  States get states => _states.value;

  StreamSubscription<bool>? _connectionSubscription;

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

  Future<void> closeConnectionSubscription() async {
    await _connectionSubscription?.cancel();
  }

  void _startListeningToConnection() {
    print("hello 1");
    _connectionSubscription = InternetConnectionController
        .instance.isConnectedStream
        .listen((isConnected) async {
      if (isConnected) {
        print("fetchSpecializations is target");
        await fetchSpecializations();
      }
    });
  }

  @override
  void onInit() {
    (() async {
      await fetchSpecializations();
      _startListeningToConnection();
    })();

    super.onInit();
  }

  Future<void> fetchSpecializations() async {
    try {
      loadingStates = true;
      successStates = false;
      final List<SpecializationModel>? fetchedSpecializations =
          await SpecializationRepo.fetchSpecializations();
      print(fetchedSpecializations);
      if (fetchedSpecializations != null && fetchedSpecializations.isNotEmpty) {
        SignUpCompanyController.instance.companySpecializations =
            fetchedSpecializations;
        successStates = true;
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

  @override
  void onClose() {
    super.onClose();
    closeConnectionSubscription();
  }
}
