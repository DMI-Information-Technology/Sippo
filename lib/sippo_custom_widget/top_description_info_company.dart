import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:jobspot/JobGlobalclass/media_query_sizes.dart';

import '../JobGlobalclass/jobstopcolor.dart';
import '../JobGlobalclass/jobstopfontstyle.dart';
import '../JobGlobalclass/sippo_customstyle.dart';

class TopDescriptionInfoCompanyWidget extends StatelessWidget {
  const TopDescriptionInfoCompanyWidget(
      {super.key, this.startText, this.middleText, this.endText});

  final String? startText;
  final String? middleText;
  final String? endText;

  bool isTextBlank(String? text) => text == null || text.trim().isEmpty;

  bool isTextNotBlank(String? text) => !isTextBlank(text);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (isTextNotBlank(startText))
          Expanded(
            child: AutoSizeText(
              textAlign: TextAlign.center,
              this.startText ?? "",
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: dmsmedium.copyWith(color: Jobstopcolor.secondary),
            ),
          ),
        if (isTextNotBlank(startText) && isTextNotBlank(middleText))
          DotWith.ensSpace,
        if (isTextNotBlank(middleText))
          Expanded(
            child: AutoSizeText(
              textAlign: TextAlign.center,
              middleText ?? "Libya, Tripoli, Ain-zara, El-sedra",
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
              style: dmsmedium.copyWith(color: Jobstopcolor.secondary),
            ),
          )
        else if (isTextNotBlank(startText) && isTextNotBlank(endText))
          DotWith.noneSpace,
        if (isTextNotBlank(middleText) && isTextNotBlank(endText))
          DotWith.startSpace,
        if (isTextNotBlank(endText))
          Expanded(
            child: AutoSizeText(
              textAlign: TextAlign.center,
              endText ?? "99999999 days ago",
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: dmsmedium.copyWith(color: Jobstopcolor.secondary),
            ),
          ),
      ],
    );
  }
}

enum Direction {
  none,
  start,
  end,
  top,
  bottom;

  const Direction();
}

class DotWith extends StatelessWidget {
  const DotWith._({this.dir = Direction.start});

  static const startSpace = const DotWith._(dir: Direction.start);
  static const ensSpace = const DotWith._(dir: Direction.end);
  static const noneSpace = const DotWith._(dir: Direction.none);
  final Direction dir;

  Widget _buildDotLayout(BuildContext context) {
    return switch (dir) {
      Direction.none => CircleAvatar(
          backgroundColor: Jobstopcolor.primarycolor,
          radius: context.fromHeight(CustomStyle.huge2),
        ),
      Direction.start => Row(children: [
          SizedBox(
            width: context.fromWidth(CustomStyle.paddingValue),
          ),
          CircleAvatar(
            backgroundColor: Jobstopcolor.primarycolor,
            radius: context.fromHeight(CustomStyle.huge2),
          ),
        ]),
      Direction.end => Row(children: [
          CircleAvatar(
            backgroundColor: Jobstopcolor.primarycolor,
            radius: context.fromHeight(CustomStyle.huge2),
          ),
          SizedBox(
            width: context.fromWidth(CustomStyle.paddingValue),
          ),
        ]),
      Direction.top => Column(),
      Direction.bottom => Column(),
    };
  }

  @override
  Widget build(BuildContext context) {
    return _buildDotLayout(context);
  }
}
