import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:jobspot/JobGlobalclass/jobstopcolor.dart';

import '../JobGlobalclass/jobstopfontstyle.dart';
import '../JobGlobalclass/text_font_size.dart';

class SettingItemWidget extends StatelessWidget {
  const SettingItemWidget({
    super.key,
    required this.title,
    this.icon,
    this.trailingIcon = const Icon(Icons.arrow_forward_ios_outlined),
    this.isHavingTrailingIcon = true,
    this.isBordered = true,
    this.contentPadding = 0,
    required this.onTap,
    this.isSelected = false,
  });

  final double contentPadding;
  final Widget? trailingIcon;
  final String title;
  final bool isHavingTrailingIcon;
  final Widget? icon;
  final bool isBordered;
  final void Function() onTap;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double width = size.width;
    return ListTile(
      contentPadding: EdgeInsets.symmetric(horizontal: contentPadding),
      onTap: onTap,
      shape: isBordered
          ? ContinuousRectangleBorder(
              borderRadius: BorderRadius.circular(width / 16),
              side: BorderSide(color: Colors.grey),
            )
          : null,
      leading: icon,
      title: AutoSizeText(
        title,
        style: dmsregular.copyWith(
          fontSize: FontSize.title6(context),
          color: isSelected ? Colors.white : null,
        ),
      ),
      trailing: isHavingTrailingIcon ? trailingIcon : null,
      // selected: isSelected,
      tileColor: isSelected ? Jobstopcolor.primarycolor : null,
    );
  }
}
