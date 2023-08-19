
import 'package:flutter/material.dart';

import '../JobGlobalclass/jobstopfontstyle.dart';
import '../JobGlobalclass/text_font_size.dart';

class SettingItemWidget extends StatelessWidget {
  const SettingItemWidget({
    super.key,
    required this.title,
    this.icon,
    required this.onTap,
  });

  final String title;
  final Widget? icon;
  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double width = size.width;
    return ListTile(
      onTap: onTap,
      shape: ContinuousRectangleBorder(
        borderRadius: BorderRadius.circular(width / 16),
        side: BorderSide(color: Colors.grey),
      ),
      leading: icon,
      title: Text(
        title,
        style: dmsmedium.copyWith(
          fontSize: FontSize.titleFontSize5(context),
        ),
      ),
      trailing: Icon(Icons.arrow_forward_ios_outlined),
    );
  }
}
