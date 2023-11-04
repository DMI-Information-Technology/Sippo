import 'dart:async';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jobspot/JobGlobalclass/jobstopcolor.dart';
import 'package:jobspot/JobGlobalclass/jobstopfontstyle.dart';
import 'package:jobspot/JobGlobalclass/media_query_sizes.dart';
import 'package:jobspot/JobGlobalclass/sippo_customstyle.dart';
import 'package:jobspot/JobGlobalclass/text_font_size.dart';
import 'package:jobspot/JobServices/ConnectivityController/internet_connection_controller.dart';
import 'package:jobspot/custom_app_controller/switch_status_controller.dart';
import 'package:jobspot/sippo_controller/dashboards_controller/company_dashboard_controller.dart';
import 'package:jobspot/sippo_custom_widget/body_widget.dart';
import 'package:jobspot/sippo_custom_widget/loading_view_widgets/loading_scaffold.dart';
import 'package:jobspot/sippo_custom_widget/success_message_widget.dart';
import 'package:jobspot/sippo_custom_widget/widgets.dart';
import 'package:jobspot/sippo_data/company_repos/company_profile_info_repo.dart';
import 'package:jobspot/sippo_data/model/auth_model/company_response_details.dart';
import 'package:jobspot/sippo_data/model/specializations_model/specializations_model.dart';
import 'package:jobspot/sippo_data/specializations/specializations_repo.dart';
import 'package:jobspot/utils/helper.dart';
import 'package:jobspot/utils/states.dart';

class EditAddSpecializationCompanyController extends GetxController {
  CompanyDetailsModel get company =>
      CompanyDashBoardController.instance.company;
  final loadingOverly = SwitchStatusController();

  bool get isModifyStateChanged =>
      modifyStates.isError || modifyStates.isWarning;
  final _fetchStates = States().obs;

  States get fetchStates => _fetchStates.value;

  void set fetchStates(States state) => _fetchStates.value = state;
  final _modifyStates = States().obs;

  States get modifyStates => _modifyStates.value;

  void set modifyStates(States state) => _modifyStates.value = state;

  void resetState() => _modifyStates.value = States();
  final _specializations = <SpecializationModel>[].obs;

  bool get isNetworkConnected => InternetConnectionService.instance.isConnected;

  List<SpecializationModel> get specializations => _specializations.toList();

  int get specializationsLength => _specializations.length;

  set specializations(List<SpecializationModel> value) {
    _specializations.value = value;
  }

  final _selectedSpecialization = <SpecializationModel>[].obs;

  List<SpecializationModel> get selectedSpecialization {
    return _selectedSpecialization.toList();
  }

  void set selectedSpecialization(List<SpecializationModel> value) {
    _selectedSpecialization.value = value;
  }

  bool isSpecialSelected(SpecializationModel value) {
    return _specializations.firstWhereOrNull(
          (e) => e.id == value.id,
        ) !=
        null;
  }

  bool fromSelectedSpecial(SpecializationModel value) {
    return _selectedSpecialization.firstWhereOrNull(
          (e) => e.id == value.id,
        ) !=
        null;
  }

  void toggleSpecialization(SpecializationModel value) {
    if (fromSelectedSpecial(value)) {
      return _selectedSpecialization.removeWhere(
        (e) => e.id == value.id,
      );
    }
    _selectedSpecialization.add(value);
  }

  Future<void> fetchSpecializations() async {
    if (!isNetworkConnected) return;
    fetchStates = States(isLoading: true);
    final response = await SpecializationRepo.fetchSpecializationsResource();
    fetchStates = States(isLoading: false);
    await response?.checkStatusResponse(
      onSuccess: (data, statusType) {
        if (data != null) {
          specializations = data;
          fetchStates = States(isSuccess: true);
        }
      },
      onValidateError: (validateError, statusType) {
        fetchStates = States(isError: true, message: validateError?.message);
      },
      onError: (message, statusType) {
        fetchStates = States(isError: true, message: message);
      },
    );
  }

  Future<void> updateSpecializations() async {
    if (!isNetworkConnected) return;
    if (modifyStates.isLoading) return;
    if (selectedSpecialization.length == 0 ||
        selectedSpecialization.length > 3) {
      _modifyStates(
        States(
          isError: true,
          message: 'You have pick one specialization at least and maximum 3.',
        ),
      );
      return;
    }
    if (listEquality(selectedSpecialization, company.specializations)) {
      _modifyStates(
        States(
          isWarning: true,
          message: 'Nothing is Changed in Specializations.',
        ),
      );
      return;
    }
    modifyStates = States(isLoading: true);
    final response = await EditCompanyProfileInfoRepo.updateCompanyProfile(
      company.copyWith(
        specializations: selectedSpecialization,
      ),
    );
    modifyStates = States(isLoading: false);

    await response.checkStatusResponse(
      onSuccess: (data, _) async {
        if (data == null ||
            data.specializations == null ||
            data.specializations!.isEmpty) {
          CompanyDashBoardController.instance.refreshUserProfileInfo();
        } else {
          CompanyDashBoardController.instance.company = data;
        }
        Get.dialog(
          CustomAlertDialog(
            title: 'Specializations Company',
            description: 'Specializations is Added Successfully.',
            confirmBtnTitle: 'ok'.tr,
            onConfirm: () => {if (Get.isOverlaysOpen) Get.back()},
          ),
        ).then((_) => Get.back());
      },
      onValidateError: (validateError, _) {
        modifyStates = States(isError: true, message: validateError?.message);
      },
      onError: (message, _) {
        modifyStates = States(isError: true, message: message);
      },
    );
  }

  StreamSubscription<States>? fetchStateStubs;
  StreamSubscription<States>? modifyStatesSubs;

  @override
  void onInit() {
    fetchStateStubs = _fetchStates.listen((value) {
      if (value.isLoading) {
        loadingOverly.start();
      } else {
        loadingOverly.pause();
      }
    });
    modifyStatesSubs = _modifyStates.listen((value) {
      if (value.isLoading) {
        loadingOverly.start();
      } else {
        loadingOverly.pause();
      }
    });
    selectedSpecialization =
        company.specializations?.toList() ?? selectedSpecialization;
    fetchSpecializations();
    super.onInit();
  }

  @override
  void onClose() {
    fetchStateStubs?.cancel();
    modifyStatesSubs?.cancel();
    super.onClose();
  }
}

class EditAddSpecializationCompany extends StatefulWidget {
  const EditAddSpecializationCompany({super.key});

  @override
  State<EditAddSpecializationCompany> createState() =>
      _EditAddSpecializationCompanyState();
}

class _EditAddSpecializationCompanyState
    extends State<EditAddSpecializationCompany> {
  final _controller = Get.put(EditAddSpecializationCompanyController());

  @override
  Widget build(BuildContext context) {
    return LoadingScaffold(
      controller: _controller.loadingOverly,
      appBar: AppBar(
        backgroundColor: Jobstopcolor.backgroudHome,
        titleSpacing: 0.0,
        title: Text(
          'Specialization Company',
          style: dmsregular.copyWith(
            fontSize: FontSize.title4(context),
          ),
        ),
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          _controller.fetchSpecializations();
        },
        child: BodyWidget(
          paddingContent: EdgeInsets.symmetric(
            horizontal: context.fromWidth(CustomStyle.paddingValue),
          ),
          child: Obx(() {
            if (_controller.fetchStates.isLoading)
              return const SizedBox.shrink();
            if (_controller.fetchStates.isSuccess &&
                _controller.specializationsLength > 0)
              return Obx(() {
                final isStateChanged = _controller.isModifyStateChanged;
                return ListView.separated(
                  itemBuilder: (context, index) {
                    return Obx(() {
                      if (isStateChanged && index == 0) {
                        if (_controller.modifyStates.isWarning)
                          return CardNotifyMessage.warning(
                            state: _controller.modifyStates,
                            onCancelTap: () => _controller.resetState(),
                            bottomSpaceValue: 0.0,
                          );
                        if (_controller.modifyStates.isError)
                          return CardNotifyMessage.error(
                            state: _controller.modifyStates,
                            onCancelTap: () => _controller.resetState(),
                            bottomSpaceValue: 0.0,
                          );
                      }
                      final item = _controller
                          .specializations[index - (isStateChanged ? 1 : 0)];
                      return SelectedSpecializationCardWidget(
                        title: item.name ?? "",
                        isSelected: _controller.fromSelectedSpecial(item),
                        tapToggle: (value) {
                          _controller.toggleSpecialization(item);
                        },
                      );
                    });
                  },
                  separatorBuilder: (context, index) {
                    return SizedBox(
                      height: context.fromHeight(CustomStyle.spaceBetween),
                    );
                  },
                  itemCount: _controller.specializationsLength +
                      (isStateChanged ? 1 : 0),
                );
              });
            return Center(
              child: Text(
                'No specializations is found, Reload the page.',
                maxLines: 2,
                textAlign: TextAlign.center,
                style: dmsbold.copyWith(
                  color: Jobstopcolor.primarycolor,
                  fontSize: FontSize.title3(context),
                ),
              ),
            );
          }),
          paddingBottom: EdgeInsets.all(
            context.fromWidth(CustomStyle.paddingValue),
          ),
          bottomScreen: CustomButton(
              onTapped: () {
                _controller.updateSpecializations();
              },
              text: 'save'.tr),
        ),
      ),
    );
  }
}

class SelectedSpecializationCardWidget extends StatelessWidget {
  const SelectedSpecializationCardWidget({
    super.key,
    required this.isSelected,
    required this.title,
    required this.tapToggle,
  });

  final String title;
  final bool isSelected;
  final void Function(bool? value) tapToggle;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(22),
        border: Border.all(
          color: isSelected ? Jobstopcolor.primarycolor : Colors.black26,
          width: 2.0,
        ),
        color: isSelected ? Colors.blue.withOpacity(0.2) : Colors.white,
      ),
      child: CheckboxListTile(
        title: AutoSizeText(
          textAlign: TextAlign.start,
          title,
          style: dmsbold.copyWith(
            color: isSelected ? Jobstopcolor.primarycolor : null,
            fontSize: FontSize.title5(context),
          ),
        ),
        value: isSelected,
        onChanged: tapToggle,
        activeColor: Jobstopcolor.primarycolor,
      ),
    );
  }
}
