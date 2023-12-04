import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jobspot/sippo_custom_widget/widgets.dart';

import '../JobGlobalclass/jobstopcolor.dart';
import '../JobGlobalclass/jobstopfontstyle.dart';

class ConfirmationBottomSheet extends StatelessWidget {
  const ConfirmationBottomSheet({
    super.key,
    required this.title,
    required this.description,
    required this.onUndo,
    required this.onConfirm,
    this.confirmTitle,
    this.undoTitle,
  });

  final String? confirmTitle;
  final String? undoTitle;
  final String title;
  final String description;
  final void Function() onUndo;
  final void Function() onConfirm;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double height = size.height;
    double width = size.width;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: width / 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            title,
            style: dmsbold.copyWith(
              fontSize: 16,
              color: SippoColor.primarycolor,
            ),
          ),
          SizedBox(height: height / 32),
          if (description.trim().isNotEmpty) ...[
            Text(
              description,
              style:
                  dmsregular.copyWith(fontSize: 12, color: SippoColor.darkgrey),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: height / 26),
          ],
          CustomButton(
            onTapped: onConfirm,
            text: confirmTitle ?? "yes".tr,
            backgroundColor: SippoColor.primarycolor,
          ),
          SizedBox(
            height: height / 56,
          ),
          CustomButton(
            onTapped: onUndo,
            text: undoTitle ?? "undo".tr,
            backgroundColor: SippoColor.lightprimary,
          ),
        ],
      ),
    );
  }
}
