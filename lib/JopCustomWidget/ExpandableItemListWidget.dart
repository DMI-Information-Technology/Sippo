import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import '../JobGlobalclass/jobstopcolor.dart';
import '../JobGlobalclass/jobstopfontstyle.dart';

enum WrapperType { WRAP, VERTICAL }

class ExpandableItemList extends StatelessWidget {
  final itemCount;
  final Widget Function(BuildContext context, int index) itemBuilder;
  final bool isExpandable;
  final bool more;
  final VoidCallback onExpandClicked;
  final Color? titleExpandColor;
  final double? spacing;
  final WrapperType widgetType;

  const ExpandableItemList({
    this.isExpandable = false,
    this.more = false,
    this.titleExpandColor,
    this.spacing = 0.0,
    required this.itemCount,
    required this.itemBuilder,
    required this.onExpandClicked,
  }) : widgetType = WrapperType.VERTICAL;

  const ExpandableItemList.wrapBuilder({
    this.isExpandable = false,
    this.more = false,
    this.titleExpandColor,
    this.spacing = 0.0,
    required this.itemCount,
    required this.itemBuilder,
    required this.onExpandClicked,
  }) : widgetType = WrapperType.WRAP;

  Widget _wrapperBuilder(BuildContext context, WrapperType wrapperType) {
    Size size = MediaQuery.of(context).size;
    double width = size.width;
    List<Widget> listOfWidgets = [
      for (var i = 0; i < itemCount; i++) ...[
        itemBuilder(context, i),
        wrapperType == WrapperType.WRAP
            ? SizedBox(width: spacing)
            : SizedBox(height: spacing),
      ],
      if (isExpandable && itemCount != 0)
        TextButton(
          onPressed: onExpandClicked,
          child: Text(
            more ? 'Show Less' : 'Show More',
            style: dmsregular.copyWith(
              color: titleExpandColor ?? Jobstopcolor.grey,
            ),
          ),
        ),
    ];
    switch (wrapperType) {
      case WrapperType.WRAP:
        return SizedBox(
          width: width,
          child: Wrap(
            crossAxisAlignment: WrapCrossAlignment.start,
            alignment: WrapAlignment.start,
            children: listOfWidgets,
          ),
        );
      case WrapperType.VERTICAL:
        return SizedBox(
          width: width,
          child: Column(children: listOfWidgets),
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    return _wrapperBuilder(context, widgetType);
  }
}
