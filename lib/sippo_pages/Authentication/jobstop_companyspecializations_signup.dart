import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jobspot/JobGlobalclass/jobstopcolor.dart';
import 'package:jobspot/JobGlobalclass/jobstopfontstyle.dart';
import 'package:jobspot/JobGlobalclass/jobstopimges.dart';
import 'package:jobspot/JobGlobalclass/text_font_size.dart';
import 'package:jobspot/JopController/AuthenticationController/specialization_list_controller.dart';
import 'package:jobspot/sippo_custom_widget/widgets.dart';

import '../../JobGlobalclass/routes.dart';
import '../../JopController/AuthenticationController/sippo_signup_company_controller.dart';

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
      ),
      body: Column(
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
                      "Company Specializations",
                      style: dmsbold.copyWith(
                        fontSize: FontSize.title2(context),
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: height / 50),
                    AutoSizeText(
                      "Please choose a few specialties for the company\n(maximum 3)",
                      style: dmsregular.copyWith(
                        fontSize: FontSize.paragraph2(context),
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: height / 50),
                    Obx(
                      () {
                        if (!_controller.isNetworkConnected) {
                          return SizedBox.shrink();
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
                                  _controller.companySpecializationsName[index],
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
                text: "confirm".tr,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLoadingSpecialMessage(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Text("Data is fetching from the server..."),
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
        onChanged: (value) {
          _controller.toggleSpecial(index);
        },
        activeColor: Jobstopcolor.primarycolor,
      ),
    );
  }

  void _onConfirmButtonClicked() {
    if (_controller.selectedIndices.length == 0 ||
        _controller.selectedIndices.length > 3) {
      Get.dialog(
        CustomAlertDialog(
          imageAsset: JobstopPngImg.policyaccepted,
          title: "chooce_specialization".tr,
          description: "select_one_three_maximum_special".tr,
          confirmBtnTitle: "ok".tr,
          onConfirm: () {
            Get.back();
          },
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
