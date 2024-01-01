import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sippo/JobGlobalclass/jobstopfontstyle.dart';
import 'package:sippo/JobGlobalclass/jobstopimges.dart';
import 'package:sippo/JobGlobalclass/media_query_sizes.dart';
import 'package:sippo/JobGlobalclass/sippo_customstyle.dart';
import 'package:sippo/JobGlobalclass/text_font_size.dart';
import 'package:sippo/core/profile_completion_manager.dart';
import 'package:sippo/sippo_custom_widget/list_item_text.dart';
import 'package:sippo/sippo_custom_widget/widgets.dart';

class ProfileCompletionController extends ChangeNotifier {
  var _percentage = 0.0;

  double get percentage => _percentage;

  ProfileCompletionController(double percentage)
      : this._percentage = percentage;

  void updateCompletion(double value) {
    this._percentage = value;
    notifyListeners();
  }

  void updateCompletionLength(int length) {
    _percentage =
        ProfileCompletionManager.calculateCompletionPercentageLength(length);
    notifyListeners();
  }

  @override
  void dispose() {
    super.dispose();
  }
}

class ProfileCompletionWidget<T> extends StatelessWidget {
  const ProfileCompletionWidget({
    super.key,
    required this.controller,
    this.profile,
    this.onTap,
    this.title,
    this.description,
  });

  final Function(Map<String, String> profile)? onTap;
  final Map<String, String>? profile;
  final ProfileCompletionController controller;
  final String? title;
  final String? description;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        // onTap!(profile ?? {});
        if (onTap != null) onTap!(profile ?? {});
        _showProfileCompletionDialog(context, profile ?? {});
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadiusDirectional.all(Radius.circular(25)),
          image: DecorationImage(
            fit: BoxFit.cover,
            image: AssetImage(
              JobstopPngImg.profileComp,
            ),
          ),
        ),
        width: context.width,
        padding: EdgeInsets.all(context.fromHeight(CustomStyle.paddingValue)),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    textAlign: TextAlign.start,
                    title ?? '',
                    style: dmsbold.copyWith(
                      fontSize: FontSize.title4(context),
                      color: Colors.white,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(
                    height: context.fromHeight(CustomStyle.huge2),
                  ),
                  Text(
                    textAlign: TextAlign.start,
                    description??'',
                    style: dmsregular.copyWith(
                      fontSize: FontSize.paragraph2(context),
                      color: Colors.white,
                    ),
                    maxLines: 4,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            SizedBox(width: context.fromWidth(CustomStyle.m)),
            CircleCompletionPercentageWidget(
              circleIndicatorColor: Colors.white,
              controller: controller,
            ),
          ],
        ),
      ),
    );
  }

  void _showProfileCompletionDialog(
    BuildContext context,
    Map<String, String> messages,
  ) {
    Get.dialog(
      Dialog(
        shape: ContinuousRectangleBorder(
          borderRadius: BorderRadius.circular(context.height / 32),
        ),
        child: Padding(
          padding: EdgeInsets.all(context.fromWidth(CustomStyle.s)),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'profile_completion_title'.tr,
                style: dmsbold.copyWith(
                  fontSize: FontSize.title3(context),
                ),
              ),
              SizedBox(height: context.fromHeight(CustomStyle.xxxl)),
              ...messages.keys.map(
                (key) {
                  return _buildNotCompletionMessage(
                    context,
                    key,
                    messages[key] ?? "",
                  );
                },
              ).toList(),
              SizedBox(height: context.fromHeight(CustomStyle.xxxl)),
              SizedBox(
                width: context.width / 3,
                height: context.height / 21,
                child: CustomButton(
                  onTapped: () => Navigator.of(context).pop(),
                  text: "ok".tr,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNotCompletionMessage(
      BuildContext context, String title, String message) {
    return ListTextItem(
      text: message,
      onTap: () {},
      startCrossAlignment: true,
      fontSize: FontSize.paragraph(context),
    );
  }
}

class CircleCompletionPercentageWidget extends StatelessWidget {
  final ProfileCompletionController controller;
  final Color? circleIndicatorColor;
  final double? strokeWidth;

  const CircleCompletionPercentageWidget({
    super.key,
    required this.controller,
    this.circleIndicatorColor,
    this.strokeWidth,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ListenableBuilder(
        listenable: controller,
        builder: (context, child) {
          return Stack(
            alignment: Alignment.center,
            children: [
              SizedBox(
                width: context.width / 4,
                height: context.width / 4,
                child: CircularProgressIndicator(
                  value: controller.percentage / 100,
                  strokeWidth: strokeWidth ?? 10,
                  color: circleIndicatorColor,
                ),
              ),
              Text(
                '${controller.percentage}%',
                style: dmsbold.copyWith(
                  fontSize: FontSize.title2(context),
                  color: circleIndicatorColor,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          );
        },
      ),
    );
  }
}
