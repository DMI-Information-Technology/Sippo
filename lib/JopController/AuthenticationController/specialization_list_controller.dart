import 'dart:async';

import 'package:get/get.dart';
import 'package:jobspot/JobServices/ConnectivityController/internet_connection_controller.dart';

import 'package:jobspot/utils/states.dart';

import 'package:jobspot/sippo_data/model/specializations_model/specializations_model.dart';
import 'package:jobspot/sippo_data/specializations/specializations_repo.dart';
import 'package:jobspot/sippo_excepstions/specialization_exception/specialization_exception.dart';

class SpecializationCompanyController extends GetxController {
  final _netController = InternetConnectionService.instance;

  bool get isNetworkConnected => _netController.isConnected;

  bool get isConnectionLostWithDialog =>
      _netController.isConnectionLostWithDialog();
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

  void errorStates(bool value, [String? message]) {
    _states.value = _states.value.copyWith(
      isError: value,
      message: message.toString(),
    );
  }

  void _startListeningToConnection() async {
    _connectionSubscription = _netController.isConnectedStream.listen(
      (isConnected) async {
        if (isConnected) {
          await fetchSpecializations();
        }
      },
    );
    await fetchSpecializations();
  }

  final _companySpecializations = [
    SpecializationModel(id: 12, name: 'Item 2'),
    SpecializationModel(id: 15, name: 'Item 3'),
    SpecializationModel(id: 13, name: 'Item 4'),
    SpecializationModel(id: 14, name: 'Item 5'),
  ].obs;

  void set companySpecializations(List<SpecializationModel> value) {
    _companySpecializations.assignAll(value);
  }

  final _selectedSpecialIndices = <int>[].obs;

  List<String> get companySpecializationsName {
    final result = _companySpecializations.isNotEmpty
        ? _companySpecializations.map((e) => e.name).toList()
        : [];
    final newList = <String>[];
    for (var i in result) if (i != null) newList.add(i);

    return newList;
  }

  List<int> get selectedIdSpecializations {
    final result = _companySpecializations.isNotEmpty
        ? selectedIndices.map((e) => _companySpecializations[e].id).toList()
        : <int>[];
    final newList = <int>[];
    for (var i in result) if (i != null) newList.add(i);
    return newList;
  }

  List<int> get selectedIndices => _selectedSpecialIndices.toList();

  void toggleSpecial(int index) {
    if (_selectedSpecialIndices.contains(index))
      _selectedSpecialIndices.remove(index);
    else
      _selectedSpecialIndices.add(index);
  }

  bool isSpecialSelected(int index) => _selectedSpecialIndices.contains(index);

  @override
  void onInit() {
    _startListeningToConnection();
    super.onInit();
  }

  Future<void> fetchSpecializations() async {
    try {
      loadingStates = true;
      successStates = false;
      errorStates(false);
      final List<SpecializationModel>? fetchedSpecializations =
          await SpecializationRepo.fetchSpecializations();
      print(fetchedSpecializations);

      if (fetchedSpecializations != null && fetchedSpecializations.isNotEmpty) {
        _companySpecializations.value = fetchedSpecializations;
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
    _connectionSubscription?.cancel();
    super.onClose();
  }
}
