import 'package:flutter/material.dart';
import 'package:jobspot/JobGlobalclass/text_font_size.dart';
import 'package:jobspot/sippo_custom_widget/rounded_border_radius_card_widget.dart';

import '../JobGlobalclass/jobstopcolor.dart';
import '../JobGlobalclass/jobstopfontstyle.dart';

class AddInfoProfileCard extends StatelessWidget {
  const AddInfoProfileCard({
    super.key,
    required this.title,
    required this.hasNotInfoProfile,
    this.leading,
    this.profileInfo,
    this.iconAction,
    this.onAddClicked,
    this.alignmentFromStart,
    this.isCompanyView = false,
  });

  final bool isCompanyView;
  final bool? alignmentFromStart;
  final bool hasNotInfoProfile;
  final VoidCallback? onAddClicked;
  final String title;
  final Widget? leading;
  final List<Widget>? profileInfo;
  final Widget? iconAction;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double height = size.height;
    double width = size.width;
    return RoundedBorderRadiusCardWidget(
      paddingType: PaddingType.all,
      child: Column(
        crossAxisAlignment: alignmentFromStart == true
            ? CrossAxisAlignment.start
            : CrossAxisAlignment.center,
        children: [
          InkWell(onTap: onAddClicked,
            child: Row(
              children: [
                if (leading != null) leading!,
                SizedBox(
                  width: width / 36,
                ),
                Text(
                  title,
                  style: dmsbold.copyWith(
                      fontSize: FontSize.title5(context), color: Jobstopcolor.primarycolor),
                ),
                if (!isCompanyView) ...[
                  const Spacer(),
                  iconAction ??
                      CircleAvatar(
                        radius: 10,
                        backgroundColor: Jobstopcolor.lightprimary2,
                        child: Icon(
                          Icons.add,
                          size: 15,
                          color: Jobstopcolor.primarycolor,
                        ),
                      )
                ]
              ],
            ),
          ),
          if (!hasNotInfoProfile &&
              profileInfo != null &&
              profileInfo!.isNotEmpty) ...[
            SizedBox(
              height: height / 100,
            ),
            const Divider(
              color: Jobstopcolor.grey,
            ),
            ...profileInfo!
          ]
        ],
      ),
    );
  }
}
