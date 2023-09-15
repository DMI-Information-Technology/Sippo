import 'package:flutter/material.dart';
import 'package:jobspot/sippo_custom_widget/rounded_border_radius_card_widget.dart';

import '../JobGlobalclass/jobstopcolor.dart';
import '../JobGlobalclass/jobstopfontstyle.dart';

class AddInfoProfileCard extends StatelessWidget {
  const AddInfoProfileCard({
    super.key,
    required this.title,
    required this.noInfoProfile,
    this.leading,
    this.profileInfo,
    this.iconAction,
    required this.onAddClicked,
    this.alignmentFromStart,
  });

  final bool? alignmentFromStart;
  final bool noInfoProfile;
  final VoidCallback onAddClicked;
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
          Row(
            children: [
              if (leading != null) leading!,
              SizedBox(
                width: width / 36,
              ),
              Text(
                title,
                style: dmsbold.copyWith(
                    fontSize: 14, color: Jobstopcolor.primarycolor),
              ),
              const Spacer(),
              InkWell(
                onTap: onAddClicked,
                child: iconAction ??
                    CircleAvatar(
                      radius: 10,
                      backgroundColor: Jobstopcolor.lightprimary2,
                      child: Icon(
                        Icons.add,
                        size: 15,
                        color: Jobstopcolor.primarycolor,
                      ),
                    ),
              )
            ],
          ),
          if (!noInfoProfile &&
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
