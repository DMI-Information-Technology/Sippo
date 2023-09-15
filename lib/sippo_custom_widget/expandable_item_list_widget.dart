import 'package:flutter/material.dart';

import '../JobGlobalclass/jobstopcolor.dart';
import '../JobGlobalclass/jobstopfontstyle.dart';

enum WrapperType { WRAP, VERTICAL }

class ExpandableItemList extends StatelessWidget {
  final itemCount;
  final Widget Function(BuildContext context, int index) itemBuilder;
  final bool isExpandable;
  final bool expandItems;
  final String? expandTitle;
  final String? shrinkTitle;
  final VoidCallback onExpandClicked;
  final Color? titleExpandColor;
  final double? spacing;
  final WrapperType widgetType;
  final bool? alignmentFromStart;

  const ExpandableItemList({
    this.isExpandable = false,
    this.expandItems = false,
    this.titleExpandColor,
    this.spacing = 0.0,
    required this.itemCount,
    required this.itemBuilder,
    required this.onExpandClicked,
    this.expandTitle,
    this.shrinkTitle,
    this.alignmentFromStart,
  }) : widgetType = WrapperType.VERTICAL;

  const ExpandableItemList.wrapBuilder({
    this.isExpandable = false,
    this.expandItems = false,
    this.titleExpandColor,
    this.spacing = 0.0,
    required this.itemCount,
    required this.itemBuilder,
    required this.onExpandClicked,
    this.expandTitle,
    this.shrinkTitle,
    this.alignmentFromStart,
  }) : widgetType = WrapperType.WRAP;

  Widget _wrapperBuilder(BuildContext context, WrapperType wrapperType) {
    final count = expandItems
        ? itemCount
        : itemCount > 0
            ? 1
            : 0;
    List<Widget> listOfWidgets = [
      for (var i = 0; i < count; i++) ...[
        itemBuilder(context, i),
        wrapperType == WrapperType.WRAP
            ? SizedBox(width: spacing)
            : SizedBox(height: spacing),
      ],
      if (isExpandable && itemCount != 0)
        TextButton(
          onPressed: onExpandClicked,
          child: Text(
            expandItems
                ? shrinkTitle ?? 'Show Less'
                : expandTitle ?? 'Show More',
            style: dmsregular.copyWith(
              color: titleExpandColor ?? Jobstopcolor.primarycolor,
            ),
          ),
        ),
    ];
    return switch (wrapperType) {
      WrapperType.WRAP => Wrap(
          crossAxisAlignment: WrapCrossAlignment.start,
          alignment: WrapAlignment.start,
          children: listOfWidgets,
        ),
      WrapperType.VERTICAL => Column(
          crossAxisAlignment: alignmentFromStart == true
              ? CrossAxisAlignment.start
              : CrossAxisAlignment.center,
          children: listOfWidgets,
        ),
    };
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double width = size.width;
    return SizedBox(width: width, child: _wrapperBuilder(context, widgetType));
  }
}
