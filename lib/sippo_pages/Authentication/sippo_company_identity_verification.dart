import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jobspot/JobGlobalclass/media_query_sizes.dart';
import 'package:jobspot/JobGlobalclass/sippo_customstyle.dart';
import 'package:jobspot/sippo_custom_widget/ConditionalWidget.dart';
import 'package:jobspot/sippo_custom_widget/error_messages_dialog_snackbar/network_connnection_lost_widget.dart';
import 'package:jobspot/sippo_custom_widget/loading_view_widgets/loading_scaffold.dart';

import 'package:jobspot/JobGlobalclass/jobstopcolor.dart';
import 'package:jobspot/JobGlobalclass/jobstopfontstyle.dart';
import 'package:jobspot/JobGlobalclass/jobstopimges.dart';
import 'package:jobspot/JopController/AuthenticationController/sippo_identity_verification_controller.dart';
import 'package:jobspot/sippo_custom_widget/body_widget.dart';
import 'package:jobspot/sippo_custom_widget/widgets.dart';

class SippoCompanyIdentityVerification extends StatelessWidget {
  const SippoCompanyIdentityVerification({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = IdentityVerificationController.instance;
    Size size = MediaQuery.of(context).size;
    double height = size.height;
    double width = size.width;
    return LoadingScaffold(
      controller: controller.loadingController,
      appBar: _buildAppBar(context),
      // appBar: null,
      body: BodyWidget(
        connectionStatusBar: Obx(() => ConditionalWidget(
              !controller.isNetworkConnect,
              guaranteedBuilder: (_, __) => NetworkStatusNonWidget(),
            )),
        isScrollable: true,
        paddingContent: EdgeInsets.symmetric(horizontal: width / 32),
        child: Column(
          children: [
            Obx(() => ConditionalWidget(
                  !controller.isNetworkConnect,
                  guaranteedBuilder: (context, __) => SizedBox(
                    height: context.fromHeight(
                      CustomStyle.connectionLostHeight,
                    ),
                  ),
                )),
            Image.asset(
              JobstopPngImg.passwordimg,
              height: height / 3,
            ),
            SizedBox(height: height / 18),
            _buildPhoneResetPasswordCard(),
            SizedBox(height: height / 18),
            InputField(
              hintText: "Secret_code_hint_text".tr,
              icon: const Icon(Icons.lock_outline),
              onChangedText: (value) => controller.otpCode = value.trim(),
            ),
            _buildResendOtpCodeButton(),
            SizedBox(height: height / 18),
          ],
        ),
        paddingBottom: EdgeInsets.all(width / 32),
        bottomScreen: CustomButton(
          onTapped: () async => await controller.onSubmitSend(),
          text: "send".tr,
        ),
      ),
    );
  }

  Widget _buildPhoneResetPasswordCard() {
    final controller = IdentityVerificationController.instance;
    return Obx(
      () => PhoneResetPasswordCard(
        phoneNumber: controller.phoneNumber,
        description:
            'Secret code message will be sent after ${controller.initTimer}',
        borderColor: Jobstopcolor.primarycolor,
      ),
    );
  }

  Widget _buildResendOtpCodeButton() {
    final controller = IdentityVerificationController.instance;

    return Align(
      alignment: AlignmentDirectional.centerStart,
      child: Obx(
        () => TextButton(
          onPressed: () async {
            await controller.resendOTPClicked();
          },
          child: Text(
            "resend ${controller.isResendTimerNotFinish() ? "after " + controller.resendTimer.toString() : ""}",
          ),
        ),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    // final controller = IdentityVerificationController.instance;
    Size size = MediaQuery.of(context).size;
    double height = size.height;
    return AppBar(
      automaticallyImplyLeading: true,
      title: Text(
        "identity_verification".tr,
        style: dmsbold.copyWith(fontSize: height / 52),
        textAlign: TextAlign.start,
      ),
      backgroundColor: Jobstopcolor.backgroudHome,
    );
  }
}
