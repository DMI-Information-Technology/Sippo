import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jobspot/JobGlobalclass/media_query_sizes.dart';
import 'package:jobspot/sippo_custom_widget/widgets.dart';

import '../JobGlobalclass/jobstopfontstyle.dart';
import '../JobGlobalclass/sippo_customstyle.dart';
import '../JobGlobalclass/text_font_size.dart';
import '../custom_app_controller/switch_status_controller.dart';
import 'body_widget.dart';
import 'circular_image.dart';
import 'loading_view_widgets/loading_scaffold.dart';

class SaveImagePageView extends StatelessWidget {
  SaveImagePageView({
    super.key,
    required this.imageFile,
    required this.onUpdateTapped,
  });

  final File imageFile;
  final Future<void> Function(
    SwitchStatusController loadingUpdateImageController,
  ) onUpdateTapped;
  final loadingUpdateImageController = SwitchStatusController();

  @override
  Widget build(BuildContext context) {
    return LoadingScaffold(
      controller: loadingUpdateImageController,
      appBar: AppBar(
        titleSpacing: 0.0,
        title: Text(
          "Update Profile Image",
          style: dmsmedium.copyWith(fontSize: FontSize.title5(context)),
        ),
      ),
      body: BodyWidget(
        paddingContent: EdgeInsets.symmetric(
          horizontal: context.fromWidth(CustomStyle.paddingValue),
          vertical: context.fromHeight(CustomStyle.paddingValue),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircularImage.file(
              imageFile,
              size: context.height / 5,
            ),
            SizedBox(
              height: context.fromHeight(CustomStyle.spaceBetween),
            ),
            Text(
              "The New Profile Image",
              style: dmsbold.copyWith(
                fontSize: FontSize.title3(context),
              ),
            ),
          ],
        ),
        paddingBottom: EdgeInsets.all(
          context.fromWidth(CustomStyle.paddingValue),
        ),
        bottomScreen: CustomButton(
          onTapped: () async {
            onUpdateTapped(loadingUpdateImageController);
            loadingUpdateImageController.dispose();
            Navigator.of(context).pop();
          },
          text: "Update",
        ),
      ),
    );
  }
}