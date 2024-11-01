import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sippo/JobGlobalclass/jobstopcolor.dart';
import 'package:sippo/JobGlobalclass/jobstopfontstyle.dart';
import 'package:sippo/JobGlobalclass/media_query_sizes.dart';
import 'package:sippo/JobGlobalclass/sippo_customstyle.dart';
import 'package:sippo/JobGlobalclass/text_font_size.dart';
import 'package:sippo/sippo_controller/user_profile_controller/edit_profile_information_controller.dart';
import 'package:sippo/sippo_custom_widget/body_widget.dart';
import 'package:sippo/sippo_custom_widget/loading_view_widgets/loading_scaffold.dart';
import 'package:sippo/sippo_custom_widget/widgets.dart';
import 'package:sippo/utils/validating_input.dart';

class SippoUserAbout extends StatefulWidget {
  const SippoUserAbout({Key? key}) : super(key: key);

  @override
  State<SippoUserAbout> createState() => _SippoUserAboutState();
}

class _SippoUserAboutState extends State<SippoUserAbout> {
  final _formKey = GlobalKey<FormState>();
  final _controller = Get.put(EditProfileInfoController());

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    double height = size.height;
    double width = size.width;
    return LoadingScaffold(
      controller: _controller.loadingOverlayController,
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
                "label_about_me".tr,
                style: dmsbold.copyWith(
                  fontSize: 16,
                  color: SippoColor.primarycolor,
                ),
              ),
              SizedBox(height: height / CustomStyle.verticalSpaceBetween),
              InputBorderedField(
                maxLength: 256,
                showCounter: true,
                gController: _controller.profileEditState.bio,
                verticalPaddingValue: context.fromHeight(
                  CustomStyle.paddingValue,
                ),
                hintText: 'hint_text_about_me'.tr,
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
