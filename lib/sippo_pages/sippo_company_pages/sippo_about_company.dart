import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jobspot/JobGlobalclass/jobstopcolor.dart';
import 'package:jobspot/JobGlobalclass/jobstopfontstyle.dart';
import 'package:jobspot/JobGlobalclass/media_query_sizes.dart';
import 'package:jobspot/JobGlobalclass/sippo_customstyle.dart';
import 'package:jobspot/JobGlobalclass/text_font_size.dart';
import 'package:jobspot/sippo_custom_widget/body_widget.dart';
import 'package:jobspot/sippo_custom_widget/loading_view_widgets/loading_scaffold.dart';
import 'package:jobspot/sippo_custom_widget/widgets.dart';
import 'package:jobspot/utils/validating_input.dart';

import '../../JopController/company_profile_controller/edit_copmany_profile_information_controller.dart';

class SippoAboutCompany extends StatefulWidget {
  const SippoAboutCompany({Key? key}) : super(key: key);

  @override
  State<SippoAboutCompany> createState() => _SippoAboutCompanyState();
}

class _SippoAboutCompanyState extends State<SippoAboutCompany> {
  dynamic size;
  double height = 0.00;
  double width = 0.00;
  final aboutme = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final _controller = Get.put(EditCompanyProfileInfoController());

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.sizeOf(context);
    height = size.height;
    width = size.width;
    return LoadingScaffold(
      controller: _controller.overlayLoadingController,
      appBar: AppBar(),
      body: Form(
        key: _formKey,
        child: BodyWidget(
          isScrollable: true,
          paddingContent: EdgeInsets.symmetric(
            horizontal: width / CustomStyle.paddingValue,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "about_us".tr,
                style: dmsbold.copyWith(
                  fontSize: 16,
                  color: Jobstopcolor.primarycolor,
                ),
              ),
              SizedBox(height: height / CustomStyle.verticalSpaceBetween),
              InputBorderedField(
                verticalPaddingValue: context.fromHeight(
                  CustomStyle.paddingValue,
                ),
                gController: _controller.profileEditState.bio,
                hintText: 'talk_about_company'.tr,
                hintStyle: dmsregular.copyWith(
                  fontSize: FontSize.label(context),
                ),
                maxLine: 8,
                height: height / 2.5,
                validator: ValidatingInput.validateDescription,
              ),
            ],
          ),
          paddingBottom: EdgeInsets.all(
            width / CustomStyle.paddingBottomButton,
          ),
          bottomScreen: CustomButton(
            onTapped: () {
              if (_formKey.currentState == null) return;
              if (_formKey.currentState!.validate()) {
                _controller.onSaveSubmitted();
              }
            },
            text: "save".tr,
          ),
        ),
      ),
    );
  }
}
