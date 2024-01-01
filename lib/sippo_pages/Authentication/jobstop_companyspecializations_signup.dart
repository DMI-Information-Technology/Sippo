import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sippo/JobGlobalclass/jobstopcolor.dart';
import 'package:sippo/JobGlobalclass/jobstopfontstyle.dart';
import 'package:sippo/JobGlobalclass/jobstopimges.dart';
import 'package:sippo/JobGlobalclass/routes.dart';
import 'package:sippo/JobGlobalclass/text_font_size.dart';
import 'package:sippo/JobServices/app_local_language_services/app_local_language_service.dart';
import 'package:sippo/sippo_controller/AuthenticationController/sippo_signup_company_controller.dart';
import 'package:sippo/sippo_controller/AuthenticationController/specialization_list_controller.dart';
import 'package:sippo/sippo_custom_widget/widgets.dart';

class CompanySignUpSpecializations extends StatefulWidget {
  const CompanySignUpSpecializations({super.key});

  @override
  State<CompanySignUpSpecializations> createState() =>
      _CompanySignUpSpecializationsState();
}

class _CompanySignUpSpecializationsState
    extends State<CompanySignUpSpecializations> {
  final _signUpCompController = SignUpCompanyController.instance;
  final _controller = Get.put(SpecializationCompanyController());

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double height = size.height;
    double width = size.width;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        centerTitle: true,
        title: TextButton(
          onPressed: () {
            LocalLanguageService.showChangeLanguageBottomSheet(context);
          },
          child: Text("language".tr),
        ),
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          _controller.fetchSpecializations();
        },
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: width / 26,
                    vertical: height / 50,
                  ),
                  child: Column(
                    children: [
                      AutoSizeText(
                        "company_specializations".tr,
                        style: dmsbold.copyWith(
                          fontSize: FontSize.title2(context),
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: height / 50),
                      AutoSizeText(
                        "choose_few_specialties".tr,
                        style: dmsregular.copyWith(
                          fontSize: FontSize.paragraph2(context),
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: height / 50),
                      Obx(
                        () {
                          if (!_controller.isNetworkConnected) {
                            return Center(
                              child: AutoSizeText(
                                'connection_lost_message_1'.tr,
                                textAlign: TextAlign.center,
                                style: dmsmedium.copyWith(
                                  fontSize: FontSize.title3(context),
                                  color: SippoColor.primarycolor,
                                ),
                              ),
                            );
                          }
                          final state = _controller.states;
                          if (state.isError)
                            return _buildErrorSpecialMessage(
                              state.message.toString(),
                            );
                          if (state.isSuccess)
                            return ListView.separated(
                              itemCount:
                                  _controller.companySpecializationsName.length,
                              itemBuilder: (context, index) {
                                return Obx(
                                  () => _buildCheckboxListTile(
                                    index,
                                    _controller
                                        .companySpecializationsName[index],
                                    _controller.isSpecialSelected(index),
                                  ),
                                );
                              },
                              separatorBuilder: (context, index) => SizedBox(
                                height: height / 36,
                              ),
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                            );
                          return _buildLoadingSpecialMessage(context);
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: height / 50),
                child: CustomButton(
                  onTapped: () {
                    if (!_controller.isConnectionLostWithDialog)
                      _onConfirmButtonClicked();
                  },
                  text: "Confirm".tr,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLoadingSpecialMessage(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text("message_fetching_specializations".tr),
        SizedBox(height: MediaQuery.of(context).size.height / 36),
        const LinearProgressIndicator(),
      ],
    );
  }

  Widget _buildErrorSpecialMessage(String message) {
    return Align(
      alignment: AlignmentDirectional.center,
      child: Text(
        message,
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget _buildCheckboxListTile(int index, String title, bool isSelected) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(22),
        border: Border.all(
          color: isSelected ? SippoColor.primarycolor : Colors.black26,
          width: 2.0,
        ),
        color: isSelected ? Colors.blue.withOpacity(0.2) : Colors.white,
      ),
      child: CheckboxListTile(
        title: AutoSizeText(
          textAlign: TextAlign.start,
          title,
          style: dmsbold.copyWith(
            color: isSelected ? SippoColor.primarycolor : null,
            fontSize: FontSize.title5(context),
          ),
        ),
        value: isSelected,
        onChanged: (value) {
          _controller.toggleSpecial(index);
        },
        activeColor: SippoColor.primarycolor,
      ),
    );
  }

  void _onConfirmButtonClicked() {
    if (_controller.selectedIndices.length == 0 ||
        _controller.selectedIndices.length > 3) {
      final title = "chooce_specialization".tr;
      final desc = "select_one_three_maximum_special".tr;
      Get.dialog(
        CustomAlertDialog(
          imageAsset: JobstopPngImg.policyaccepted,
          title:title,
          description: desc,
          confirmBtnTitle: "ok".tr,
          onConfirm: () => Get.back(),
        ),
      );
      return;
    }
    _signUpCompController.selectedIdSpecializations =
        _controller.selectedIdSpecializations;
    print(_signUpCompController.companyForm);
    Get.toNamed(SippoRoutes.locationselector);
  }
}
