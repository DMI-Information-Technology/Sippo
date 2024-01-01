import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:sippo/JobGlobalclass/media_query_sizes.dart';

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

  int _calculateTextFlexibility(String text, List<String> textList) {
    if ([startText, middleText, endText].where((e) => e != null).length >=3)
      return 1;
    // if (textList.where((e) => e.trim().isNotEmpty).length == 0) return 1;
    if (textList.where((e) => e.trim().isNotEmpty).every((e) {
      final l1 = text.trim().length;
      final l2 = e.trim().length;

      return ((l1 / 2).floor() > l2);
    })) {
      return 2;
    }
    return 1;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (isTextNotBlank(startText))
          Expanded(
            flex: _calculateTextFlexibility(startText!, [
              middleText ?? '',
              endText ?? '',
            ]),
            child: AutoSizeText(
              textAlign: TextAlign.center,
              this.startText ?? "",
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: dmsmedium.copyWith(color: SippoColor.secondary),
            ),
          ),
        if (isTextNotBlank(startText) && isTextNotBlank(middleText))
          DotWith.ensSpace,
        if (isTextNotBlank(middleText))
          Expanded(
            flex: _calculateTextFlexibility(middleText!, [
              startText ?? '',
              endText ?? '',
            ]),
            child: AutoSizeText(
              textAlign: TextAlign.center,
              middleText ?? "Libya, Tripoli, Ain-zara, El-sedra",
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
              style: dmsmedium.copyWith(color: SippoColor.secondary),
            ),
          )
        else if (isTextNotBlank(startText) && isTextNotBlank(endText))
          DotWith.noneSpace,
        if (isTextNotBlank(middleText) && isTextNotBlank(endText))
          DotWith.startSpace,
        if (isTextNotBlank(endText))
          Expanded(
            flex: _calculateTextFlexibility(endText!, [
              startText ?? '',
              middleText ?? '',
            ]),
            child: AutoSizeText(
              textAlign: TextAlign.center,
              endText ?? "99999999 days ago",
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: dmsmedium.copyWith(color: SippoColor.secondary),
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
          backgroundColor: SippoColor.primarycolor,
          radius: context.fromHeight(CustomStyle.huge2),
        ),
      Direction.start => Row(children: [
          SizedBox(
            width: context.fromWidth(CustomStyle.paddingValue),
          ),
          CircleAvatar(
            backgroundColor: SippoColor.primarycolor,
            radius: context.fromHeight(CustomStyle.huge2),
          ),
        ]),
      Direction.end => Row(children: [
          CircleAvatar(
            backgroundColor: SippoColor.primarycolor,
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
