import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jobspot/JobGlobalclass/jobstopcolor.dart';
import 'package:jobspot/JobGlobalclass/jobstopfontstyle.dart';
import 'package:jobspot/JobGlobalclass/jobstopimges.dart';
import 'package:jobspot/JopCustomWidget/widgets.dart';

import '../../JobGlobalclass/routes.dart';
import '../../JopController/AuthenticationController/jobstop_signup_company_controller.dart';

class CompanySignUpSpecializations extends StatefulWidget {
  const CompanySignUpSpecializations({super.key});

  @override
  State<CompanySignUpSpecializations> createState() =>
      _CompanySignUpSpecializationsState();
}

class _CompanySignUpSpecializationsState
    extends State<CompanySignUpSpecializations> {

  @override
  void initState() {
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double height = size.height;
    double width = size.width;
    final SignUpCompanyController signUpCompController =
        Get.put(SignUpCompanyController());
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
                    Text(
                      "Company Specializations",
                      style: dmsbold.copyWith(fontSize: height / 25),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: height / 50),
                    Text(
                      "Please choose a few specialties for the company\n(maximum 3)",
                      style: dmsregular.copyWith(fontSize: height / 52),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: height / 50),
                    ListView.separated(
                      itemCount:
                          signUpCompController.companySpecializations.length,
                      itemBuilder: (context, index) {
                        return Obx(
                          () => _buildCheckboxListTile(
                            index,
                            signUpCompController.companySpecializations[index],
                            signUpCompController.isSpecialSelected(index),
                          ),
                        );
                      },
                      separatorBuilder: (context, index) => SizedBox(
                        height: height / 36,
                      ),
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
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
                  onTappeed: () {
                    onConfirmButtonClicked();
                  },
                  text: "confirm".tr),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCheckboxListTile(int index, String title, bool isSelected) {
    final SignUpCompanyController signUpCompController = Get.find();
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(22),
        border: Border.all(
          color: isSelected ? Jobstopcolor.primarycolor : Jobstopcolor.greyyy2,
          width: 2.0,
        ),
        color: isSelected ? Colors.blue.withOpacity(0.2) : null,
      ),
      child: CheckboxListTile(
        title: Text(
          textAlign: TextAlign.start,
          title,
          style: dmsbold.copyWith(
            color: isSelected ? Jobstopcolor.primarycolor : null,
          ),
        ),
        value: isSelected,
        onChanged: (value) {
          signUpCompController.toggleSpecial(index);
        },
        activeColor: Jobstopcolor.primarycolor,
      ),
    );
  }

  void onConfirmButtonClicked() {
    SignUpCompanyController controller = Get.find();
    if (controller.selectedIndices.length == 0 ||
        controller.selectedIndices.length > 3) {
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
    Get.toNamed(JopRoutesPages.locationselector);
  }
}
